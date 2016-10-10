var promise = require('bluebird');

var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = 'postgres://postgres:p@ssw0rd@localhost/osaappp';
var db = pgp(connectionString);

function getUsers(req, res, next) {
  db.any('select * from users')
    .then(function (data) {
      res.end(JSON.stringify(data));

    })
    .catch(function (err) {
      return next(err);
    });
}

function getWeb(req, res, next) {
  db.any('select up_mail, pass from users')
    .then(function (data) {
      res.end(JSON.stringify(data));

    })
    .catch(function (err) {
      return next(err);
    });
}

module.exports = {
  getUsers: getUsers,
  getWeb: getWeb
};
