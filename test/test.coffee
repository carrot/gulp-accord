require('colors')
should    = require 'should'
gulp      = require 'gulp'
accord    = require '..'
fs        = require 'fs'
path      = require 'path'
glob      = require 'glob'
W         = require 'when'
node      = require 'when/node'
test_path = path.join(__dirname, 'fixtures')
run       = require('child_process').exec
rimraf    = require('rimraf')

# make sure all tests with deps have them installed
before (done) ->
  tasks = []
  # i think glob.sync doesnt work
  for d in glob.sync("#{test_path}/*/package.json")
    p = path.dirname(d)
    if fs.existsSync(path.join(p, 'node_modules')) then continue
    console.log "  installing deps for '#{d.replace(__dirname,'').replace('package.json','')}'...".grey
    tasks.push node.call(run, "npm install", { cwd: p })
  W.all(tasks).then(-> done())
  console.log('')

# remove output
after ->
  rimraf.sync(out_dir) for out_dir in glob.sync('test/fixtures/**/out')

describe 'basic', ->

  it 'should compile with options', (done) ->
    p = path.join(test_path, 'basic')
    node.call(run, "gulp", { cwd: p })
      .catch(done)
      .done ->
        out = fs.readFileSync(path.join(p, 'out/test.jade'), 'utf8')
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
