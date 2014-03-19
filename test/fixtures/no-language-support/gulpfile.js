require('coffee-script/register')
var gulp = require('gulp'),
    accord = require('./../../..');

gulp.task('default', function(){
  gulp.src('./test.jade')
  .pipe(accord('wow', { doge: true }))
  .pipe(gulp.dest('./out'))
});
