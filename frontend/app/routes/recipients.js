import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return Ember.RSVP.hash({
      recipients: this.store.findAll('recipient'),
      campaigns: this.store.findAll('campaign')
    });
  }

  // afterModel: function(model) {
  //   debugger
  //   let recipients = [];
  //   for (let value of model.recipients.content) {
  //     recipients.push(Ember.Object.create(value._data));
  //   };
  //   let campaigns = [];
  //   for (let value of model.campaigns.content) {
  //     campaigns.push(Ember.Object.create(value._data));
  //   };
  //   model.set('recipients', recipients);
  //   model.set('campaigns', campaigns);
  // },

  // setupController: function(controller, model) {
  //   debugger
  //   controller.set('model', model);
  //   // let recipients = [];
  //   // for (let value of model.recipients.content) {
  //   //   recipients.push(Ember.Object.create(value._data));
  //   // };
  //   // let campaigns = [];
  //   // for (let value of model.campaigns.content) {
  //   //   campaigns.push(Ember.Object.create(value._data));
  //   // };
  //   // controller.set('recipients', recipients);
  //   // controller.set('campaigns', campaigns);
  // }
});
