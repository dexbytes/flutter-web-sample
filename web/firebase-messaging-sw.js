importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
          apiKey: "AIzaSyBL9h9hoOsPR_bGwbr8cLGD0EgCJc8dVvs",
          authDomain: "fir-notificationdemo-c6f9b.firebaseapp.com",
          databaseURL: "https://fir-notificationdemo-c6f9b.firebaseio.com",
          projectId: "fir-notificationdemo-c6f9b",
          storageBucket: "fir-notificationdemo-c6f9b.appspot.com",
          messagingSenderId: "197289920803",
          appId: "1:197289920803:web:9eebda92dbfe09919be496"
        };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });





// importScripts("https://www.gstatic.com/firebasejs/9.6.7/firebase-app.js");
// importScripts("https://www.gstatic.com/firebasejs/9.6.7/firebase-messaging.js");
//
// firebase.initializeApp({
// apiKey: "AIzaSyBL9h9hoOsPR_bGwbr8cLGD0EgCJc8dVvs",
//  authDomain: "fir-notificationdemo-c6f9b.firebaseapp.com",
//  databaseURL: "https://fir-notificationdemo-c6f9b.firebaseio.com",
//  projectId: "fir-notificationdemo-c6f9b",
//  storageBucket: "fir-notificationdemo-c6f9b.appspot.com",
//  messagingSenderId: "197289920803",
//  appId: "1:197289920803:web:9eebda92dbfe09919be496"
// });
//
//
// const messaging = firebase.messaging();
//
// messaging.setBackgroundMessageHandler(function (payload) {
//     const promiseChain = clients
//         .matchAll({
//             type: "window",
//             includeUncontrolled: true
//         })
//         .then(windowClients => {
//             for (let i = 0; i < windowClients.length; i++) {
//                 const windowClient = windowClients[i];
//                 windowClient.postMessage(payload);
//             }
//         })
//         .then(() => {
//             return registration.showNotification("New Message");
//         });
//     return promiseChain;
// });
// self.addEventListener('notificationclick', function (event) {
//     console.log('notification received: ', event)
// });