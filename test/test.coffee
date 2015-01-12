fs        = require 'fs'
path      = require 'path'
Util      = require 'roots-util'
node      = require 'when/node'
run       = require('child_process').exec
test_path = path.join(__dirname, 'fixtures')
util      = new Util.Helpers(base: test_path)

# make sure all tests with deps have them installed
before (done) ->
  util.project.install_dependencies('*', done)

# remove output
after ->
  util.project.remove_folders('**/out')

describe 'basic', ->

  it 'should compile with options', (done) ->
    p = path.join(test_path, 'basic')
    node.call(run, "gulp", { cwd: p })
      .catch(done)
      .done ->
        out = fs.readFileSync(path.join(p, 'out/test.html'), 'utf8')
        out.should.equal("\n<p>wow</p>\n<p>such testz</p>")
        done()

  it 'should handle accord compile errors', (done) ->
    p = path.join(test_path, 'compile-error')
    node.call(run, "gulp", { cwd: p })
      .done(done, (-> done()))

  it 'should handle plugin input errors', (done) ->
    p = path.join(test_path, 'no-language-support')
    node.call(run, "gulp", { cwd: p })
      .done done, (err) ->
        err.toString().should.match(/Command failed/)
        done()

  it 'should handle package not installed error', (done) ->
    p = path.join(test_path, 'pkg-not-installed')
    node.call(run, "gulp", { cwd: p })
      .done done, (err) ->
        err.toString().should.match(/Command failed/)
        done()

  it 'should render sourcemaps', (done) ->
    p = path.join(test_path, 'sourcemaps')
    node.call(run, "gulp", { cwd: p })
      .done ->
        path.join(p, 'out/test.css').should.be.a.file()
        path.join(p, 'out/test.css.map').should.be.a.file()
        done()
      , done
