import express from "express";
import bodyParser from "body-parser";
import axios from "axios"; 
import pg from "pg"; 

const app = express();
const port = 3000;
const db = new pg.Client({
    user: "postgres",
    host: "localhost",
    database: "Books",
    password: "pg-admin",
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
