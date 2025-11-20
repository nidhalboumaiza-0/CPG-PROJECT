const mongoose = require("mongoose");
const validator = require("validator");

const instituteSchema = mongoose.Schema({
  name: {
    type: String,
    required: ["Please provide the institute's name !"],
  },
  email: {
    type: String,
    required: [true, "Please provide the email !"],
    unique: true,
    lowercase: true,
    validate: [validator.isEmail],
  },
  phoneNumber: {
    type: String,
    required: [true, "Please provide the phone number !"],
  },
  fax: {
    type: String,
  },

  adresse: {
    type: String,
    required: [true, "Please provide the adress of institute !"],
  },
  type: {
    type: String,
    enum: ["university", "training center"],
    required: [true, "Please provide the type of institute !"],
  },
});

const Institute = mongoose.model("Institute", instituteSchema);
module.exports = Institute;
