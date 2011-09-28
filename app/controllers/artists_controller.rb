class ArtistsController < InheritedResources::Base#ApplicationController
  #queries :artist do
  #  match :name
  #end
  
  def index
    @artists = Artist
    @artists = @artists.where(deli) if deli.present?
    #@artists = Artist.all
  end
  
  def show
    @artist = Artist.where(:key => params[:id]).first
  end
end
