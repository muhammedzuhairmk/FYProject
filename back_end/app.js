const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const userRouter = require('./routes/url_routers');
const urlRouter = require('./routes/user.routes');
const app = express();

app.use(cors());

app.use(bodyParser.json({limit:'50Mb'}));
app.use(bodyParser.urlencoded({limit:'50Mb',extended:true}))

app.use('/',userRouter);
app.use('/',urlRouter);

module.exports = app;