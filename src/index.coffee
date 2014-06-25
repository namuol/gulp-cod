gutil = require 'gulp-util'
Transform = require('stream').Transform
through = require 'through'
cod = require 'cod'

module.exports = (options) ->
  stream = new Transform (objectMode: true)

  stream._transform = (file, unused, done) ->
    if file.isNull()
      stream.push file
      done()
      return

    if file.isStream()
      @emit 'error', new Error 'gulp-cod: Streaming not supported'
      return

    contents = ''

    file.pipe cod options
    .pipe through (data) ->
      contents += data
    , ->
      file.path = gutil.replaceExtension file.path, '.json'
      file.contents = new Buffer contents
      stream.push file
      done()

  return stream
