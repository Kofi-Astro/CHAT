const express = require('express');
const router = express.Router();
const multer = require("multer");

const path = require("path");

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
            cb(new Error('Invalid file type. '));
        }
    }, limits: {
        fileSize: 20 * 1024 * 1024 // max size of uploaded files
    }
});

router.route('/upload').post(upload.single('file'), (req, res) => {
    try {
        res.json({ path: req.file.filename, })

    } catch (error) {
        return res.json({ error: error });
    }
});

module.exports = router;