fs = require 'fs'
path = require 'path'
tape = require 'tape'
File = require 'vinyl'
through = require 'through'

cod = require 'cod'
gcod = require '../src/index'

describe = (item, cb) ->
  it = (capability, test) ->
    tape.test item + ' ' + capability, test

  cb it

describe 'gulp-cod', (it) ->
  tryCod = (t, file, options={}) ->
    inputFilename = path.join __dirname, 'fixtures', file

    expectedOutput = ''
    
    fs.createReadStream(inputFilename)
    .pipe cod options
    .pipe through (data) ->
      expectedOutput += data
    , ->
      bufferInput = new File
        contents: fs.readFileSync inputFilename

      codder = gcod options

      codder.once 'error', (err) ->
        t.fail err
        t.end()

      codder.once 'data', (output) ->
        t.assert output.isBuffer(), 'the output is a buffer'
        t.equal output.contents.toString('utf8'), expectedOutput
        t.end()

      codder.write bufferInput

  it 'should emit an error for streaming mode', (t) ->
    fakeFile = new File
      contents: fs.createReadStream path.join __dirname, 'fixtures', 'test.c'

    codder = gcod()

    codder.once 'error', (err) ->
      t.equal err.message, 'gulp-cod: Streaming not supported'
      t.end()

    codder.once 'data', ->
      t.fail('We got `data` when we shouldn\'t have.')
      t.end()

    codder.write fakeFile

  it 'should process files identically to calling cod(input)', (t) ->
    tryCod t, 'test.c'

  it 'should obey docBegin/docEnd options', (t) ->
    tryCod t, 'test.foo',
      docBegin: '###*'
      docEnd: '###'

  it 'should obey the pretty: false', (t) ->
    tryCod t, 'test.c',
      pretty: false

  it 'should obey the pretty: true', (t) ->
    tryCod t, 'test.c',
      pretty: true
