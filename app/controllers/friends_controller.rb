class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @friends = Friend.all
    respond_with(@friends)
  end

  def show
    respond_with(@friend)
  end

  def new
    @friend = current_user.friends.build
    respond_with(@friend)
  end

  def edit
  end

  def create
    @home = current_user.friends.build(friend_params)
    if @home.save
      redirect_to @home, alert: 'You have added a new friend. They will receive an email notification and if they sign up to DearMe and add you as a friend you\'ll be able to see their home address too!'
    else
      render action: 'new'
    end
  end

  def update
    if @home.update(friend_params)
      redirect_to @home, alert: 'You have successfully updated your friend\'s details.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @friend.destroy
    respond_with(@friend)
  end

  private
    def set_friend
      @friend = Friend.find(params[:id])
    end

    def friend_params
      params.require(:friend).permit(:name, :email)
    end
end
