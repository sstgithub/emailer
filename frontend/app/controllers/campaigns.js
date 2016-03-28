import Ember from 'ember';

export default Ember.Controller.extend({
  something: function() {
    console.log(this.get('controller'));
    console.log(this.get('model'));
    debugger
  }.observes('controller', 'model')
});
