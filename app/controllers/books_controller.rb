class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_list

  # GET /books or /books.json
  def index
    @q = policy_scope(Book).ransack(params.fetch(:q, {}))
    @books = @q.result
  end

  # GET /books/1 or /books/1.json
  def show
    authorize @book
  end

  # GET /books/new
  def new
    @book = Book.new
    authorize @book
    prepare_place
  end

  # GET /books/1/edit
  def edit
    authorize @book
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    authorize @book
    prepare_place

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    authorize @book
    message = policy(@book).update_violation_message(book_params)
    if message.present?
      redirect_to root_path, alert: message, status: :see_other
      return
    end

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    authorize @book

    respond_to do |format|
      if @book.destroy
        format.html { redirect_to books_path, notice: "Book was successfully destroyed.", status: :see_other }
        format.json { head :no_content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /books/select_place
  def select_place
    authorize Book

    @cabinets = Cabinet.where(floor_id: params.expect(:floor_id))
    @cabinet = Cabinet.find_by_id(params[:cabinet_id])
    @steps = Step.where(cabinet_id: @cabinet&.id)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params.expect(:id))
      prepare_place
    end

    def set_list
      @category_list = Category.name_list
      @category_options = Category.name_options
      @step_list = Step.floor_cabinet_step_list
      @step_options = Step.name_options
    end

    def prepare_place
      @floors = Floor.all
      @step = @book.step
      @steps = @step&.cabinet&.steps || []
      @cabinet = @step&.cabinet
      @cabinets = @cabinet&.floor&.cabinets || []
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.expect(book: [ :enabled, :name, :isbn, :category_id, :step_id, :memo ])
    end
end
