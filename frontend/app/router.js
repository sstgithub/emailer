import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('campaigns');
  this.route('recipients', function() {
    this.route('new');
    this.route('edit', {path: 'edit/:recipient_id'})
  });
});

export default Router;
