const { relatedProduct } = require("../models/related-products.model");
const { product } = require("../models/product.model");

async function addRelatedProduct(params, callback) {
  if (!params.product) {
    return callback({
      message: "Product Id REQUIRED",
    });
  }

  if (!params.relatedProduct) {
    return callback({
      message: "RelatedProduct Id REQUIRED",
    });
  }

  const relatedProductModel = new relatedProduct(params);
  relatedProductModel
    .save()
    .then(async (response) => {
      await product.findOneAndUpdate(
        {
          _id: params.product,
        },
        {
          $addToSet: {
            relatedProducts: relatedProductModel,
          },
        }
      );
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function deleteRelatedProduct(params, callback) {
  const id = params.id;

  relatedProduct
    .findByIdAndDelete(id)
    .then((response) => {
      if (!response) {
        callback("Product Id not found");
      } else {
        return callback(null, response);
      }
    })
    .catch((error) => {
      return callback(error);
    });
}

module.exports = {
  addRelatedProduct,
  deleteRelatedProduct,
};
