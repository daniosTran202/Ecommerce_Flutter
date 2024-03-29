const productServices = require("../services/product.services");
const upload = require("../middlewares/product.upload");

exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        productName: req.body.productName,
        category: req.body.category,
        productShortDescription: req.body.productShortDescription,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productSalePrice: req.body.productSalePrice,
        productSKU: req.body.productSKU,
        productType: req.body.productType,
        stockStatus: req.body.stockStatus,
        productImage: path != "" ? "/" + path : "",
      };

      productServices.createProduct(model, (error, results) => {
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
        productId: req.params.id,
        productName: req.body.productName,
        category: req.body.category,
        productShortDescription: req.body.productShortDescription,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productSalePrice: req.body.productSalePrice,
        productSKU: req.body.productSKU,
        productType: req.body.productType,
        stockStatus: req.body.stockStatus,
        productImage: path != "" ? "/" + path : "",
      };

      productServices.updateProduct(model, (error, results) => {
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
    productIds: req.query.productIds,
    productName: req.query.productName,
    categoryId: req.query.categoryId,
    pageSize: req.query.pageSize,
    page: req.query.page,
    sort: req.query.sort,
  };

  productServices.getProducts(model, (error, results) => {
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
    productId: req.params.id,
  };

  productServices.getProductById(model, (error, results) => {
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
    productId: req.params.id,
  };

  productServices.deleteProduct(model, (error, results) => {
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
