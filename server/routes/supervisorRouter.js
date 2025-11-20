const express = require("express");
const supervisorController = require("../controllers/supervisorController");

const router = express.Router();

router.route("/").get(supervisorController.getAllSupervisor);

router
  .route("/createsupervisor")
  .post(
    supervisorController.uploadUsersPhoto,
    supervisorController.createSupervisor
  );
router
  .route("/updatesupervisor/:id")
  .patch(supervisorController.updateSupervisor);
router
  .route("/deletesupervisor/:id")
  .delete(supervisorController.deleteSupervisor);
module.exports = router;
