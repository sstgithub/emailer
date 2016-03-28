class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :recipients

  validates_uniqueness_of :campaign_name
end
