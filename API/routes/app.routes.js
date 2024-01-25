const categoryController = require("../controllers/category.controller");
const sliderController = require("../controllers/slider.controller");
const productController = require("../controllers/product.controller");
const userController = require("../controllers/user.controller");
const express = require("express");
const router = express.Router();

router.get("/category", categoryController.findAll);
router.get("/category/:id", categoryController.findOne);
router.post("/category", categoryController.create);
router.put("/category/:id", categoryController.update);
router.delete("/category/:id", categoryController.delete);

router.get("/product", productController.findAll);
router.get("/product/:id", productController.findOne);
router.post("/product", productController.create);
router.put("/product/:id", productController.update);
router.delete("/product/:id", productController.delete);

router.get("/slider", sliderController.findAll);
router.get("/slider/:id", sliderController.findOne);
router.post("/slider", sliderController.create);
router.put("/slider/:id", sliderController.update);
router.delete("/slider/:id", sliderController.delete);

router.post("/register", userController.register);
router.post("/login", userController.login);

module.exports = router;
