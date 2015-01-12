require('coffee-script/register')
var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    accord = require('./../../..');

gulp.task('default', function(){
  gulp.src('./test.styl')
  .pipe(sourcemaps.init())
  .pipe(accord('stylus'))
  .pipe(sourcemaps.write('.'))
  .pipe(gulp.dest('./out'))
});
