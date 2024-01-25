const sliderServices = require("../services/slider.services");
const upload = require("../middlewares/slider.upload");

exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        sliderName: req.body.sliderName,
        sliderDescription: req.body.sliderDescription,
        sliderImage: path != "" ? "/" + path : "",
      };

      sliderServices.createSlider(model, (error, results) => {
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
        sliderId: req.params.id,
        sliderName: req.body.sliderName,
        sliderDescription: req.body.sliderDescription,
        sliderImage: path != "" ? "/" + path : "",
      };

      sliderServices.updateSlider(model, (error, results) => {
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
    sliderName: req.query.sliderName,
    pageSize: req.query.pageSize,
    page: req.query.page,
  };

  sliderServices.getAllSliders(model, (error, results) => {
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
    sliderId: req.params.id,
  };

  sliderServices.getSliderById(model, (error, results) => {
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
    sliderId: req.params.id,
  };

  sliderServices.deleteSlider(model, (error, results) => {
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
