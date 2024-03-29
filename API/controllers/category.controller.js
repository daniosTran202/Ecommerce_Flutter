const categoryServices = require("../services/category.services");
const upload = require("../middlewares/category.uploads");

exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        categoryName: req.body.categoryName,
        categoryDescription: req.body.categoryDescription,
        categoryImage: path != "" ? "/" + path : "",
      };

      categoryServices.createCategory(model, (error, results) => {
        if (error) {
          return next(error);
        } else {
          return res.status(200).send({
            message: "Successfully",
            data: results,
          });
        }
      });
    }
  });
};

exports.update = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        categoryId: req.params.id,
        categoryName: req.body.categoryName,
        categoryDescription: req.body.categoryDescription,
        categoryImage: path != "" ? "/" + path : "",
      };

      categoryServices.updateCategory(model, (error, results) => {
        if (error) {
          return next(error);
        } else {
          return res.status(200).send({
            message: "Successfully",
            data: results,
          });
        }
      });
    }
  });
};

// api/
exports.findAll = (req, res, next) => {
  var model = {
    categoryName: req.query.categoryName,
    pageSize: req.query.pageSize,
    page: req.query.page,
  };

  categoryServices.getAllCategories(model, (error, results) => {
    if (error) {
      return next(error);
    } else {
      return res.status(200).send({
        message: "Successfully",
        data: results,
      });
    }
  });
};

exports.findOne = (req, res, next) => {
  var model = {
    categoryId: req.params.id,
  };

  categoryServices.getCategoryById(model, (error, results) => {
    if (error) {
      return next(error);
    } else {
      return res.status(200).send({
        message: "Successfully",
        data: results,
      });
    }
  });
};

exports.delete = (req, res, next) => {
  var model = {
    categoryId: req.params.id,
  };

  categoryServices.deleteCategory(model, (error, results) => {
    if (error) {
      return next(error);
    } else {
      return res.status(200).send({
        message: "Successfully",
        data: results,
      });
    }
  });
};
