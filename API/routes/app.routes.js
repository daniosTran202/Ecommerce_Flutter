const categoryController = require("../controllers/category.controller");
const express = require("express");
const router = express.Router();

router.get("/category", categoryController.findAll);
router.get("/category/:id", categoryController.findOne);
router.post("/category", categoryController.create);
router.put("/category/:id", categoryController.update);
router.delete("/category/:id", categoryController.delete);

module.exports = router;
