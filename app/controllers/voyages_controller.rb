class VoyagesController < ApplicationController

  before_action do
    @user = User.find(params[:user_id]) if params[:user_id]

  end

  def index
    if @user
      @voyages = @user.voyages
    else
      @voyages = Voyage.all.order("created_at_desc")
    end
  end

  def show
    @voyage = Voyage.find(params[:id])

  end

  def edit
    @voyage = Voyage.find(params[:id])
  end

  def update
    @voyage = Voyage.find(params[:id])
    if @voyage.update(voyage_params)
      redirect_to [@user, @voyage] #review
    else
      redirect_back_or_to [@user, @voyage]
    end
  end

  def new
    @voyage = Voyage.new
  end

  def create
    @voyage = Voyage.new(voyage_params)
    @voyage.captain = current_user

    if @voyage.save
      redirect_to @voyage
    else
      redirect_to new_voyage_path
    end

  end

  def destroy
    @voyage = Voyage.find(params[:id])
    @voyage.destroy
    redirect_to user_voyages_path
  end
  #
  # def ensure_user_match
  #   if @voyage.captain != @user
  #     not_found
  #   end
  # end

private
  def voyage_params
    params.require(:voyage).permit(:title, :captain_id) #will need to add more fields as they are added to model
  end

end