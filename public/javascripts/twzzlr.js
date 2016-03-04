var $ = require('jquery');

window.Twzzlr = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function(){
        var $rootEl = $("#main");
        
        new Twzzlr.Routers.AppRouter({
            $rootEl: $rootEl
        });
        Backbone.history.start();
    }
};

$(document).ready(function(){
    console.log('heelo');
    Twzzlr.initialize();
});