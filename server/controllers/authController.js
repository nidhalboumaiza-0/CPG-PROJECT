const { promisify } = require("util");
const Admin = require("../models/adminModel");
const catchAsync = require("../utils/catchAsync");
const jwt = require("jsonwebtoken");
const AppError = require("../utils/appError");
const sendEmail = require("../utils/email");
//-----------------------------------------
const signToken = function (id) {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRE_IN,
  });
};
//---------------------------------------------
createSendToken = (user, statuscode, res) => {
  const token = signToken(user._id);
  if (process.env.NODE_ENV === "production") cookieOptions.secure = true;
  res.cookie("jwt", token, { maxAge: 2 * 60 * 60 * 1000, httpOnly: true });
  res.status(statuscode).json({
    status: "success",
    token,
    data: { user },
  });
};
//-----------------------------------------

exports.login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;
  // check if the user write down his email or not
  if (!email || !password) {
    return next(new AppError("Please provide your email and password", 400));
  }
  const admin = await Admin.findOne({ email }).select("+password");
  if (!admin) {
    return next(new AppError("Email or Password is incorrect", 401));
  }
  if (admin && !(await admin.correctPassword(password, admin.password))) {
    if (Date.now() < admin.loginAfter) {
      return next(
        new AppError(
          `You tried many wrong times to connect , please try again after ${admin.loginAfter} minutes`,
          400
        )
      );
    }
    admin.failedLogin = admin.failedLogin + 1;
    admin.save({ validateBeforeSave: false });
    if (admin.failedLogin > 10) {
      admin.loginAfter = Date.now() + 5 * 60 * 1000;
      admin.failedLogin = 0;
      return next(
        new AppError(
          `You tried many wrong times to connect , please try again after ${Admin.loginAfter} minutes`,
          400
        )
      );
    }
    return next(new AppError("Email or Password is incorrect", 401));
  }

  admin.failedLogin = 0;
  admin.loginAfter = undefined;
  admin.save({ validateBeforeSave: false });
  createSendToken(admin, 200, res);
});
//-----------------------------------------
exports.protect = catchAsync(async (req, res, next) => {
  // 1) verify if the user is loged in :
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("bearer")
  ) {
    token = req.headers.authorization.split(" ")[1];
  }
  //token = req.headers.authorization.split(" ")[1];
  if (!token) {
    return next(
      new AppError(
        "You are not logged in ! Please login to access this route .",
        401
      )
    );
  }
  // 2) verify if the token is valid or not :
  const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
  console.log(decoded);
  // 3) verify if the user still exist in database or no :
  const currentUser = await Admin.findById(decoded.id);
  if (!currentUser) {
    return next(new AppError("User no longer exist !"));
  }
  req.user = currentUser;
  next();
});
