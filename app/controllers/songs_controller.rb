class SongsController < InheritedResources::Base#ApplicationController
  belongs_to :artist
  #queries :song do
  #  match :name
  #end
  
  def index
    @songs = parent.songs
    @songs = @songs.where(deli) if deli.present?
    #@songs = Song.all
  end
  
  def show
    @song = parent.songs.where(:key => params[:id]).first
  end
  
  def edit
    @song = parent.songs.where(:key => params[:id]).first
  end
  
  def parent
    @artist ||= Artist.where(:key => params[:artist_id]).first
  end
  
  def create
    @song = Song.new(params[:song])
    @song.artist = parent
    create! 
  end
  
  def update
    @song = parent.songs.where(:key => params[:id]).first
    #raise @song.inspect
    #@song.artist = parent
    update!
  end
end
