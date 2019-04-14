class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  has_scope :valid, default: nil, allow_blank: true
  has_scope :by_name, as: :name

  # GET /categories
  def index
    @categories = apply_scopes(Category)
    order_type = params[:order_type]
    if order_type.present?
      if order_type == "ascending"
        @categories = @categories.order(:name)
      elsif order_type == "descending"
        @categories = @categories.order(name: :desc)
      elsif order_type == "newest"
        @categories = @categories.order(updated_at: :desc)
      else order_type == "oldest"
        @categories = @categories.order(:updated_at)
      end
    else
      @categories = @categories.order(:name)
    end
    count = @categories.count
    json_rendered = {}
    
    if params[:page].present?
      per_page = 10	      
      if params[:per_page].present?	
        per_page = params[:per_page].to_i	
      end
      @categories = @categories.page(params[:page]).per(per_page)
      total_page = @categories.total_pages
      json_rendered["meta"] = {count: count, page_count: total_page, per_page: per_page}
    else
      json_rendered["meta"] = {count: count}
    end
    @data = json_data(@categories)
    json_rendered["data"] = @data
    render json: json_rendered
  end

  # GET /categories/1
  def show
    unless @category.nil?
      render json: {data: json_data(@category)}
    else
      render json: {errors: "Couldn't find Category with 'id'=#{params[:id]}"}, status: :unprocessable_entity
    end
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      render json: {data: json_data(@category)}, status: :created
    else
      render json: {errors: json_data(@category.errors)}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: {data: json_data(@category)}
    else
      render json: {errors: json_data(@category.errors)}, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    if @category.delete
      render json: {data: json_data(@category)}, status: :ok
    else
      render json: {errors: delete(@category.errors)}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = apply_scopes(Category).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      begin
        params.require(:category).permit(:name, :description)
      rescue
        {}
      end
    end
end
