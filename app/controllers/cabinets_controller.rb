class CabinetsController < ApplicationController
  before_action :set_cabinet, only: %i[ show edit update destroy ]
  before_action :set_list

  # GET /cabinets or /cabinets.json
  def index
    @cabinets = policy_scope(Cabinet)
  end

  # GET /cabinets/1 or /cabinets/1.json
  def show
    authorize @cabinet
  end

  # GET /cabinets/new
  def new
    @cabinet = Cabinet.new
    authorize @cabinet
  end

  # GET /cabinets/1/edit
  def edit
    authorize @cabinet
  end

  # POST /cabinets or /cabinets.json
  def create
    @cabinet = Cabinet.new(cabinet_params)
    authorize @cabinet

    respond_to do |format|
      if @cabinet.save
        format.html { redirect_to @cabinet, notice: "Cabinet was successfully created." }
        format.json { render :show, status: :created, location: @cabinet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cabinet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cabinets/1 or /cabinets/1.json
  def update
    authorize @cabinet

    respond_to do |format|
      if @cabinet.update(cabinet_params)
        format.html { redirect_to @cabinet, notice: "Cabinet was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @cabinet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cabinet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cabinets/1 or /cabinets/1.json
  def destroy
    authorize @cabinet
    @cabinet.destroy!

    respond_to do |format|
      format.html { redirect_to cabinets_path, notice: "Cabinet was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cabinet
      @cabinet = Cabinet.find(params.expect(:id))
    end

    def set_list
      @floor_list = Floor.name_list
      @floor_options = Floor.name_options
    end

    # Only allow a list of trusted parameters through.
    def cabinet_params
      params.expect(cabinet: [ :enabled, :name, :floor_id ])
    end
end
