const express = require('express');
const UserController = require('../controller/user_contoller');

const router = express.Router();

router.post('/registration', UserController.register);


module.exports = router;
