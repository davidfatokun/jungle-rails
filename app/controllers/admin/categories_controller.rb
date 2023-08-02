require 'dotenv/load'

class Admin::CategoriesController < ApplicationController

  USERNAME = ENV['USERNAME']
  PASSWORD = ENV['PASSWORD']

  before_action :authenticate

  def index
    @categories = Category.order(name: :asc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
