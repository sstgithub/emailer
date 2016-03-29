#use json api adapter since that is most compatible with Ember and necessary
# to avoid recursive infinite loops with has_and_belongs_to_many relationship
ActiveModel::Serializer.config.adapter = :json_api

ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::Type.lookup('application/vnd.api+json')]=lambda do |body|
  JSON.parse(body)
end
