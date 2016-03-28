import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    this.store.findAll('recipient');
    return this.store.findAll('campaign');
  }
});
