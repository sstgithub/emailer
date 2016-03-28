import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return Ember.RSVP.hash({
      recipients: this.store.findAll('campaign'),
      campaigns: this.store.findAll('recipient')
    });
  },

  setupController: function(controller, model) {
    controller.set('model', model);
  }
});
