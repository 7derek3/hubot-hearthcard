# Description:
#   Allows users to ask Hubot to post strings containing details of Hearthstone
#   cards based on a card's name.
#
# Dependencies:
#   none
#
# Configuration:
#   HUBOT_MASHAPE_KEY
#
# Commands:
#   hubot hs card <card name> - Returns one or more cards matching <card name>
#
# Notes:
#   Mashape key can be aquired by signing up at
#   https://market.mashape.com/omgvamp/hearthstone
#
# Author:
#   7derek3

module.exports = (robot) ->

  robot.respond /hs card (.*)/i, (res) ->
    cardKeyword = res.match[1]
    robot.http("https://omgvamp-hearthstone-v1.p.mashape.com/cards/search/#{cardKeyword}?collectible=1")
      .header('X-Mashape-Key', process.env.HUBOT_MASHAPE_KEY)
      .get() (err, resp, body) ->
        data = JSON.parse body

        if resp.statusCode is 404 or data.length is 0
          return noMatch()

        else if resp.statusCode is 200
          response = ">>>\n"
          for card in data
            if card.type is "Hero" and data.length is 1
              return noMatch()
            else if card.type isnt "Hero"
              response += "*#{card.name}* #{getRarity(card.rarity)}"
              if card.cost >= 0
                response += ", #{card.cost}💎"
              if card.type is 'Minion'
                response += "#{card.attack}🗡#{card.health}❤️"
              if card.type is 'Weapon'
                response += "#{card.attack}🗡#{card.durability}⚒"
              if card.text
                response += ", #{sanitizeStyling(card.text)}"
              response += "\n"
          res.send response

        else
          res.send ">There was an error in the request."

    noMatch = ->
      res.send ">No matching cards were found."

  getRarity = (rarity) ->
    switch rarity
      when "Free"      then ""
      when "Common"    then "(C)"
      when "Rare"      then "(R)"
      when "Epic"      then "(E)"
      when "Legendary" then "(L)"

  sanitizeStyling = (text) ->
    text.replace(/<.?i>/g, "_").replace(/<.?b>/g, "*").replace(/\n/g, " ")
        .replace(/\$/g, "")
