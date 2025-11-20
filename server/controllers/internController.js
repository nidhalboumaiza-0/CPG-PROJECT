const moment = require("moment");
const catchAsync = require("./../utils/catchAsync");
const Intern = require("../models/internModel");
const Supervisor = require("../models/supervisorModel");
const sendEmail = require("../utils/email");

const { json } = require("express");

exports.deleteIntern = catchAsync(async (req, res, next) => {
  const intern = await Intern.findByIdAndUpdate(req.params.id, {
    Status: false,
  });

  res.status(200).json({
    status: "Deleted succeffuly",
    intern,
  });
});

//-----------------------------------------------
exports.updateIntern = catchAsync(async (req, res, next) => {
  const intern = await Intern.findByIdAndUpdate(req.params.id, {
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    email: req.body.email,
    phoneNumber: req.body.phoneNumber,
    cin: req.body.cin,
    genre: req.body.genre,
    institute: req.body.institute,
  });
  res.status(200).json({
    status: "Updated succeffuly",
    intern,
  });
});
//-----------------------------------------------------------
exports.affectIntern = catchAsync(async (req, res, next) => {
  const sup = await Supervisor.findById(req.body.supervisor);
  const intern = await Intern.findByIdAndUpdate(req.params.id, {
    supervisor: req.body.supervisor,
    dateStart: req.body.dateStart,
    dateFinish: req.body.dateFinish,
    internShipType: req.body.internShipType,
    affected: true,
    validateBeforeSave: false,
    new: true,
  });
  const message = `${intern.firstName}  ${intern.lastName} is affected to you`;
  try {
    await sendEmail({
      email: sup.email,
      subject: "An intern affected to you",
      message,
    });
  } catch (err) {
    console.log(err);
  }
  res.status(201).json({
    status: "affected succefully",
    intern,
  });
});
//------------------------------------------------------------
exports.createIntern = catchAsync(async (req, res, next) => {
  try {
    const intern = await Intern.create({
      picture: req.file.filename,
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      email: req.body.email,
      phoneNumber: req.body.phoneNumber,
      cin: req.body.cin,
      genre: req.body.genre,
      institute: req.body.institute,
    });

    res.status(201).json({
      status: "success",
      intern,
    });
  } catch (err) {
    console.log(err);
  }
});
//-----------------------------------------------
exports.getAllIntern = catchAsync(async (req, res, next) => {
  try {
    const interns = await Intern.find();
    res.status(201).json({
      status: "success",
      internNumber: interns.length,
      interns,
    });
  } catch (err) {
    console.log(err);
  }
});
//---------------------------------------------------
exports.getNonAffectedIntern = catchAsync(async (req, res, next) => {
  try {
    const interns = await Intern.find({ affected: false });
    res.status(201).json({
      status: "success",
      internNumber: interns.length,
      interns,
    });
  } catch (err) {
    console.log(err);
  }
});
//-----------------------------------------------------
exports.getAffectedIntern = catchAsync(async (req, res, next) => {
  try {
    const interns = await Intern.find({ affected: true });
    res.status(201).json({
      status: "success",
      internNumber: interns.length,
      interns,
    });
  } catch (err) {
    console.log(err);
  }
});
//---------------------------------------------------------
exports.getInternInInternship = catchAsync(async (req, res, next) => {
  try {
    const interns = await Intern.find({
      affected: true,
      dateFinish: {
        $lte: Date.now,
      },
      dateStart: {
        $gte: Date.now,
      },
    });
    res.status(201).json({
      status: "success",
      internNumber: interns.length,
      interns,
    });
  } catch (err) {
    console.log(err);
  }
});
//----------------------------
// get interns numbers based on each institute :
exports.getInstitutesInternsCount = catchAsync(async (req, res, next) => {
  const institutesInternsCount = await Intern.aggregate([
    {
      $lookup: {
        from: "institutes",
        localField: "institute",
        foreignField: "_id",
        as: "institute",
      },
    },
    {
      $unwind: "$institute",
    },
    {
      $group: {
        _id: "$institute.name",
        count: { $sum: 1 },
      },
    },
  ]);
  res.status(201).json({
    status: "success",
    instituteNumber: institutesInternsCount.length,
    institutesInternsCount,
  });
});
//Absence Intern :
exports.marquerAbsence = catchAsync(async (req, res, next) => {
  try {
    let now = moment().add(1, "hour");
    let date = now.format("YYYY-MM-DD HH:mm:ss");

    const intern = await Intern.findByIdAndUpdate(req.params.id, {
      $push: { absence: date },
    });
    res.status(201).json({
      status: "success",
      data: intern,
    });
  } catch (err) {
    console.log(err);
  }
});
//------------------------------------------
exports.getIntern = catchAsync(async (req, res, next) => {
  try {
    console.log("hey");
    const intern = await Intern.findById(req.params.id);
    res.status(200).json({
      status: "success",
      data: intern,
    });
  } catch (err) {
    return next(new AppError("Error happening please try again ", 400));
  }
});
