const express = require('express');
const mongoose = require('mongoose');
const multer = require('multer');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Connect to MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/EventSnap', {
  useNewUrlParser: true,
  useUnifiedTopology: true
});
const db = mongoose.connection;

db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => console.log('Connected to MongoDB'));

// Create Faculty Schema
const facultySchema = new mongoose.Schema({
  name: String,
  education: String,
  number: String,
  designation: String,
  profile_image: String // Store the path to the image
});
const Faculty = mongoose.model('Faculty', facultySchema);

// Multer configuration for handling file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads'); // Destination folder for storing uploaded files
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Unique filename for each uploaded file
  }
});
const upload = multer({ storage: storage });

// Serve uploaded images statically
app.use('/uploads', express.static('uploads'));

// Routes
app.use(express.json());

// Get all faculties
app.get('/get-faculties', async (req, res) => {
  // try {
  //   const faculties = await Faculty.find();
  //   // Replace profile image paths with URLs
  //   // const facultyData = faculties.map(faculty => {
  //   //   return {
  //   //     id: faculty._id,
  //   //     name: faculty.name,
  //   //     education: faculty.education,
  //   //     number: faculty.number,
  //   //     designation: faculty.designation,
  //   //     profile_image: faculty.profile_image ? `${req.protocol}://${req.get('host')}/${faculty.profile_image}` : null
  //   //   };
  //   // });
  //   res.json({
  //     status: true,
  //     message: 'All faculties retrieved successfully.',
  //     data: facultyData
  //   });
  // } catch (err) {
  //   res.status(500).json({
  //     status: false,
  //     message: 'Failed to retrieve faculties.',
  //     error: err.message
  //   });
  // }
  res.send("hai")
});

// Add new faculty
app.post('/faculties', upload.single('profile_image'), async (req, res) => {
  try {
    const { name, education, number, designation } = req.body;
    const profile_image = req.file ? req.file.path : null;

    const newFaculty = await Faculty.create({
      name,
      education,
      number,
      designation,
      profile_image
    });

    res.status(201).json({
      status: true,
      message: 'Faculty added successfully.',
      data: newFaculty
    });
  } catch (err) {
    res.status(400).json({
      status: false,
      message: 'Failed to add faculty.',
      error: err.message
    });
  }
});

// Delete faculty by ID
app.delete('/faculties/:id', async (req, res) => {
  try {
    const deletedFaculty = await Faculty.findByIdAndDelete(req.params.id);
    if (!deletedFaculty) {
      return res.status(404).json({
        status: false,
        message: 'Faculty not found.'
      });
    }
    res.json({
      status: true,
      message: 'Faculty deleted successfully.',
      data: deletedFaculty
    });
  } catch (err) {
    res.status(500).json({
      status: false,
      message: 'Failed to delete faculty.',
      error: err.message
    });
  }
});

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
