const router = require("express").Router();
const ToDoController = require('../controller/ToDo_controller')

router.post("/createToDo", ToDoController.createToDo);
router.get("/getUserToDoList", ToDoController.getToDoList);
router.post("/deleteToDo", ToDoController.deleteToDo);

module.exports = router;

