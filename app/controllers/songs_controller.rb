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
    create! do |success, failure| 
      success.html { redirect_to song_path(@song.artist, @song.key) }
    end 
  end
  
  def update
    @song = parent.songs.where(:key => params[:id]).first
    #raise @song.inspect
    @song.artist = parent
    @song.update_attributes(params[:song])
    redirect_to song_path(@song.artist.to_param, @song.key)
    return
  end
end
