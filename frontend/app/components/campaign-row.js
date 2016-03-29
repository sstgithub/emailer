import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'tr',
  totalRecipients: Ember.computed('campaign', function() {
    return this.get('campaign').get('recipients').uniq('emailAddress').length
  }),

  actions: {
    delete(id) {
      this.store.findRecord('campaign', id).then(function(campaign) {
        campaign.destroyRecord();
      });
    }
  }
});
