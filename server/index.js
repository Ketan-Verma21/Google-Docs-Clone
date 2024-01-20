const express = require("express");
const mongoose =require("mongoose");
const dotenv=require("dotenv");
const authRouter = require("./routes/auth");
const cors=require("cors");
const documentRouter = require("./routes/document");
dotenv.config();
const app=express();
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(documentRouter);
const PORT=process.env.PORT;
const DB=process.env.MONGO_URL;

mongoose.connect(DB).then(()=>{
    console.log("Mongoose Connected");
}).catch((err)=>{
    console.log(err);
});
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connected to port ${PORT}`);
});