const express = require("express");
const internController = require("../controllers/internController");
const supervisorController = require("../controllers/supervisorController");
const router = express.Router();

router.route("/marquerAbsence/:id").patch(internController.marquerAbsence);
router.route("/").get(internController.getAllIntern);
router.route("/getInternAbsences/:id").get(internController.getIntern);

router
  .route("/createintern")
  .post(supervisorController.uploadUsersPhoto, internController.createIntern);
router.route("/updateintern/:id").patch(internController.updateIntern);

router
  .route("/deleteintern/:id")
  .delete(
    supervisorController.decreaseInternToSupervisor,
    internController.deleteIntern
  );
router
  .route("/affectintern/:id")
  .patch(
    supervisorController.addInternToSupervisor,
    internController.affectIntern
  );

router
  .route("/getnonaffectedintern")
  .get(internController.getNonAffectedIntern);
router.route("/getaffectedintern").get(internController.getAffectedIntern);
router
  .route("/getInternInInternship")
  .get(internController.getInternInInternship);

router
  .route("/getInstitutesInternsCount")
  .get(internController.getInstitutesInternsCount);

module.exports = router;
