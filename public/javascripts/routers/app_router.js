Twzzlr.Routers.AppRouter = Backbone.Router.extend({
    routes: {
        "": "root"
    },
    
    initialize: function(options){
        this.$rootEl = options.$rootEl;
    },
    
    root: function() {
        console.log('root function!');
    }
});