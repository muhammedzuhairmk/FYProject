const path = require('path');
const Image = require('../models/imageModel');

exports.getHome = (req, res) => {
  res.sendFile(path.join(__dirname, '../views/index.html'));
};

exports.getUploadPage = (req, res) => {
  res.sendFile(path.join(__dirname, '../views/upload.html'));
};

exports.uploadImage = (req, res) => {
  if (!req.file) {
    return res.status(400).send('No files were uploaded.');
  }

  const newImage = new Image({
    name: req.file.originalname,
    path: req.file.path
  });

  newImage.save((err, image) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.send('File uploaded successfully.');
  });
};

exports.getImages = (req, res) => {
  Image.find({}, (err, images) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.render('images', { images: images });
  });
};
