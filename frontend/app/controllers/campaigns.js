import Ember from 'ember';

export default Ember.Controller.extend({
  sentCampaigns: Ember.computed.filterBy('model.campaigns', 'sent', true),
  unsentCampaigns: Ember.computed.filterBy('model.campaigns', 'sent', false)
});
