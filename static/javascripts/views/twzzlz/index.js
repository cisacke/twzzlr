var Backbone = require('backbone');
var _ = require('underscore');
var CompositeView = require('./../../utils/composite');
var TwzzlShow = require('./show');

var TwzzlzIndex = CompositeView.extend({
    template: JST['templates/index'],
    
    initialize: function(){
        this.listenTo(this.collection, 'sync', this.render);
    },
    
    render: function() {
        var content = this.template({
            twzzlz: this.collection
        });
        this.$el.html(content);
        
        _.forEach(this.collection, function(twzzl){
            var twzzlShow = new TwzzlShow({
                model: twzzl
            });

            this.addSubview('.twzzl-show', twzzlShow);
        }.bind(this));
        return this;
    }
});

module.exports = TwzzlzIndex;