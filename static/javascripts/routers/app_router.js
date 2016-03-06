var Backbone = require('backbone');
var $ = require('jquery');
var Twzzlz = require('./../collections/twzzlz');
var TwzzlzIndex = require('./../views/twzzlz/index');

module.exports = Backbone.Router.extend({
    routes: {
        "root": "root",
        "twzzlz": "twzzlz"
    },
    
    initialize: function(options){
        this.$rootEl = options.$rootEl;
    },
    
    root: function() {
        var twzzlz = new Twzzlz();
        twzzlz.fetch();
        
        var twzzlzIndex = new TwzzlzIndex({
            collection: twzzlz
        });
        
        this._swapView(twzzlzIndex);
    },
    
    twzzlz: function() {
        console.log('twzzlz');
    },
    
    _swapView: function(view) {
        this._currentView && this._currentView.remove();
        this._currentView = view;
        this.$rootEl.html(view.render().$el);
    }
});

