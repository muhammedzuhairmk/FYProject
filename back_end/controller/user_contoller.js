const UserService = require("../services/user_servies");


exports.register = async (req, res, next) => {
    try {
        const { name,email,phone,password,confirm_password } = req.body;

        const successRes = await UserService.registerUser( name ,email,phone,password,confirm_password);

        

        res.json({ status: true, message: " user registered Success", data : successRes })

    } catch (error) {
        throw error
    }
}
