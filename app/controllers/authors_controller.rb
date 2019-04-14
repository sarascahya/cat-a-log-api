class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]
  has_scope :valid, default: nil, allow_blank: true
  has_scope :by_name, as: :name

  # GET /authors
  def index
    @authors = apply_scopes(Author)
    order_type = params[:order_type]
    if order_type.present?
      if order_type == "ascending"
        @authors = @authors.order(:name)
      elsif order_type == "descending"
        @authors = @authors.order(name: :desc)
      elsif order_type == "newest"
        @authors = @authors.order(updated_at: :desc)
      else order_type == "oldest"
        @authors = @authors.order(:updated_at)
      end
    else
      @authors = @authors.order(:name)
    end
    count = @authors.count
    json_rendered = {}
    
    if params[:page].present?
      per_page = 10	      
      if params[:per_page].present?	
        per_page = params[:per_page].to_i	
      end
      @authors = @authors.page(params[:page]).per(per_page)
      total_page = @authors.total_pages
      json_rendered["meta"] = {count: count, page_count: total_page, per_page: per_page}
    else
      json_rendered["meta"] = {count: count}
    end
    @data = json_data(@authors)
    json_rendered["data"] = @data
    render json: json_rendered
  end

  # GET /authors/1
  def show
    unless @author.nil?
      render json: {data: json_data(@author)}
    else
      render json: {errors: "Couldn't find Author with 'id'=#{params[:id]}"}, status: :unprocessable_entity
    end
  end

  # POST /authors
  def create
    @author = Author.new(author_params)
    if @author.save
      render json: {data: json_data(@author)}, status: :created
    else
      render json: {errors: json_data(@author.errors)}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      render json: {data: json_data(@author)}
    else
      render json: {errors: json_data(@author.errors)}, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    if @author.delete
      render json: {data: json_data(@author)}, status: :ok
    else
      render json: {errors: delete(@author.errors)}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = apply_scopes(Author).find(params[:id]) rescue nil
    end

    # Only allow a trusted parameter "white list" through.
    def author_params
      begin
        params.require(:author).permit(:name, :biography)
      rescue
        {}
      end
    end
end
