class BlogSuggestionsController < ApplicationController
  before_action :set_blog_suggestion, only: %i[ show edit update destroy ]

  # GET /blog_suggestions or /blog_suggestions.json
  def index
    @blog_suggestions = BlogSuggestion.all
  end

  # GET /blog_suggestions/1 or /blog_suggestions/1.json
  def show
  end

  # GET /blog_suggestions/new
  def new
    @blog_suggestion = BlogSuggestion.new
  end

  # GET /blog_suggestions/1/edit
  def edit
  end

  # POST /blog_suggestions or /blog_suggestions.json
  def create
    @blog_suggestion = BlogSuggestion.new(blog_suggestion_params)

    respond_to do |format|
      if @blog_suggestion.save
        format.html { redirect_to root_path, notice: "Blog suggestion was successfully created." }
        format.json { render :show, status: :created, location: @blog_suggestion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_suggestions/1 or /blog_suggestions/1.json
  def update
    respond_to do |format|
      if @blog_suggestion.update(blog_suggestion_params)
        format.html { redirect_to root_path, notice: "Blog suggestion was successfully updated." }
        format.json { render :show, status: :ok, location: @blog_suggestion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_suggestions/1 or /blog_suggestions/1.json
  def destroy
    @blog_suggestion.destroy
    respond_to do |format|
      format.html { redirect_to blog_suggestions_url, notice: "Blog suggestion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_suggestion
      @blog_suggestion = BlogSuggestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_suggestion_params
      params.require(:blog_suggestion).permit(:title, :status, :description)
    end
end
