import Ember from 'ember';
// import ajax from 'ic-ajax';

export default Ember.Controller.extend({
  ajax: Ember.inject.service(),

  recipients: Ember.computed('store', function() {
    return this.store.findAll('recipient');
  }),

  selectedRecipients: Ember.computed.alias('model.recipients'),

  actions: {
    send(model) {
      let controller = this;
      this.get('ajax').request('/campaigns/send_campaign', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json'
        },
        data: model.serialize()
      }).then(function() {
        model.set('sent', true);
        model.save();
        controller.send('transitionToCampaigns');
      });
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
