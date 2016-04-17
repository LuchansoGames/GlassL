'use strict';

let express = require('express'),
  bodyParser = require('body-parser'),
  multer = require('multer'),
  upload = multer(),
  security = require('./security'),
  Score = require('./model/score'),
  app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

const port = 22079;

app.listen(port, () => {
  console.log(`Server run on: 0.0.0.0:${port}`);
});

app.post('/glassl/newattaitment', upload.array(), (req, res) => {
  let row = req.body;

  let isCorrectData = security.checkScoreData(row);
  if (!isCorrectData) {
    return res.json({
      error: 'Bad data'
    });
  }

  Score.isBetterScore(row.score)
    .then((result) => {
      if (result) {
        return Score.newScore(new Score({
          id: row.id,
          score: row.score
        }));
      } else {
        res.json({status: "Unknown ?"});
      }
    })
    .then((result) => {
      return res.json({
        status: "ok"
      });
    })
    .catch((err) => {
      console.log(err);
      return res.json({
        status: "error :c"
      });
    });
});

app.get('/glassl/getrating', (req, res) => {
  Score.getTop100()
    .then((result) => {
      res.json(result);
    })
    .catch((err) => {
      console.log(err);
      res.json({
        status: "Error :c"
      });
    })
})

module.exports = app;