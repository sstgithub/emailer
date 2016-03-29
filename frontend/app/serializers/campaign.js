import DS from 'ember-data';

export default DS.JSONAPISerializer.extend({
  //AMS cannot handle incoming JSONAPI
  serialize() {
    const result = this._super(...arguments),
      attr = result.data.attributes || {},
      rel = result.data.relationships || {};
    let new_attr = {};
    for (let val of Object.keys(attr)) {
      new_attr[val.replace('-','_')] = attr[val]
    };
    new_attr["recipient_ids"] = rel.recipients.data.map(function(obj) {
      return obj.id
    });
    return {campaign: new_attr};
 }
});
