const express = require('express');
const router = express.Router();



const UserController = require('./controllers/userController');
const ChatController = require('./controllers/chatController');

const userMiddleware = require('./middlewares/auth/user');

const middlewares = {
	user: userMiddleware
}


// ####################################################################################?



const multer = require("multer");
const path = require("path");

// File upload setup
const storage = multer.diskStorage({
	destination: (req, file, cb) => {
		cb(null, path.join(__dirname, '../uploads'));
	},
	filename: (req, file, cb) => {
		cb(null, Date.now() + '_' + file.originalname);
	},
})

const upload = multer({
	storage: storage,
	fileFilter: (req, file, cb) => {
		const allowedMimeTypes = ['image/jpeg', 'image/jpg', 'image/png', 'video/mp4', 'audio/mpeg', 'application/pdf'];

		if (allowedMimeTypes.includes(file.mimetype)) {
			cb(null, true);
		} else {
			cb(new Error('Invalid file type.'));
		}
	}, limits: {
		fileSize: 20 * 1024 * 1024 // max size of uploaded files
	}
});

// ##########################################################################


 
router.get('/', (req, res) => {
	return res.json({
		warn: 'me',
	})
});

router.post('/auth', UserController.login);

router.post('/user', UserController.create);

router.get('/users', [middlewares.user], UserController.getUsers);

router.get('/chats', [middlewares.user], ChatController.getChats);

router.get('/chats/user/:userId', [middlewares.user], ChatController.getChatByUserId);
router.post('/chats/:chatId/message', [middlewares.user], ChatController.sendMessage);
router.post('/chats/:chatId/read', [middlewares.user], ChatController.readChat);
router.post('/fcm-token', [middlewares.user], UserController.saveFcmToken);


// File upload endpoint
router.post('/chats/uploadFile', upload.single('file'), (req, res) => {
	try {
		res.json({ path: req.file.filename });

	} catch (error) {
		console.error('This is the file upload error: ', error);
		return res.json({ error: error });
	}
});


module.exports = router;
















// //Sending of file attachments
// router.post('/chats/uploadFiles', [middlewares.user], ChatController.sendFiles);





























// // ###########################################################################
// // Sending of files
// const multer = require("multer");
// const path = require("path");


// const storage = multer.diskStorage({
// 	destination: (req, file, cb) => {
// 		cb(null, path.join(__dirname, '../uploads'));
// 	},
// 	filename: (req, file, cb) => {
// 		cb(null, Date.now() + '_' + file.originalname);
// 	},
// })


// const upload = multer({
// 	storage: storage,
// 	fileFilter: (req, file, cb) => {
// 		const allowedMimeTypes = ['image/jpeg', 'image/jpg', 'image/png', 'video/mp4', 'audio/mpeg', 'application/pdf'];

// 		if (allowedMimeTypes.includes(file.mimetype)) {
// 			cb(null, true);
// 		} else {
// 			cb(new Error('Invalid file type. '));
// 		}
// 	}, limits: {
// 		fileSize: 20 * 1024 * 1024 // max size of uploaded files
// 	}
// });




// // ####3#######################################################################








// const express = require('express');
// const router = express.Router();
// const multer = require("multer");

// const storage= multer.diskStorage({destination: (req, file, cb)=>{
// 	cb(null, './uploads');
// },
// filename:(req, file, cb)=>{
// 	cb(null, Date.now()+'.jpg')
// },
// })


// const upload = multer({
// 	storage: storage,
// });

// router.route('/addimage').post(upload.single('img'),(req, res)=>{
// 	try {
// res.json({path: req.file.filename,})
		
// 	} catch (error) {
// 		return res.json({error:error});
// 	}
// });

// module.exports = router;