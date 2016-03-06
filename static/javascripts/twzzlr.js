$ = jQuery = require('jquery');
var Router = require('./routers/app_router');
var Backbone = require('backbone');
// require('bootstrap');

window.Twzzlr = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function(){
        var $rootEl = $("#main");
        
        new Router({
            $rootEl: $rootEl
        });
        Backbone.history.start();
    }
};

$(document).ready(function(){
    console.log('heelo');
    Twzzlr.initialize();
});