# gulp-cod [![Build Status](https://drone.io/github.com/namuol/gulp-cod/status.png)](https://drone.io/github.com/namuol/gulp-cod/latest) [![Module Version](http://img.shields.io/npm/v/gulp-cod.svg?style=flat)](https://www.npmjs.org/package/gulp-cod)

[gulp](https://github.com/gulpjs/gulp) plugin for [cod](http://github.com/namuol/cod)

## usage

```js
var gulp = require('gulp'),
    cod = require('gulp-cod');

gulp.task('cod', function () {
  gulp.src('src/*.js')
  .pipe(cod())
  .pipe(gulp.dest('./docs'));
});
```

```js
var gulp = require('gulp'),
    cod = require('gulp-cod');

gulp.task('cod', function () {
  gulp.src('src/*.coffee')
  .pipe(cod({
    docBegin: '###*',
    docEnd: '###',
    pretty: false
  }))
  .pipe(gulp.dest('./docs'));
});
```

A `.json` file will be created for each input source file.

If you want to combine multiple input files into a single API doc file, use [`gulp-concat`](https://github.com/wearefractal/gulp-concat):

```js
var gulp = require('gulp'),
    concat = require('gulp-concat'),
    cod = require('gulp-cod');

gulp.task('cod', function () {
  gulp.src('src/*.js')
  .pipe(concat('all.js'))
  .pipe(cod())
  .pipe(gulp.dest('./docs'));
});
```

## install

```
npm install gulp-cod --save
```

## license

MIT

---

[![Analytics](https://ga-beacon.appspot.com/UA-33247419-2/gulp-cod/README.md)](https://github.com/igrigorik/ga-beacon)
