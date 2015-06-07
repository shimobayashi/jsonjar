require 'mongoid'
require 'json'

class Jar
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data, type: Hash, default: {}

  scope :recent, ->{ desc(:created_at) }

  index({ created_at: 1 }, {})

  def self.latest
    recent.first
  end

  def to_json
    self.data.to_json
  end
end
