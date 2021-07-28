const express = require('express');
const Products = require('../models/products');
const moongoose = require('mongoose');

exports.getData = async (req,res,next)=>{
        // const query = Products.findOne({ '_id': '5fe05dba765e272618c41ad7' });
    console.log("here");
    let x = await Products.find({}).exec();
    res.send(x);
   // console.log(x);
}

exports.addCart = async(req,res,next)=>{
    console.log(req.body);
   await Products.findOne({_id:req.body.id}).exec()
   .then(x=>{
       x.isAdded = true;
       x.save();
       console.log(x);
   })
    // await Products.find({_id:req.body.id})
    // .then(val=>console.log(val));   
     next();

 }

exports.resetAll = async (req,res,next)=>{
    await Products.find().exec()
    .then(val=>{
        val.forEach(e=>{
            e.isAdded = false;
            e.save();
        })
    })
    .catch(err=>{
        console.log(err);
    })
    res.send('<h1>All items set to false</h1>');
} 


// initially to add data
exports.addData = async (req,res,next)=>{
    console.log('hereee');
    res.send('fsda');
     let x = new Products({
         _id: new moongoose.Types.ObjectId,
         name:'Anxipan Capsule 10',
         desc:'AMITRIPTYLINE HYDROCHLORIDE 10 mg+PANTOPRAZOLE 40MG for anxity',
         price:100,
         url:'assets/med1',
     })
     let x1 = new Products({
         _id: new moongoose.Types.ObjectId,
         name:'Dolo 650mg Tablet 15\'S',
         desc:'for fever and cough',
         price:31,
         url:'assets/med2',
     })
     let x2 = new Products({
         _id: new moongoose.Types.ObjectId,
         name:'Aceto 150mg Drops 15ml',
         desc:'PARACETAMOL(ACETAMINOPHEN) 150MG for fever',
         price:25,
         url:'assets/med3',
     })
     let x3 = new Products({
         _id: new moongoose.Types.ObjectId,
         name:'Fepanil 500mg Tablet 15\'S',
         desc:'PARACETAMOL(ACETAMINOPHEN) 500MG',
         price:15,
         url:'assets/med4',
     })
     let x4 = new Products({
         _id: new moongoose.Types.ObjectId,
         name:'Etowin 120mg Tablet 10\'S',
         desc:'ETOWIN 120MG contains Etoricoxib which belongs to non-steroidal anti-inflammatory drugs (NSAIDs)',
         price:160,
         url:'assets/med5',
     })
     await x.save().then(()=>console.log('saved')).catch(err=>console.log(err));
     await x1.save().then(()=>console.log('saved')).catch(err=>console.log(err));
     await x2.save().then(()=>console.log('saved')).catch(err=>console.log(err));
     await x3.save().then(()=>console.log('saved')).catch(err=>console.log(err));
     await x4.save().then(()=>console.log('saved')).catch(err=>console.log(err));
     res.send('working');
}