class Recipient < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
end
