import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.createRecord('campaign');
  },

  actions: {
    transitionToCampaigns: function() {
      this.transitionTo('campaigns');
    }
  }
});
