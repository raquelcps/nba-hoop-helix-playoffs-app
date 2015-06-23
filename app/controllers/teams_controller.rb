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
       po_team_rosters = Unirest.get("http://stats.nba.com/stats/teamplayerdashboard?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&TeamID=#{@team.team_id}&VsConference=&VsDivision=")
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

       @po_team_roster_playerid = []
       @po_team_rosters_array.each do |hash|
            @po_team_roster_playerid << hash["PLAYER_ID"]

       end

      #    @po_player_dashboard_totals = Unirest.get("http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=<%= hash['PLAYER_ID'] %>&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&VsConference=&VsDivision=")
      #  a = @po_player_dashboard_totals.body
      # b = a["resultSets"]
      # c = b[0] #specific array for totals    
      # d = c["headers"]
      # e = c["rowSet"]

      # @po_PlayerTotalsdata = []
      # "ZIPPING!!"
      # e.each do |row|
      #   hash = Hash[*d.zip(row).flatten]
    
      #   @po_PlayerTotalsdata << hash 
      # end

     
#        p "player dashboard"
# p @po_player_dashboard_totals



	end

end
