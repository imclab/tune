class Artist
  include Mongoid::Document
  
  field :name
  field :key
  
  embeds_many :songs
  
  before_save :set_key
  
  def set_key
    self.key ||= name.to_url
  end
  
  def to_param
    key
  end
  
  def title
    name
  end
end