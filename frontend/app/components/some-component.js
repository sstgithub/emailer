import Ember from 'ember';

export default Ember.Component.extend({
  recipients: Ember.computed('recipientos', function() {
    debugger
    return this.get('recipientos');
  })
});
