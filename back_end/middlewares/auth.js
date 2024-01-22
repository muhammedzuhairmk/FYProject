const jwt = require('jsonwebtoken');

function authenticateToken(req,res,next){
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(' ')[1];

    if(token == null) return res.sendStatus(401);

    jwt.verify(token, "Snippet_SceretKEY",(err, user) => {
        if(err) return res.sendStatus(403);
        req.user = user;
        next();
    });
}

function generateAccesstoken(username){
    return jwt.sign({ data : username}, "Snippet_SceretKEY", {
        expireIn: "1m",
    });
}

module.exports = {
    authenticateToken,
    generateAccesstoken,
};