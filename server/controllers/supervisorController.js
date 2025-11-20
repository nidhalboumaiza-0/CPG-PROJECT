const catchAsync = require("./../utils/catchAsync");
const AppError = require("../utils/appError");
const Supervisor = require("../models/supervisorModel");
const multer = require("multer");
//----------------------------------------------
const multerStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "D:\\Documents\\CPG Project\\client\\images");
  },
  filename: (req, file, cb) => {
    const picName = file.originalname.split(".")[0];
    cb(null, `${req.body.cin}-${Date.now()}.jpg`);
  },
});

const multerFiller = (req, file, cb) => {
  if (file.mimetype.starWith("image")) {
    cb(null, true);
  } else {
    cb(new AppError("Not an image ! Please upload only images."), false);
  }
};
const upload = multer({
  storage: multerStorage,
  fileFiller: multerFiller,
});
exports.uploadUsersPhoto = upload.single("picture");
//----------------------------------------------
exports.deleteSupervisor = catchAsync(async (req, res, next) => {
  const supervisor = await Supervisor.findByIdAndUpdate(req.params.id, {
    supervisorStatus: false,
  });
  res.status(200).json({
    status: "Deleted succeffuly",
    supervisor,
  });
});
//-----------------------------------------------
exports.updateSupervisor = catchAsync(async (req, res, next) => {
  const id = req.params.id;
  const supervisor = await Supervisor.findByIdAndUpdate(id, {
    picture: req.body.picture,
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    email: req.body.email,
    phoneNumber: req.body.phoneNumber,
    workStation: req.body.workStation,
    matricule: req.body.matricule,

    validateBeforeSave: false,
  });
  res.status(200).json({
    status: "Updated succeffuly",
    supervisor,
  });
});
//-----------------------------------------------------------
exports.createSupervisor = catchAsync(async (req, res, next) => {
  try {
    console.log(req.file);
    console.log(req.body);
    const supervisor = await Supervisor.create({
      picture: req.file.filename,
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      email: req.body.email,
      phoneNumber: req.body.phoneNumber,
      workStation: req.body.workStation,
      matricule: req.body.matricule,
      validateBeforeSave: false,
    });
    res.status(200).json({
      status: "Created succefully.",
      supervisor,
    });
  } catch (error) {
    console.log(error);
  }
});
//--------------------------------------------------------
exports.getAllSupervisor = catchAsync(async (req, res, next) => {
  console.log("heeeeeeeeeeeeeeeeeeeeeeey");
  const supervisors = await Supervisor.find();
  res.status(201).json({
    status: "success",
    SupervisprNumber: supervisors.length,
    supervisors,
  });
});
//--------------------------------------------------------
exports.addInternToSupervisor = catchAsync(async (req, res, next) => {
  const supervisor = await Supervisor.findByIdAndUpdate(req.body.supervisor, {
    $inc: { internNumber: 1 },
    $push: { interns: req.params.id },
    validateBeforeSave: false,
  });
  next();
});

exports.decreaseInternToSupervisor = catchAsync(async (req, res, next) => {
  const supervisor = await Supervisor.findByIdAndUpdate(req.body.idSupervisor, {
    $inc: { internNumber: -1 },
    $pull: { interns: req.params.id },
    validateBeforeSave: false,
  });
  next();
});
