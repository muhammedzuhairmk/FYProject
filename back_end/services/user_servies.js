const UserModel = require('../models/user_model');

class UserService{
  static async registerUser(name,email,phone,password,confirm_password){
    try {
      const createUser = new UserModel({name,email,phone,password,confirm_password});
      return await createUser.save();
    } catch (err) {
      throw err;
    }
  }
}

module.exports = UserService;