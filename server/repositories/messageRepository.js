const { deleteRecievedMessages } = require('../controllers/messageController');
const Message = require('../models/message');
const ObjectId = require('mongoose').Types.ObjectId;

class MessageRepository {
    async create({ chatId, from, to, text }) {
        return await Message.create({
            chatId,
            from,
            to,
            message,
        });
    }

    async get(userId) {
        return await Message.find({ to: new ObjectId(userId) }).populate('from').populate('to');
    }

    async setTriedToGet(_id) {
        await Message.findByIdAndUpdate(_id, {
            $set: {
                triedToGet: true
            }
        });
    }

    async delete(_id, userId) {
        await Message.findOneAndDelete({ _id, to: ObjectId(userId) });
    }

    async deleteRecievedMessages(myId) {
        await Message.deleteMany({ to: ObjectId(myId), triedToGet: true });
    }
}

module.exports = new MessageRepository();