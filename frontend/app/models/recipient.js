import DS from 'ember-data';

export default DS.Model.extend({
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  emailAddress: DS.attr('string'),
  salutation: DS.attr('string'),
  sent: DS.attr('boolean'),
  campaigns: DS.hasMany('campaign')
});
