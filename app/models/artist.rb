class Artist
  include Mongoid::Document
  
  field :name
  field :key
  
  has_many :songs
  
  validates :key, :uniqueness => true, :on => :create
  before_validation :set_key
  
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
