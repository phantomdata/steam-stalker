# This class handles interfacing for handling a user's watched profiles;
# sort of like a friends list, but I wanted something narrower than my Steam
# friends.
class WatchedSteamProfilesController < ApplicationController
  before_action :authenticate_user!

  def create
    @watched_steam_profile =
      WatchedSteamProfile.new(watched_steam_profile_params)
    @watched_steam_profile.user = current_user

    if @watched_steam_profile.save
      flash[:success] = 'May the stalking continue.'
      return redirect_to watched_steam_profiles_path
    end

    render :new
  end

  def destroy
    @watched_steam_profile = current_user.watched_steam_profiles
                                         .find(params[:id])

    if @watched_steam_profile.destroy
      flash[:success] = 'No more stalking.  :('
      return redirect_to watched_steam_profiles_path
    end

    flash[:error] = 'We just couldn\'t stop watching.'
    redirect_to watched_steam_profiles_path
  end

  def index
    @watched_steam_profiles = current_user.watched_steam_profiles
  end

  def new
    @watched_steam_profile = WatchedSteamProfile.new
  end

  private

  def watched_steam_profile_params
    params.require(:watched_steam_profile).permit(:vanity_name)
  end
end
