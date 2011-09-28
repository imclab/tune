class ArtistsController < InheritedResources::Base#ApplicationController
  #queries :artist do
  #  match :name
  #end
  
  def index
    @artists = Artist
    @artists = @artists.where(deli) if deli.present?
    @artists = @artists.all
  end
  
  def show
    @artist = Artist.where(:key => params[:id]).first
  end
  
  def create
    create! do |success, failure| 
      success.html { redirect_to new_song_path(resource) }
    end
  end
end
