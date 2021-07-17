class CloudsController < ApplicationController
  before_action :set_cloud, only: %i[ show edit update destroy ]

  # GET /clouds or /clouds.json
  def index
    @clouds = Cloud.all
  end

  # GET /clouds/1 or /clouds/1.json
  # def show
  # end

  # GET /clouds/new
  def new
    @cloud = Cloud.new
  end

  # GET /clouds/1/edit
  def edit
  end

  # POST /clouds or /clouds.json
  def create
    @cloud = Cloud.new(cloud_params)
    if @cloud.save
      redirect_to clouds_url
    else
      render :new
    end
  end

  # PATCH/PUT /clouds/1 or /clouds/1.json
  def update
    @cloud = Cloud.find(params[:id])
    if @cloud.update_attributes(cloud_params)
      redirect_to clouds_url
    else
      render :edit
    end
  end

  # DELETE /clouds/1 or /clouds/1.json
  def destroy
    @cloud = Cloud.find(params[:id]).destroy
    redirect_to clouds_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cloud
      @cloud = Cloud.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cloud_params
      params.require(:cloud).permit(:name, :vendor)
    end
end
