class BaseSerializer < ActiveModel::Serializer
  #dasherize attributes being sent to Ember since forced to use JSON API and
  # AMS doesnt do it for you
  def attributes *args
    super.each_with_object({}) do |(key,val), new_hash|
      new_hash[dasherize(key)] = val
    end
  end

  private

  def dasherize(key)
    key.to_s.dasherize.to_sym
  end
end
