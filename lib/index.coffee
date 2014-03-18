gutil         = require 'gulp-util'
accord        = require 'accord'
map           = require 'map-stream'

module.exports = (lang, opts) ->

  PLUGIN_NAME = 'gulp-accord'

  if not accord.supports(lang)
    throw new Error("#{PLUGIN_NAME}: Language '#{lang}' not supported")

  try adapter = accord.load(lang)
  catch err
    throw new Error("#{PLUGIN_NAME}: #{lang} not installed. Try 'npm i #{lang} -S'")

  map (file, cb) ->
    adapter.render(String(file.contents), opts)
    .done ((res) -> cb(null, res)), (err) ->
      cb(new gutil.PluginError(PLUGIN_NAME, err))
