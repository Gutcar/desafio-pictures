class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :authorize_admin, only: [:new, :create, :destroy]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
    @picture = Picture.find(params[:id])
    @comments = @picture.comments
  end

  def new_comment
    @comment = Comment.new
  end

  def show_and_new_comment
    show
    new_comment
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # POST /pictures or /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to show_and_new_comment_picture_path(@picture), notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:legend, :user_id, images: [])
    end

    def authorize_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'Solo Karina puede subir nuevas fotografías.'
      end
    end
end
