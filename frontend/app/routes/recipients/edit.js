import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    transitionToRecipients: function() {
      this.transitionTo('recipients')
    }
  }
});
