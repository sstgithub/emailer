#use json api adapter since that is most compatible with Ember and necessary
# to avoid recursive infinite loops with has_and_belongs_to_many relationship
ActiveModel::Serializer.config.adapter = :json_api
