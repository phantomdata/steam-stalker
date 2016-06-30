# An abstraction service for working with the ::SteamApi module within this
# application.
class SteamService
  # Leverages the SteamApi and fetches the steam_id for the given
  # vanity_name.
  def self.steam_id_for(vanity_name)
    ::SteamApi.steam_id_for(vanity_name)
  end
end
