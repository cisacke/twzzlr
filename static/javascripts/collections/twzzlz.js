var Backbone = require('backbone');
var Twzzl = require('./../models/twzzl'); 

var Twzzlz = Backbone.Collection.extend({
    url: '/twzzlz',
    model: Twzzl,
});

module.exports = Twzzlz;