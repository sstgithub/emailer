import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    this.store.findAll('campaign');
    return this.store.findAll('recipient');
  }
});
