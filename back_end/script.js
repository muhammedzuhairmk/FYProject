const express = require('express');
const body_parser = require('body-parser');
const userRouter = require('./routes/user.routes');
const db  = require('./config/db_config');
const UserModel  = require('./models/user_model');

const app = express();
const port = 3000;

app.use(body_parser.json());
app.use('/', userRouter);


app.get('/name',(req,res) => {
    
    res.send(data)
});

app.listen(port, () => {
    console.log(`Server Listening on port http://localhost:${port}`);
});


