import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    transitionToCampaigns: function() {
      this.transitionTo('campaigns')
    }
  }
});
