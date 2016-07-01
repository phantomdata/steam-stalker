# Helper module for rendering game accessories
module GameHelper
  CDN_ROOT =
    'http://media.steampowered.com/steamcommunity/public/images/apps'.freeze
  def game_icon_url(game)
    "#{CDN_ROOT}/#{game.appid}/#{game.icon_url}.jpg"
  end
end
