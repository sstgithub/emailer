import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    delete(id) {
      this.store.findRecord('recipient', id).then(function(recipient) {
        recipient.destroyRecord();
      });
    }
  }
});
