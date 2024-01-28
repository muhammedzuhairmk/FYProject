const mongoose = require('mongoose');
const db = require('../config/db_config');

const { Schema } = mongoose;

const userSchema = new Schema({
    name:{
        type:String
    },
    email:{
        type:String
    },
       
    password:{
        type:String
    },
},{timestamps:true});



const userModel = db.model('users',userSchema);
module.exports = userModel;