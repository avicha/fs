// Generated by CoffeeScript 1.4.0
(function() {
  var dir, fs;

  fs = require('../index');

  dir = "" + __dirname + "/source_folder";

  fs.mkdirp(dir, '0777', function(err) {
    if (err) {
      return console.log(err);
    } else {
      return console.log("mkdirp " + dir + " success.");
    }
  });

}).call(this);