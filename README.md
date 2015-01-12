gulp-accord
-----------

[![npm](http://img.shields.io/npm/v/gulp-accord.svg?style=flat)](https://badge.fury.io/js/gulp-accord) [![tests](http://img.shields.io/travis/carrot/gulp-accord/master.svg?style=flat)](https://travis-ci.org/carrot/gulp-accord) [![dependencies](http://img.shields.io/gemnasium/carrot/gulp-accord.svg?style=flat)](https://gemnasium.com/carrot/gulp-accord)

A fast, simple, and well-tested way to compile many languages with a unified interface.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

You're hip and modern, and you know that it makes life a lot easier to use compiled languages when you are writing html, css, and/or javascript. So many of your projects use tools like jade, stylus, sass, or coffeescript, and build them out to vanilla html, css, and javascript before deploys. It also just so happens that you use and love gulp as your build tool.

While you can certainly find one-off adapters for each of these languages, wouldn't it be easier if they all had a consistent, unified, and well-tested interface that always supports all options, and the latest version of the language? And wouldn't it be nice to just have to install a single gulp plugin to handle all of them? If you answered yes to any of the above, that is why you should care.

### Language Support

Gulp-accord supports [these languages](https://github.com/jenius/accord#supported-languages) at the moment. Below you can find a usually-up-to-date adapter list:

- [jade](http://jade-lang.com/)
- [ejs](https://github.com/visionmedia/ejs)
- [markdown](https://github.com/chjj/marked)
- [mustache/hogan](https://github.com/twitter/hogan.js)
- [handlebars](https://github.com/wycats/handlebars.js)
- [haml](https://github.com/visionmedia/haml.js)
- [swig](http://paularmstrong.github.io/swig)
- [marc](https://github.com/bredele/marc)
- [toffee](https://github.com/malgorithms/toffee)
- [stylus](http://learnboost.github.io/stylus/)
- [scss](https://github.com/andrew/node-sass)
- [less](https://github.com/less/less.js/)
- [myth](https://github.com/segmentio/myth)
- [coffeescript](http://coffeescript.org/)
- [dogescript](https://github.com/remixz/dogescript)
- [coco](https://github.com/satyr/coco)
- [livescript](https://github.com/gkz/LiveScript)
- [minify-js](https://github.com/mishoo/UglifyJS2)
- [minify-css](https://github.com/GoalSmashers/clean-css)
- [minify-html](https://github.com/kangax/html-minifier)
- [csso](https://github.com/css/csso)

If there are other languages you would like for accord to support, please make your suggestions and pull requests [to accord itself, not to this plugin](https://github.com/jenius/accord#adding-languages).

### Installation

```
npm install --save gulp-accord
```

Also make sure that you have the language you want to compile with accord installed. So for example, if you are using gulp to compile jade, you'd also run `npm install jade --save`. Don't worry too much though, if you forget to do this, the plugin will kindly remind you.

### Usage

Below is an example of basic usage. In this case, we would be using gulp-accord to compile some jade templates.

```js
var accord = require('gulp-accord');

gulp.task('compile', function(){
  gulp.src('templates/*.jade')
  .pipe(accord('jade', { pretty: true }))
});
```

As you can probably infer from this example, the accord plugin takes two arguments, the **name** of the language you are compiling, and the **options** you want to pass to it. The name should be a string, and the options are optional, but if present, should be an object. You can find more information about the available options for each language [here](https://github.com/jenius/accord/tree/master/docs).

### Source Maps

If a language has support for source maps, this plugin will allow you to product them using [gulp's standard sourcemaps tool](https://github.com/floridoo/gulp-sourcemaps). You can use it as specified in the docs, and gulp-accord will produce the sourcemaps for you automatically. For example, the task shown below would compile a stylus file and produce an external sourcemap:

```js
var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    accord = require('gulp-accord');

gulp.task('default', function(){
  gulp.src('./test.styl')
  .pipe(sourcemaps.init())
  .pipe(accord('stylus'))
  .pipe(sourcemaps.write('.'))
  .pipe(gulp.dest('./out'))
});
```

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
