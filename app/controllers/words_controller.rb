class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def rhyme
    if params[:match_string]
      #@words = Word.where(value: params[:match_string])
      @words = Word.where("value LIKE '%#{params[:match_string]}'")
    else
      @words = []
    end
  end

  # GET /new_words
  def new_words
  end

  # POST /create_words
  def create_words
    params[:words].split.each do |word|
      Word.new(value: word).save
    end
    redirect_to words_path
  end

  # GET /words
  # GET /words.json
  def index
    starting = params[:id].nil? ? 'а' : params[:id]
    @words = Word.where(["`value` like ?","#{starting}%"]).order(:value)
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:value, :match_string)
    end
end
