const multer = require("multer");
const Path = require("path");
const { slider } = require("../models/slider.model");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads/sliders");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

const fileFilter = (req, file, callback) => {
  const acceptableExt = [".png", ".jpg", ".jpeg"];
  if (!acceptableExt.includes(Path.extname(file.originalname))) {
    return callback(new Error("only .png and .jpg,.jpeg files"));
  }

  const fileSize = parseInt(req.headers["content-length"]);
  if (fileSize > 1048576) {
    return callback(new Error("FileSize Big!"));
  }

  callback(null, true);
};

let upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  fileSize: 1048576,
});

module.exports = upload.single("sliderImage");
