namespace :steam_stalker do
  # This task is designed to be ran nightly in order to keep profiles'
  # libraries /sort of/ up to date.  This app isn't designed for the
  # up to the minute stats fiend.  If self hosting, you could make this
  # occur as frequently as you like of course.
  desc 'Updates all users\' Steam Libraries'
  task update_libraries: :environment do
    SteamProfile.all.each do |steam_profile|
      steam_profile.update_library
    end
  end
end
