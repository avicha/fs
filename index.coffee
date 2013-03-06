#引入原生的fs模块
fs = require 'fs'
path = require 'path'
_ = require 'underscore'
async = require 'async'
#自定义新增方法
fs.mkdirp = require 'mkdirp'
fs.mkdirpSync = fs.mkdirp.sync
fs.ensureDir = (dir,callback)->
    fs.exists dir,(exists)->
        if exists
            callback null
        else
            fs.mkdirp dir,callback
fs.isSubDir = (dir1,dir2)->
    p1 = dir1.split /[\\\/]/
    p2 = dir2.split /[\\\/]/
    diff = _.difference p2,p1
    if !diff.length
        true
    else
        false
fs.getDirFiles = (dir,callback)->
    resultFiles = []
    fs.readdir dir,(err,files)->
        if err
            callback err,resultFiles
        else
            async.forEachLimit files,10,(file,cb)->
                file = path.join dir,file
                fs.stat file,(err,stat)->
                    if err
                        cb err
                    else
                        if stat.isFile()
                            resultFiles.push file
                            cb null
                        else
                            fs.getDirFiles file,(err,subFiles)->
                                if !err&&subFiles.length
                                    resultFiles = resultFiles.concat subFiles
                                cb null
            ,(err)->
                callback err,resultFiles
fs.copyFile = (source,target,callback)->
    fs.readFile source,(err,buffer)->
        if err
            callback err
        else
            fs.ensureDir (path.dirname target),(err)->
                if err
                    callback err
                else
                    #复制文件
                    fs.writeFile target,buffer,(err)->
                        if err
                            callback err
                        else
                            callback null
fs.copyDir = (dir1,dir2,callback)->
    fs.getDirFiles dir1,(err,resultFiles)->
        if err
            callback err
        else
            async.forEachLimit resultFiles,10,(file,cb)->
                target = path.join dir2,path.relative dir1,file
                fs.copyFile file,target,cb
            ,(err)->
                callback err
module.exports = fs