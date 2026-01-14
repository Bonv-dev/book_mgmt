class LogsController < ApplicationController
  before_action :set_log, only: %i[ show edit update destroy ]
  before_action :set_list

  # GET /logs or /logs.json
  def index
    @logs = policy_scope(Log)
  end

  # GET /logs/1 or /logs/1.json
  def show
    authorize @log
  end

  # GET /logs/new
  def new
    @log = Log.new
    authorize @log
  end

  # GET /logs/1/edit
  def edit
    authorize @log
  end

  # POST /logs or /logs.json
  def create
    @log = Log.new(log_params)
    authorize @log

    respond_to do |format|
      if @log.save
        format.html { redirect_to @log, notice: "Log was successfully created." }
        format.json { render :show, status: :created, location: @log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    authorize @log

    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: "Log was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1 or /logs/1.json
  def destroy
    authorize @log
    @log.destroy!

    respond_to do |format|
      format.html { redirect_to logs_path, notice: "Log was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params.expect(:id))
    end

    def set_list
      @book_list = Book.name_list
      @book_options = Book.name_options
      @user_list = User.name_list
      @user_options = User.name_options
    end

    # Only allow a list of trusted parameters through.
    def log_params
      params.expect(log: [ :status, :book_id, :user_id ])
    end
end
