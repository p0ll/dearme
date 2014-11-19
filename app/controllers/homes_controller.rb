class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_action :count_within_limit, only: [:new, :create]
  respond_to :html

  def count_within_limit
    if current_user.homes && current_user.homes >= 1
      flash[:error] = "You already have a home address saved. You can update your home address if it is changed."
      redirect_to edit_homes_path
    end
  end

  def index
    @homes = Home.all
    respond_with(@homes)
  end

  def show
    respond_with(@home)
  end

  def new
    @home = Home.new
    respond_with(@home)
  end

  def edit
  end

  def create
    @home = Home.new(home_params)
    @home.save
    respond_with(@home)
  end

  def update
    @home.update(home_params)
    respond_with(@home)
  end

  def destroy
    @home.destroy
    respond_with(@home)
  end

  private
    def set_home
      @home = Home.find(params[:id])
    end

    def home_params
      params[:home]
    end
end
