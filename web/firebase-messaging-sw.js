importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyC-9vIdFfVyi3Pd9OfizU4TUqANpuRFV_k",
  authDomain: "benji-rider.firebaseapp.com",
  projectId: "benji-rider",
  storageBucket: "benji-rider.appspot.com",
  messagingSenderId: "412444903210",
  appId: "1:412444903210:web:44a152bf4cf4066037c053",
  measurementId: "G-7D8G465PDL",
});

const messaging = firebase.messaging();
