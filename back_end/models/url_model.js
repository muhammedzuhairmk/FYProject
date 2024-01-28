const mongoose = require('mongoose');
const db = require('../config/db_config');
const userModel = require('./user_model');

const { Schema } = mongoose;

const urlSubmitionSchema = new Schema({
    userId:{
        type: Schema.Types.ObjectId,
        ref: userModel.modelName
    },
    longUrl:{
        type : String
    },
    shorturl:{
        type : String
    }
});

const urlSubmitionModel = db.model('urlSubmittion',urlSubmitionSchema);
module.exports = urlSubmitionModel;