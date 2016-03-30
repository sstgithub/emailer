import Ember from 'ember';

export default Ember.Controller.extend({
  sentCampaigns: Ember.computed.filterBy('model.campaigns', 'sent', true),
  unsentCampaigns: Ember.computed.filterBy('model.campaigns', 'sent', false),

  actions: {
    delete(id) {
      this.store.findRecord('campaign', id).then(function(campaign) {
        campaign.destroyRecord();
      });
    }
  }
});
