require 'pry'

def game_hash
  game_hash = {
      :home => {
        :team_name => "Brooklyn Nets",
        :colors => ["Black", "White"],
        :players => [
          {
            player_name: "Alan Anderson",
            number: 0,
            shoe: 16,
            points: 22,
            rebounds: 12,
            assists: 12,
            steals: 3,
            blocks: 1,
            slam_dunks: 1
          },
          {
            player_name: "Reggie Evans",
            number: 30,
            shoe: 14,
            points: 12,
            rebounds: 12,
            assists: 12,
            steals: 12,
            blocks: 12,
            slam_dunks: 7
          },
          {
            player_name: "Brook Lopez",
            number: 11,
            shoe: 17,
            points: 17,
            rebounds: 19,
            assists: 10,
            steals: 3,
            blocks: 1,
            slam_dunks: 15
          },
          {
            player_name: "Mason Plumlee",
            number: 1,
            shoe: 19,
            points: 26,
            rebounds: 12,
            assists: 6,
            steals: 3,
            blocks: 8,
            slam_dunks: 5
          },
          {
            player_name: "Jason Terry",
            number: 31,
            shoe: 15,
            points: 19,
            rebounds: 2,
            assists: 2,
            steals: 4,
            blocks: 11,
            slam_dunks: 1
          }]
        },
      :away => {
        :team_name => "Charlotte Hornets",
        :colors => ["Turquoise", "Purple"],
        :players => [
          {
            player_name: "Jeff Adrien",
            number: 4,
            shoe: 18,
            points: 10,
            rebounds: 1,
            assists: 1,
            steals: 2,
            blocks: 7,
            slam_dunks: 2
          },
          {
            player_name: "Bismak Biyombo",
            number: 0,
            shoe: 16,
            points: 12,
            rebounds: 4,
            assists: 7,
            steals: 7,
            blocks: 15,
            slam_dunks: 10
          },
          {
            player_name: "DeSagna Diop",
            number: 2,
            shoe: 14,
            points: 24,
            rebounds: 12,
            assists: 12,
            steals: 4,
            blocks: 5,
            slam_dunks: 5
          },
          {
            player_name: "Ben Gordon",
            number: 8,
            shoe: 15,
            points: 33,
            rebounds: 3,
            assists: 2,
            steals: 1,
            blocks: 1,
            slam_dunks: 0
          },
          {
            player_name: "Brendan Haywood",
            number: 33,
            shoe: 15,
            points: 6,
            rebounds: 12,
            assists: 12,
            steals: 22,
            blocks: 5,
            slam_dunks: 12
         }]
      }
  }
end

# helper methods

def players #method that pulls all players hashes {name & data}
  home = game_hash[:home][:players]
  away = game_hash[:away][:players]
  home + away
end

def find_player(name) #method that looks for the first match
  players.find { |player| player[:player_name] == name }
    #find looks for first block that satisfies the following:
        #define player as the key and return all values that match the key
end

# hashketball

def num_points_scored(name)
  player = find_player(name) #define player as the hash that meets the name criteria
  player[:points]
end

def shoe_size(name)
  player = find_player(name)  # returns the shoe size for that player
  player[:shoe]
end

# helper methods

def teams #define a method to identify all teams
  game_hash.values #values returns new array populated with values.  This should be everything after :home and :Away
end

def find_team(team_name)
  teams.find { |team| team[:team_name] == team_name } #look in team method and returns first value that satisfies the following
end

# hashketball

def team_colors(team)
  team_name = find_team(team)
  team_name[:colors]
end

def team_names
  teams.collect { |team| team[:team_name] } #variable defined as team.  Returns value for anything that matches
end

def player_numbers(team_name)
  find_team(team_name)[:players].collect { |player| player[:number] }
  #finds the team and then returns array of players data.  iterate across and put into a separate array.
      #return all instances of the key value for player[:number]
end

def player_stats(player)
  find_player(player).reject { |name_key| name_key == :player_name } #reject returns all values that are false against the blocks
end

# helper method

def player_biggest_shoe_size
  players.sort_by { |player| player[:shoe] }.last
     #sort_by takes all arrays from smallest to biggest.
      #block defines pulling all shoe sizes and ordering them.
        #.last takes the last value from the array.
end

# hashketball

def big_shoe_rebounds
  player = player_biggest_shoe_size
  player[:rebounds]
end

# OVER TIME!!!

def most_points_scored
  most_points = nil
  player = nil
  game_hash.each do |team, team_data|
    team_data[:players].each do |player_name, player_data|
      if most_points == nil || player_data[:points] > most_points
        most_points= player_data[:points]
        player = :player_name
      end
    end
  end
  player
end

def winning_team
  # Which team has the most points
  home_score = 0
  away_score = 0
  game_hash[:home][:players].each do |player, data|
    home_score += data[:points]
  end
  game_hash[:away][:players].each do |player, data|
    away_score += data[:points]
  end
  home_score > away_score ? game_hash[:home][:team_name] : game_hash[:away][:team_name]
end

def player_with_longest_name
  players = []
  longest_name = " "

  players << game_hash[:home][:players].keys
  players << game_hash[:away][:players].keys

  players.flatten.each do |player|
    if player.length > longest_name.length
      longest_name = player
    end
  end
  longest_name
end

def long_name_steals_a_ton?
  player = ""
  high_steals = 0
  game_hash.each do |home_or_away, team_attributes|
    team_attributes[:players].each do |name, stats|
      if stats[:steals] > high_steals
        player = name
        high_points = stats[:points]
      end
    end
  end
  player.to_s == player_with_longest_name
end
