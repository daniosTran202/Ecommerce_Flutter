const relatedProductServices = require("../services/related-products.services");

exports.create = (req, res, next) => {
  relatedProductServices.addRelatedProduct(req.body, (error, results) => {
    if (error) {
      return next(error);
    }

    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};

exports.delete = (req, res, next) => {
  var model = {
    id: req.params.id,
  };
  relatedProductServices.deleteRelatedProduct(model, (error, results) => {
    if (error) {
      return next(error);
    }

    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};
