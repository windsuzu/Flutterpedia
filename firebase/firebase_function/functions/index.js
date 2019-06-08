// getting started: https://firebase.google.com/docs/functions/get-started
// functions: https://github.com/firebase/functions-samples
// topic messaging: https://firebase.google.com/docs/cloud-messaging/android/topic-messaging


const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
exports.addMessage = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const original = req.query.text;
    // Push the new message into the Realtime Database using the Firebase Admin SDK.
    const snapshot = await admin.database().ref('/messages').push({original: original});
    // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
    res.redirect(303, snapshot.ref.toString());
});

exports.sendNotification = functions.https.onRequest(async (req, res) => {

    if (req.method !== 'GET') {
        return res.status(403).send('Forbidden');
    }


    const topic = req.query.text;

    let message = {
        data: {
            score: '850',
            time: '2:45'
        },
        notification: {
            title: "Hello" + topic,
            body: 'This is a test.'
        }
    };

    return admin.messaging().sendToTopic(topic, message)
        .then((response) => {
            console.log('Successfully sent message:', response);
            res.status(200).send('push successfully');
            return true;
        })
        .catch((error) => {
            console.log('Error sending message:', error);
            res.status(500).send('Error');
            return false;
        });
});