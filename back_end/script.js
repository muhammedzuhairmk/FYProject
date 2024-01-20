const express = require("express");
const mongoose = require("mongoose")

const dbconfig = require("./config/db_config");
const auth = require("./middlewares/auth");
const errors = require("./middlewares/errors");

const unless = require("express-unless");

const app = express();

mongoose.Promise = global.Promise;
mongoose.connect(dbconfig.db,{
    useNewUrlParser :true ,
    useUnifiedTopology : true,
}).then ( () => {
    console.log('database connected');
    },
    (error) => {
        console.log("database can't be connected:" + error);
    }
);

auth.authenticateToken.unless = unless;
app.use(
    auth.authenticateToken.unless({
        path : [
            { url: "/user/login", method:["post"]},
            { url: "/user/register", method:["post"]},
        ]
    })
);

app.use(express.json() );

app.use("/users",require("./routes/user.routes"));

app.use(errors.errorHandler);



const PORT = process.env.PORT || 3001;
app.listen(PORT ,() => console.log(`server running on ${PORT}`));