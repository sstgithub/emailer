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
    new_attr["campaign_ids"] = rel.campaigns.data.map(function(obj) {
      return obj.id
    });
    return {recipient: new_attr};

    // return Object.keys(rel).reduce(function(acc, elem) {
    //   const data = rel[elem].data;
    //   if (data) {
    //     acc[elem + "_id"] = data.id;
    //   }
    //   if (data && data.type) {
    //     debugger
    //     acc[elem + "_type"] = data.type[0].toUpperCase() + data.type.slice(1, -1);
    //   }
    //   return acc;
    //
    // }, attr);
 }
});
