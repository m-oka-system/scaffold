class CloudsController < ApplicationController
  before_action :set_cloud, only: %i[ show edit update destroy ]

  # GET /clouds or /clouds.json
  def index
    @clouds = Cloud.all
  end

  # GET /clouds/1 or /clouds/1.json
  def show
  end

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

    respond_to do |format|
      if @cloud.save
        format.html { redirect_to @cloud, notice: "Cloud was successfully created." }
        format.json { render :show, status: :created, location: @cloud }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cloud.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clouds/1 or /clouds/1.json
  def update
    respond_to do |format|
      if @cloud.update(cloud_params)
        format.html { redirect_to @cloud, notice: "Cloud was successfully updated." }
        format.json { render :show, status: :ok, location: @cloud }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cloud.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clouds/1 or /clouds/1.json
  def destroy
    @cloud.destroy
    respond_to do |format|
      format.html { redirect_to clouds_url, notice: "Cloud was successfully destroyed." }
      format.json { head :no_content }
    end
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
