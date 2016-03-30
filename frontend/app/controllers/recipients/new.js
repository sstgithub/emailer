import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    submit(model) {
      model.save();
      this.send('transitionToRecipients');
    },
    cancel(model) {
      this.store.deleteRecord(model);
      this.send('transitionToRecipients');
    }
  }

});
