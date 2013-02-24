#引入原生的fs模块
fs = require 'fs'
#自定义新增方法
fs.mkdirp = require 'mkdirp'
fs.mkdirpSync = fs.mkdirp.sync
module.exports = fs