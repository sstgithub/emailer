import { moduleFor, test } from 'ember-qunit';
import FakeServer, { stubRequest } from 'ember-cli-fake-server';

moduleFor('controller:campaigns/edit', 'Unit | Controller | campaigns/edit', {
  // Specify the other units that are required for this test.
  // needs: ['controller:foo']
});

test('send button should send campaign and save campaign as sent', function(assert) {
  let controller = this.subject();
  let didCallAjax = false;
  stubRequest('post', '/send_campaign_campaigns', (request) => {
    request.create({campaign: {emailBody: 'body', emailSubject: 'subject', campaignName: 'name', sent: false, recipientIds: [1,2,3]}});
  });
  stubRequest('post', '/campaigns', (request) => {
    didCallAjax = true;
    request.create({campaign: {emailBody: 'body', emailSubject: 'subject', campaignName: 'name', sent: true, recipientIds: [1,2,3]}});
  });
  controller.send('send', Ember.Object.create({emailBody: 'body', emailSubject: 'subject', campaignName: 'name', sent: false, recipientIds: [1,2,3]}));
  assert.equal(controller.get('model'), {emailBody: 'body', emailSubject: 'subject', campaignName: 'name', sent: true, recipientIds: [1,2,3]});
});
