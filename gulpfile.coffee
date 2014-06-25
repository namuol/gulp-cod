gulp = require 'gulp'
coffee = require 'gulp-coffee'
cod = require './src'

gulp.task 'build:coffee', ->
  gulp.src 'src/index.coffee'
    .pipe coffee bare: true
    .pipe gulp.dest 'lib'

gulp.task 'test', ->
  gulp.src 'test/fixtures/*.c'
    .pipe cod()
    .pipe gulp.dest './'

gulp.task 'default', ['build:coffee']