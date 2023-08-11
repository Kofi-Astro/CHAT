const Hash = require('../utils/hash');
const MessageRepository = require('../repositories/messageRepository');
const PushNotification = require('./pushNotificationController');
const shared = require('../shared');

class MessageController {

    async send(req, res) {
        try {
            const { to, message } = req.body;
            if (!to || !message) {
                return res.json({
                    error: true,
                    errorMessage: 'Invalid'
                });
            }

            const from = req._id;
            const lowerId = from < to ? from : to;
            const higherId = from > to ? from : to;

            const chatId = Hash(lowerId, higherId);

            const sentMessage = await MessageRepository.create({
                chatId,
                from,
                to,
                message
            });

            await sentMessage.populate('from').populate('to').execPopulate();

            const myName = sentMessage.from.username;
            const fcmToken = sentMessage.to.fcmToken;

            if (fcmToken) {
                PushNotification.send(myName, message, fcmToken);
            }
            const users = shared.users;
            const findUsers = users.filter(user => user._id == to);
            findUsers.forEach(user => {
                user.socket.emit('message', {
                    message: sentMessage
                });
            });

            return res.json({ sentMessage, });

        } catch (error) {
            return res.json({
                error: true,
                errorMessage: error
            })
        }
    }

    async getMessagesAndEmit(user) {
        try {
            const myId = user._id;
            const messages = await MessageRepository.get(myId);

            messages.forEach(message => {
                MessageRepository.setTriedToGet(message._id);
                user.socket.emit('message', { message });
            })
        } catch (error) {
            // return res.json({
            //     error: true,
            //     errorMessage: error
            // });
            console.error(error);
        }
    }


    async get(req, res) {
        try {
            const myId = req._id;
            const messages = await MessageRepository.get(myId);

            messages.forEach(message => {
                MessageRepository.setTriedToGet(message._id);
            });

            return res.json({ messages });


        } catch (error) {
            return res.json({
                error: true,
                errorMessage: error
            })
        }
    }

    async delete(req, res) {
        try {
            const messageId = req.params.id;
            const myId = req._id;

            await MessageRepository.delete(messageId, myId);

            return res.json({ success: true });
        } catch (error) {
            return res.json({
                error: true,
                errorMessage: error
            });
        }
    }

    async deleteRecievedMessages(req, res) {
        try {
            const myId = req._id;
            await MessageRepository.deleteRecievedMessages(myId);

            return res.json({
                success: true
            })
        } catch (error) {
            console.error(error);
            return res.json({ error: true, errorMessage: error });
        }
    }
}


module.exports = new MessageController();