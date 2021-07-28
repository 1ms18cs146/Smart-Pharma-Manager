const mongoose = require('mongoose');
const credential = require('../credential.json');

const mongoosecon = ()=>{
    mongoose.connect(
        credential.db_connect,
        {
          useUnifiedTopology: true,
          useNewUrlParser: true,
        }
      )
      .then(res=>console.log('mongoose connected'))
      .catch(err=>console.log(err));
}

exports.mongooseConnect = mongoosecon;