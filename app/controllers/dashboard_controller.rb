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
    @favorite_library_entries = current_user.library_entries.favorites
    @recent_library_entries = current_user.library_entries.recent
  end
end
