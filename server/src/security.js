'use strict';

let security = {};

security.checkScoreData = (data) => {
  let result = false;  

  if (typeof(data) === "object") {
    result = typeof(data.id) === "string" && typeof(Number.parseInt(data.score)) === "number";
  } else {
    result = false;
  }

  return result;
}

module.exports = security;