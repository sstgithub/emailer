import Ember from 'ember';

export default Ember.Route.extend({
    model: function() {
      return this.store.createRecord('recipient', {firstName: "", lastName: "", emailAddress: "", salutation: ""})
    },

    actions: {
      transitionToRecipients: function() {
        this.transitionTo('recipients')
      }
    }
});
