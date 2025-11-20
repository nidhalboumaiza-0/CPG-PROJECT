const crypto = require("crypto");
const mongoose = require("mongoose");
const validator = require("validator");

const internSchema = mongoose.Schema({
  picture: {
    type: String,
    default: "person.jpg",
  },
  firstName: {
    type: String,
    required: [true, "Please provide the first name !"],
  },

  lastName: {
    type: String,
    required: [true, "Please provide the last name !"],
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
  cin: {
    type: String,
    required: [true, "Please provide the Cin number !"],
  },
  genre: {
    type: String,
    required: [true, "Please provide the gendre !"],
  },
  institute: {
    type: mongoose.Schema.ObjectId,
    ref: "Institute",
  },
  internShipType: {
    enum: ["technician", "worker", "PFE", "summer internship"],
    type: "String",
  },
  supervisor: {
    type: mongoose.Schema.ObjectId,
    ref: "Supervisor",
  },
  dateStart: {
    type: String,
  },
  dateFinish: {
    type: String,
  },
  absence: {
    type: [Date],
  },
  Status: {
    type: Boolean,
    default: true,
  },
  affected: {
    type: Boolean,
    default: false,
  },
});

internSchema.pre(/^find/, async function (next) {
  this.find({ Status: { $ne: false } });
  next();
});

internSchema.pre("aggregate", function (next) {
  // Define an array of pipeline stages that filter out documents with a "false" Status field
  this.pipeline().unshift({ $match: { Status: true } });
  next();
});

internSchema.pre(/^find/, async function (next) {
  this.populate([
    { path: "supervisor", select: "firstName lastName" },
    { path: "institute", select: "name" },
  ]);
});

const Intern = mongoose.model("Intern", internSchema);
module.exports = Intern;
