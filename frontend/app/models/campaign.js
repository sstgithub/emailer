import DS from 'ember-data';

export default DS.Model.extend({
  campaignName: DS.attr('string'),
  emailBody: DS.attr('string'),
  emailSubject: DS.attr('string'),
  sent: DS.attr('boolean'),
  recipients: DS.hasMany('recipient')
});
