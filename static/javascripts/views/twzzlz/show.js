var Backbone = require('backbone');
var _ = require('underscore');

var TwzzlShow = Backbone.View.extend({
    template: JST['templates/show'],
    
    initialize: function(){
        this.listenTo(this.model, 'sync', this.render);
    },
    
    render: function(){
        var content = this.template({
            model: this.model
        });
        
        this.$el.html(content);
        return this;
    }
});

module.exports = TwzzlShow;