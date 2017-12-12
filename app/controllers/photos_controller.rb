class PhotosController < ApplicationController
  before_action :set_photo, only: [:destroy, :deactivate, :activate]

  # GET /photos
  def index
    @photos = Photo.order(:used, :updated_at)
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo was successfully destroyed.'
  end

  def activate
    @photo.activate
    redirect_to photos_url, notice: 'Photo was successfully activated.'
  end

  def deactivate
    @photo.deactivate
    redirect_to photos_url, notice: 'Photo was successfully deactivated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:image)
    end
end
