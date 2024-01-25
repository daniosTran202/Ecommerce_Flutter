const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const slider = mongoose.model(
  "Sliders",
  Schema(
    {
      sliderName: {
        type: String,
        required: [true, "Please provide name"],
        unique: true,
      },
      sliderDescription: {
        type: String,
        required: false,
      },
      sliderURL: {
        type: String,
        required: false,
      },
      sliderImage: {
        type: String,
        required: true,
      },
    },
    {
      toJSON: {
        transform: function (doc, ret) {
          ret.sliderId = ret._id.toString();
          delete ret._id;
          delete ret._v;
        },
      },
    }
  )
);

module.exports = {
  slider,
};
