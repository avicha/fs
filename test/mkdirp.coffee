fs = require '../index'
dir = "#{__dirname}/source_folder"
fs.mkdirp dir,'0777',(err)->
    if err
        console.log err
    else
        console.log "mkdirp #{dir} success."