import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('campaigns', function() {
    this.route('new', {path: 'new'});
    this.route('edit', {path: 'edit/:campaign_id'});
  });
  this.route('recipients', function() {
    this.route('edit', {path: 'edit/:recipient_id'});
    this.route('new', {path: 'new'});
  });
});

export default Router;
