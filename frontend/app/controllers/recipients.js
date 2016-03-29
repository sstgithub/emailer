import Ember from 'ember';

export default Ember.Controller.extend({
  //NOTE: this is not the way to do this. Normally, model.recipients and
  // model.campaigns should give us what we need.
  // recipients: Ember.computed('model', 'controller.model', function() {
  //   let recipients = [];
  //   for (let value of this.get('model.recipients.content')) {
  //     recipients.push(Ember.Object.create(value._data));
  //   };
  //   return recipients;
  // })
  // setRecipientsAndCampaigns: function() {
  //   debugger
  //   var store = this.store
  //   let recipients = [];
  //   for (let value of this.get('model.recipients.content')) {
  //     recipients.push(Ember.Object.create(value._data));
  //   };
  //   this.set('recipients', recipients);
  //   debugger
  //   let campaigns = [];
  //   for (let value of this.get('model.campaigns.content')) {
  //     campaigns.push(Ember.Object.create(value._data));
  //   };
  //   this.set('campaigns', campaigns);
  // }.observes('model.@each')
  actions: {
    delete(id) {
      this.store.findRecord('recipient', id).then(function(recipient) {
        recipient.destroyRecord();
      });
    }
  }
});
