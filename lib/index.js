var Transform, cod, gutil, through;

gutil = require('gulp-util');

Transform = require('stream').Transform;

through = require('through');

cod = require('cod');

module.exports = function(options) {
  var stream;
  stream = new Transform({
    objectMode: true
  });
  stream._transform = function(file, unused, done) {
    var contents;
    if (file.isNull()) {
      stream.push(file);
      done();
      return;
    }
    if (file.isStream()) {
      this.emit('error', new Error('gulp-cod: Streaming not supported'));
      return;
    }
    contents = '';
    return file.pipe(cod(options)).pipe(through(function(data) {
      return contents += data;
    }, function() {
      file.path = gutil.replaceExtension(file.path, '.json');
      file.contents = new Buffer(contents);
      stream.push(file);
      return done();
    }));
  };
  return stream;
};
