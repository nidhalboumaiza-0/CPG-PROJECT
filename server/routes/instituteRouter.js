const express = require("express");
const instituteController = require("../controllers/instituteController");

const router = express.Router();

router.route("/").get(instituteController.getAllInstitute);
router.route("/createinstitute").post(instituteController.createInstitute);
router.route("/updateinstitute/:id").patch(instituteController.updateInstitute);
module.exports = router;
