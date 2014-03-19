require('coffee-script/register')
var gulp = require('gulp'),
    accord = require('./../../..');

gulp.task('default', function(){
  gulp.src('./test.styl')
  .pipe(accord('stylus'))
  .pipe(gulp.dest('./out'))
});
