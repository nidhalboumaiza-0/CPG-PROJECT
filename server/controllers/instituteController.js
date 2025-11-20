const catchAsync = require("./../utils/catchAsync");
const AppError = require("../utils/appError");
const Institute = require("../models/instituteModel");
const multer = require("multer");
//----------------------------------------------

exports.updateInstitute = catchAsync(async (req, res, next) => {
  const id = req.params.id;

  const institute = await Institute.findByIdAndUpdate(id, {
    name: req.body.name,
    adresse: req.body.adresse,
    email: req.body.email,
    phoneNumber: req.body.phoneNumber,
    fax: req.body.fax,
    type: req.body.type,

    validateBeforeSave: false,
  });

  res.status(200).json({
    status: "Updated succeffuly",
    institute,
  });
});
//-----------------------------------------------------------
exports.createInstitute = catchAsync(async (req, res, next) => {
  try {
    const institute = await Institute.create({
      name: req.body.name,
      adresse: req.body.adresse,
      email: req.body.email,
      phoneNumber: req.body.phoneNumber,
      fax: req.body.fax,
      type: req.body.type,
    });
    res.status(200).json({
      status: "Created succefully.",
      institute,
    });
  } catch (error) {
    console.log(error);
  }
});
//--------------------------------------------------------
exports.getAllInstitute = catchAsync(async (req, res, next) => {
  const institutes = await Institute.find();
  res.status(201).json({
    status: "success",
    institutesNumber: institutes.length,
    institutes,
  });
});
