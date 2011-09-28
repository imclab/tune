class Song
  include Mongoid::Document
  
  field :data, :type => ::String
  field :key
  
  embedded_in :artist, :class_name => "Artist"
  
  before_save :set_key
  
  def set_key
    self.key ||= name.to_url
  end
  
  def to_param
    key
  end
  
  def title
    artist.present? ? "#{artist.name} - #{name}" : name
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