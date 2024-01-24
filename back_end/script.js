const app = require("./app")


app.get('/',(req,res)=>{
    const { data } = req.body;
   res.send(` Hello ${data}`)
})

app.listen(3000,()=>{
    console.log("Localhost Express running at 3000");
})