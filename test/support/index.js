var chai = require('chai'),
    accord = require('../..'),
    chai_fs = require('chai-fs');

var should = chai.should();
chai.use(chai_fs);

global.accord = accord;
global.should = should;
