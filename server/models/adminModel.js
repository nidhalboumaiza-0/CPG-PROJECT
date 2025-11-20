const crypto = require("crypto");
const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");

const adminSchema = mongoose.Schema({
  email: {
    type: String,
    required: [true, "Please provide your email !"],
    unique: true,
    lowercase: true,
    validate: [validator.isEmail],
  },
  password: {
    type: String,
    required: [true, "Please provide your password !"],
    minlength: 8,
    select: false,
  },
  failedLogin: {
    type: Number,
    default: 0,
    select: true,
  },
  loginAfter: {
    type: Date,
    default: null,
    select: true,
  },
});

adminSchema.pre("save", async function (next) {
  // Only run this function if password was actually modified
  if (!this.isModified("password")) return next();

  // Hash the password with cost of 12
  this.password = await bcrypt.hash(this.password, 12);

  // Delete passwordConfirm field

  next();
});
// 1 ) correctPassword
adminSchema.methods.correctPassword = async function (userpassword, password) {
  return await bcrypt.compare(userpassword, password);
};
adminSchema.methods.createPasswordResetToken = function () {
  const resetToken = crypto.randomBytes(32).toString("hex");
  this.passwordResetToken = crypto
    .createHash("sha256")
    .update(resetToken)
    .digest("hex");
  this.passwordResetExpires = Date.now() + 10 * 60 * 1000;
  return resetToken;
};
const Admin = mongoose.model("Admin", adminSchema);
module.exports = Admin;
