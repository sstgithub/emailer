import Ember from 'ember';

export default Ember.Controller.extend({
  ajax: Ember.inject.service(),

  actions: {
    submit(model) {
      // let serialization = model.serialize();
      // this.get('ajax').request('/recipients/'+model.get('id'), {
      //   method: 'PATCH',
      //   headers: {
      //       'Content-Type': 'application/vnd.api+json',
      //       'Accept': 'application/vnd.api+json'
      //   },
      //   data: serialization
      // });
      model.save();
      this.send('transitionToRecipients');
    },
    cancel(model) {
      this.store.deleteRecord(model);
      this.send('transitionToRecipients');
    }
  }
});
