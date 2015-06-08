# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

players = Unirest.get("http://stats.nba.com/stats/commonallplayers?IsOnlyCurrentSeason=0&LeagueID=00&Season=2014-15").body["resultSets"][0]["rowSet"]

players.each do |player_array|
  Player.create(:name => player_array[1], :person_id => player_array[0]) if player_array[2] == 1
end

@teams = Team.create([
	{ :team_city => "Atlanta", :team_name => "Hawks", :team_id => 1610612737 },
	{ :team_city => "Boston", :team_name => "Celtics", :team_id => 1610612738 },
	{ :team_city => "Brooklyn", :team_name => "Nets" , :team_id => 1610612751 }, 
	{ :team_city => "Chicago", :team_name => "Bulls" , :team_id => 1610612741 }, 
	{ :team_city => "Cleveland", :team_name => "Cavaliers" , :team_id => 1610612739 },
	{ :team_city => "Dallas", :team_name => "Mavericks" , :team_id => 1610612742 }, 
	{ :team_city => "Golden State", :team_name => "Warriors" , :team_id => 1610612744 },
	{ :team_city => "Houston", :team_name => "Rockets" , :team_id => 1610612745 },
	{ :team_city => "Los Angeles", :team_name => "Clippers" , :team_id => 1610612746 },
	{ :team_city => "Memphis", :team_name => "Grizzlies" , :team_id => 1610612763 },  
	{ :team_city => "Milwaukee", :team_name => "Bucks" , :team_id => 1610612749 },
	{ :team_city => "New Orleans", :team_name => "Pelicans" , :team_id => 1610612740 }, 
	{ :team_city => "Portland", :team_name => "Trail Blazers" , :team_id => 1610612757 },
	{ :team_city => "San Antonio", :team_name => "Spurs" , :team_id => 1610612759 }, 
	{ :team_city => "Toronto", :team_name => "Raptors" , :team_id => 1610612761 },
	{ :team_city => "Washington", :team_name => "Wizards" , :team_id => 1610612764 }      
	])