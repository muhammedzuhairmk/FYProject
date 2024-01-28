const express = require('express');
const multer = require('multer');
const imageController = require('../controllers/imageController');

const router = express.Router();
const upload = multer({ dest: 'public/uploads/' });

router.get('/', imageController.getHome);
router.get('/upload', imageController.getUploadPage);
router.post('/upload', upload.single('image'), imageController.uploadImage);
router.get('/images', imageController.getImages);

module.exports = router;
