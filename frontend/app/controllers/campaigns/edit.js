import Ember from 'ember';
// import ajax from 'ic-ajax';

export default Ember.Controller.extend({
  ajax: Ember.inject.service(),

  recipients: Ember.computed('store', function() {
    return this.store.findAll('recipient');
  }),

  selectedRecipients: Ember.computed.alias('model.recipients'),

  // setSelectedRecipients: function() {
  //   this.set('selectedRecipients', this.get('model.recipients'))
  // }.on('init')

  // allRecipients: Ember.computed('recipients', function() {
  //   let recipients = this.get('recipients').clone()
  //   debugger
  //   for (recipient in recipients) {
  //     recipient.fullName = recipient.firstName + recipient.lastName
  //   }
  //   debugger
  //   return recipients
  // }),

  actions: {
    send(model) {
      this.get('ajax').post('/send_campaign_campaigns', {
        data: model
      }).then(function(response) {
        model.set('sent', true);
        model.save();
        this.send('transitionToCampaigns');
      });
    },
    saveDraft(model) {
      model.save();
      this.send('transitionToCampaigns')
    },
    cancel(model) {
      this.store.deleteRecord(model);
      this.send('transitionToCampaigns');
    }
  }

});
