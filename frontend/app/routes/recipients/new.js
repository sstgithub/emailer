import Ember from 'ember';

export default Ember.Route.extend({
    model: function() {
      return this.store.createRecord('recipient');
    },

    actions: {
      transitionToRecipients: function() {
        this.transitionTo('recipients');
      }
    }
});
