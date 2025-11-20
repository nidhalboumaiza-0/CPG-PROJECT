const crypto = require("crypto");
const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");

const supervisorSchema = mongoose.Schema({
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
  workStation: {
    type: String,
    required: [true, "Please provide the email workstation!"],
    default: "Technicien",
  },
  matricule: String,
  internNumber: { type: Number, default: 0 },
  interns: {
    type: [mongoose.Schema.ObjectId],
    ref: "Intern",
  },
  supervisorStatus: {
    type: Boolean,
    default: true,
  },
});
//-----------------------------------------------------
//----- MIDDLEWERE -----------------------
supervisorSchema.pre(/^find/, async function (next) {
  this.find({ supervisorStatus: { $ne: false } });
  next();
});

const Supervisor = mongoose.model("Supervisor", supervisorSchema);
module.exports = Supervisor;
