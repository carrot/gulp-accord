gutil           = require 'gulp-util'
accord          = require 'accord'
map             = require 'map-stream'
path            = require 'path'
apply_sourcemap = require 'vinyl-sourcemaps-apply'
rext            = require 'replace-ext'

module.exports = (lang, opts = {}) ->
  PLUGIN_NAME = 'gulp-accord'

  # If accord doesn't support the given language, error
  if not accord.supports(lang)
    throw new Error("#{PLUGIN_NAME}: Language '#{lang}' not supported")

  # Load the package for the compiler. This uses module.parent to load it
  # from the user-installed node_modules correctly.
  try adapter = accord.load(lang, path.join(module.parent.paths[0], lang))
  catch err
    throw new Error(
      "#{PLUGIN_NAME}: #{lang} not installed. Try 'npm i #{lang} -S'"
    )

  # Return a mapped stream
  map (file, cb) ->
    if file.isNull() then return cb()

    if file.isStream()
      return cb(new gutil.PluginError(PLUGIN_NAME, "streams not supported!"))

    if file.sourceMap then opts.sourcemap = true

    if not opts.filename then opts.filename = file.path

    # Decode the contents, compile them, re-encode the compiled contents
    # back into the file object, and return it.
    if file.isBuffer()
      adapter.render(String(file.contents), opts)
        .then (res) ->
          file.path = rext(file.path, ".#{adapter.output}")
          file.contents = new Buffer(res.result)
          if res.sourcemap then apply_sourcemap(file, res.sourcemap)
        .done (-> cb(null, file)), (err) ->
          cb(new gutil.PluginError(PLUGIN_NAME, err))
