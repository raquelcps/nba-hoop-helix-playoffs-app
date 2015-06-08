class TeamsController < ApplicationController

	def index
		@teams = Team.all



		
	end

	def show
		@team = Team.find_by(:team_id => params[:team_id])

		@teams = Team.all

	   #Team touches
       po_team_touches = Unirest.get("http://stats.nba.com/js/data/sportvu/2014/touchesTeamDataPost.json")
       a = po_team_touches.body
       b = a["resultSets"]
       c = b[0]
       d = c["headers"]
       e = c["rowSet"]

       @po_team_touches_array = []
       e.each do |row|
     	 hash = Hash[*d.zip(row).flatten]
     	 @po_team_touches_array << hash 
       end


		 #Team roster - Used teamplayerdashboard instead of commonteamroster to show only players who have played in playoffs
       po_team_rosters = Unirest.get("http://stats.nba.com/stats/teamplayerdashboard?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&TeamID=#{@team.team_id}&VsConference=&VsDivision=")
       a = po_team_rosters.body
       b = a["resultSets"]
       c = b[1]
       d = c["headers"]
       e = c["rowSet"]

       @po_team_rosters_array = []
       e.each do |row|
       	hash = Hash[*d.zip(row).flatten]
       	@po_team_rosters_array << hash 
       end
       # #Teams in playoffs
       # @po_teams = []
       # @po_team_touches_array.each do |team|
       # 	@po_teams << team["TEAM_ID"]
       # end
	end

end
