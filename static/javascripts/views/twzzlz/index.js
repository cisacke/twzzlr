var Backbone = require('backbone');
// var TwzzlzIndexTpl = require('./../../templates/twzzlz/index.html');
var _ = require('underscore');

var TwzzlzIndex = Backbone.View.extend({
    template: JST['templates/index'],
    
    initialize: function(){
        this.listenTo(this.collection, 'sync', this.render);
    },
    
    render: function() {
        debugger
        var content = this.template({
            twzzlz: this.collection
        });
        console.log(this.template);
        this.$el.html(content);
        return this;
    }
});

module.exports = TwzzlzIndex;