const mongoose = require ("mongoose");

const connection = mongoose.createConnection('mongodb://localhost:27017/EventSnap').on('open', () => {
    console.log("Mongoodb connected");
}).on('error', () => {
    console.log("Mongoodb Connection Error");
});

module .exports = connection;