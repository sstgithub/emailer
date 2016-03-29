import Ember from 'ember';

export default Ember.Controller.extend({
  ajax: Ember.inject.service(),

  recipients: Ember.computed('store', function() {
    return this.store.findAll('recipient')
  }),

  selectedRecipients: Ember.computed.alias('model.recipients'),

  actions: {
    send(model) {
      return this.get('ajax').request('/send_campaign_campaigns', {
        method: 'POST',
        data: model
      }).then(function(response) {
        debugger
        model.set('sent', true);
        model.save();
        this.send('transitionToCampaigns');
      });
      // post('/send_campaign_campaigns', {data: model}).then(function(response) {
      //   debugger
      //   model.set('sent', true);
      //   model.save();
      //   this.send('transitionToCampaigns');
      // })
    },
    saveDraft(model) {
      model.save();
      this.send('transitionToCampaigns');
    },
    cancel(model) {
      this.store.deleteRecord(model);
      this.send('transitionToCampaigns');
    }
  }

});
