# This class displays the user's dashboard which contains:
# * The current_user's recent games
# * The current_user's top games
# * The current_user's Watched Friends' information as the same
class DashboardController < ApplicationController
  before_action :authenticate_user!

  # This method is used to setup and display the data for the user's
  # dashboard
  def show
    @steam_profile = current_user.steam_profile
    @favorite_games = current_user.favorite_games
    @recent_games = current_user.recent_games
  end
end
