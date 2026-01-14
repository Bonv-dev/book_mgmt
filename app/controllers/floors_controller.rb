class FloorsController < ApplicationController
  before_action :set_floor, only: %i[ show edit update destroy ]

  # GET /floors or /floors.json
  def index
    @floors = policy_scope(Floor)
  end

  # GET /floors/1 or /floors/1.json
  def show
    authorize @floor
  end

  # GET /floors/new
  def new
    @floor = Floor.new
    authorize @floor
  end

  # GET /floors/1/edit
  def edit
    authorize @floor
  end

  # POST /floors or /floors.json
  def create
    @floor = Floor.new(floor_params)
    authorize @floor

    respond_to do |format|
      if @floor.save
        format.html { redirect_to @floor, notice: "Floor was successfully created." }
        format.json { render :show, status: :created, location: @floor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /floors/1 or /floors/1.json
  def update
    authorize @floor

    respond_to do |format|
      if @floor.update(floor_params)
        format.html { redirect_to @floor, notice: "Floor was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @floor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /floors/1 or /floors/1.json
  def destroy
    authorize @floor
    @floor.destroy!

    respond_to do |format|
      format.html { redirect_to floors_path, notice: "Floor was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_floor
      @floor = Floor.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def floor_params
      params.expect(floor: [ :enabled, :name ])
    end
end
