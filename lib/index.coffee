gutil         = require 'gulp-util'
accord        = require 'accord'
map           = require 'map-stream'
StringDecoder = require('string_decoder').StringDecoder
decoder       = new StringDecoder

module.exports = (lang, opts) ->

  map (file, cb) ->
    adapter = accord.load(lang)
    adapter.render(decoder.write(file.contents), opts)
      .done ((res) -> cb(null, res)), cb
