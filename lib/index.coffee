gutil  = require 'gulp-util'
accord = require 'accord'
map    = require 'map-stream'
path   = require 'path'

module.exports = (lang, opts) ->
  PLUGIN_NAME = 'gulp-accord'

  # If accord doesn't support the given language, error
  if not accord.supports(lang)
    throw new Error("#{PLUGIN_NAME}: Language '#{lang}' not supported")

  # Load the package for the compiler. This uses module.parent to load it
  # from the user-installed node_modules correctly.
  try adapter = accord.load(lang, path.join(module.parent.paths[0], lang))
  catch err
    throw new Error("#{PLUGIN_NAME}: #{lang} not installed. Try 'npm i #{lang} -S'")

  # Return a mapped stream
  map (file, cb) ->
    if file.isNull() then return cb()

    if file.isStream()
      return cb(new gutil.PluginError(PLUGIN_NAME, "streams not supported!"))

    # Decode the contents, compile them, re-encode the compiled contents
    # back into the file object, and return it.
    if file.isBuffer()
      adapter.render(String(file.contents), opts)
      .then((res) -> file.contents = new Buffer(res))
      .done (-> cb(null, file)), (err) ->
        cb(new gutil.PluginError(PLUGIN_NAME, err))
