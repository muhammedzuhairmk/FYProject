const ToDoService = require('../services/ToDo_services');

exports.createToDo = async (req, res, next) => {
    try {
        const { userId, title, desc } = req.body;
        let todoData = await ToDoService.createToDo(userId, title, desc);
        res.json({ status: true, success: todoData });
    } catch (error) {
        console.error(error); // Log the error for debugging
        next(error); // Pass the error to the error handling middleware
    }
};

exports.getToDoList = async (req, res, next) => {
    try {
        const { userId } = req.body;
        let todoData = await ToDoService.getUserToDoList(userId);
        res.json({ status: true, success: todoData });
    } catch (error) {
        console.error(error); // Log the error for debugging
        next(error); // Pass the error to the error handling middleware
    }
};

exports.deleteToDo = async (req, res, next) => {
    try {
        const { id } = req.body;
        let deletedData = await ToDoService.deleteToDo(id);
        res.json({ status: true, success: deletedData });
    } catch (error) {
        console.error(error); // Log the error for debugging
        next(error); // Pass the error to the error handling middleware
    }
};
