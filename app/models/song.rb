class Song
  include Mongoid::Document
  
  field :name
  field :data, :type => ::String
  field :key
  
  belongs_to :artist
  
  validates :key, :uniqueness => {:scope => :album_id}, :on => :create
  
  before_validation :set_key
  
  def set_key
    self.key ||= name.to_url
  end
  
  def to_param
    key
  end
  
  def title
    artist.present? ? [artist.name, name].select(&:present?).join("<br/>") : name
  end
  
  class << self
    def parse(string)
      string.gsub!(/\n+/, "\n")
      previous_line = ""
      current_line = nil
      string.each_line do |line|
        next unless line =~ /^\|[\|\-]/
        line.gsub!(/^\|+/, "")
        line.gsub!(/^-[TAB]-/, "")
      end
    end
  end
end
