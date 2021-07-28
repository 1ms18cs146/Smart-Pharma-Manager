const express = require('express');
const router = express.Router();

// controller imports
const {getData,addData,addCart,resetAll} = require('../controllers/dataControler');

// controller to get and return data

router.get('/getData',getData);
router.post('/addCart',addCart);
router.get('/addData',addData);
router.use('/reset',resetAll);

// export router
exports.dataRouter = router;