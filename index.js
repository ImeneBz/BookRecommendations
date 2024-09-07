import express from "express";
import bodyParser from "body-parser";
import axios from "axios"; 
import pg from "pg"; 

const app = express();
const port = 3000;
const db = new pg.Client({
    user: "u4v3mvjk69on88",
    host: "ceqbglof0h8enj.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com",
    database: "dfhedo77cpos9g",
    password: "p81f3e7b05c6923c917480fc65b24d0206fddf79bbf1037257ca9311eb7a50d3f",
    port: 5432
  })
  
db.connect();

db.query("SELECT * FROM books ORDER BY book_id DESC", (err, res) => {
    if (err) {
      console.error("error excecuting query", err.stack); 
    }
    else {
    reco = res.rows;
    }
  });

app.use(express.static("public"));
app.use(bodyParser.urlencoded({extended: true }));

let reco = [] ; 

app.get("/", (req, res) =>{
    res.render("index.ejs", {recomendations: reco});
})

app.post ("/BookResult", async(req, res) => {
    const Name = req.body.search ; 
    const Search = Name.replaceAll(' ','+');
    try {
      const response = await axios.get(`https://openlibrary.org/search.json?title=${Search}`);
      const result = response.data;
      res.render("index.ejs",{data: result, recomendations: reco})
    }
    catch (error) {
        console.error("failed to make request: ", error.message);
        res.render("index.ejs", {error: error.message});
    }
})

app.post ("/BookAdded", async(req, res) => {
     
    
    try {
        const bookName = req.body.title ; 
        const bookAuthor = req.body.author ; 
        let recoDate = new Date(); 

        await db.query("INSERT INTO books (creationDate, title, author) VALUES ($1, $2, $3)", [recoDate, bookName, bookAuthor]);

        const data = await db.query("SELECT * FROM books ORDER BY book_id DESC");
        reco = data.rows;
        res.redirect("/"); 

    }
    catch (err) {
      console.log(err);
    }

})

app.post ("/recommendations", async (req, res) => {
    try { const data = await db.query("SELECT * FROM books ORDER BY book_id DESC");
    reco = data.rows;
    res.render("recommendations.ejs", {books:reco})
    }
    catch (err) {
      console.log(err);
    }
});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
  });
