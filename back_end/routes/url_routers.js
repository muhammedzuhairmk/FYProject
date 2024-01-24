const router = require('express').Router();
const shortId = require('shortid');
const urlSubmitModel = require("../models/url_model");

router.post('/urlSubmit', async (req, res) => {
    const { userId, longUrl } = req.body;
    try {
        const randonurl = shortId.generate();
        const urlSubmit = new urlSubmitModel({ userId, longUrl, shorturl: randonurl });
        await urlSubmit.save();

        res.json({ status: true, shortUrl: `http://localhost:3000/${randonurl}` })
    } catch (error) {
        res.json({ status: false, message: "Something went wrong" })
    }
});

router.get('/:url',async(req,res)=>{
   const {url} = req.params;

   const urldata = await urlSubmitModel.findOne({shorturl:url})

   console.log(urldata);

   if(urldata){
            res.redirect(urldata.longUrl);
   }else{
    res.json({status:false,message:"invalid url"})
   }

});

router.post('/getUserURLList',async(req,res)=>{
    const {userId} = req.body;
    const allUserUrl = await urlSubmitModel.find({userId});
    if(allUserUrl){
        res.json({status:true,success:allUserUrl})
    }else{
        res.json({status:false,message:"no data found"});
    }
})



module.exports = router;