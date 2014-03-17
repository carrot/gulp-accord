gutil         = require 'gulp-util'
accord        = require 'accord'
map           = require 'map-stream'
StringDecoder = require('string_decoder').StringDecoder
decoder       = new StringDecoder

module.exports = (lang, opts) ->

  if not accord.supports(lang)
    throw new Error("gulp-accord: Language '#{lang}' not supported")

  map (file, cb) ->
    adapter = accord.load(lang)

    adapter.render(decoder.write(file.contents), opts)
      .done ((res) -> cb(null, res)), (err) ->
        cb(new gutil.PluginError('gulp-accord', err))
