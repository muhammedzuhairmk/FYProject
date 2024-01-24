const router = require('express').Router();
const userModel = require('../models/user_model');


router.post('/userRegistration', async (req,res)=>{
    try {
        const {name,email,password} = req.body;

        const user = await userModel.findOne({email});
        if(!user){
            const createuser = new userModel({name,email,password});
            await createuser.save();


            res.json({status:true,success : "User Created Successfully"});
        }else{
            res.json({status:false,success : "User Exist"});
        }

    } catch (error) {
        console.log(error);
    }
   

});



router.post('/userLogin', async (req,res)=>{
    try {
        const {email,password} = req.body;

        const user = await userModel.findOne({email,password});
        if(user){
           
            res.json({status:true,success : user});
        }else{
            res.json({status:false,success : "User Invalid Please Try Again"});
        }

    } catch (error) {
        console.log(error);
    }
});

module.exports = router;