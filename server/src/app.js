'use strict';

let express = require('express'),
  bodyParser = require('body-parser'),
  multer = require('multer'),
  upload = multer(),
  security = require('./security'),
  Score = require('./model/score'),
  User = require('./model/user'),
  Payment = require('./model/payment'),
  crossdomain = require('crossdomain'),
  xml = crossdomain({
    domain: '*.vk.com'
  }),
  app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

let port = process.env.PORT || 80;

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

  let isCorrectSign = security.isValideSign(hash, row, rand);
  if (!isCorrectSign) {
    return res.json({
      status: "error - NCD :c"
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
        res.json({
          status: "Unknown ?"
        });
      }
    })
    .then((result) => {
      return res.json({
        status: "ok"
      });
    })
    .catch((err) => {
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
      res.json({
        status: "Error :c"
      });
    })
})

app.post('/glassl/vkpayment', upload.array(), (req, res) => {
  let row = req.body;
  let result = {};

  if (security.isVkServer(row, row.sig)) {
    Payment.transaction(Number.parseInt(row.item_price), row.user_id)
      .then((result) => {
        result = {
          response: {
            order_id: row.order_id,
            app_order_id: row.order_id
          }
        }

        res.json(result);
      })
      .catch((err) => {
        result = {
          error: {
            error_code: 2,
            error_msg: "Временная ошибка базы данных",
            critical: false
          }
        };

        res.json(result);
      });
  } else {
    result = {
      error: {
        error_code: 10,
        error_msg: "несовпадение вычисленной и переданной подписи",
        critical: true
      }
    };

    res.json(result);
  }
});

app.post('/glassl/writeoffcoins', upload.array(), (req, res) => {
  let row = req.body;

  let isCorrectData = security.checkWriteoffData(row);
  if (!isCorrectData) {
    return res.json({
      error: 'Bad data'
    });
  }

  let hash = row.sign;
  let rand = row.key;

  delete row.sign;
  delete row.key;

  let isCorrectSign = security.isValideSign(hash, row, rand);
  if (!isCorrectSign) {
    return res.json({
      status: "error - NCD :c"
    });
  }

  User.update({
      id: row.id
    }, {
      $inc: {
        coins: -Number.parseInt(row.coins)
      }
    })
    .then((result) => {
      if (result.ok) {
        return res.json({
          status: "ok"
        });
      } else {
        return res.json({
          status: "error :c"
        });
      }
    })
    .catch((err) => {
      return res.json({
        status: "error - NFD :c"
      });
    })
});

app.psot('/glassl/getcoins', upload.array(), (req, res) => {
  let row = req.body;

  User.findOne({
      id: row.id
    })
    .then((user) => {
      return res.json({
        coins: user.coins
      });
    })
    .catch((err) => {
      return res.json({
        status: "error :c"
      });
    });
});

app.all('/crossdomain.xml', (req, res, next) => {
  res.set('Content-Type', 'application/xml; charset=utf-8');
  res.send(xml, 200);
});

module.exports = app;