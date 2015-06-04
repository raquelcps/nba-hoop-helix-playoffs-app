class PlayersController < ApplicationController

	def show
       @player = Player.find_by(:person_id => params[:person_id])

      #NBA.com common player data
      po_player_data = Unirest.get("http://stats.nba.com/stats/commonplayerinfo?LeagueID=00&PlayerID=#{@player.person_id}&SeasonType=Playoffs")

      a = po_player_data.body
      b = a["resultSets"]
      c = b[0]
      d = c["headers"]
      e = c["rowSet"]

      @po_playerdata = []
      "ZIPPING!!"
      e.each do |row|
      	hash = Hash[*d.zip(row).flatten]
      	@po_playerdata << hash 
      end

      #NBA.com player dashboard totals
      po_player_dashboard_totals = Unirest.get("http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=#{@player.person_id}&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&VsConference=&VsDivision=")
      
      a = po_player_dashboard_totals.body
      b = a["resultSets"]
      c = b[0] #specific array for totals    
      d = c["headers"]
      e = c["rowSet"]

      @po_PlayerTotalsdata = []
      "ZIPPING!!"
      e.each do |row|
        hash = Hash[*d.zip(row).flatten]
     # keys_to_delete.each do |key|
     #   hash.delete(key)
     # end
        @po_PlayerTotalsdata << hash 
      end

      #NBA.com passes made 
      @po_player_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=#{@player.person_id}&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&TeamID=0&VsConference=&VsDivision=")
      
      a = @po_player_passes.body
      b = a["resultSets"]
      c = b[0] #gets all PassesMade from playerA to teammates
      d = c["headers"]
      e = c["rowSet"]
      g = e.each do |row|
     	row.each do |item| 

     	end
      end
      #How do i do this so that the first row references playerA only, but the following nodes are teammates passed to
      keys_to_delete = ["TEAM_NAME", "TEAM_ID", "PASS_TYPE", "G"]
      @po_data = []
      "ZIPPING!!"
      e.each do |row|
    	hash = Hash[*d.zip(row).flatten]
    	# keys_to_delete.each do |key|
    	# 	hash.delete(key)
    	# end
    	@po_data << hash 
      end


      #Added each do for player total passes
      @po_player_total_passes = []
      @po_data.each do |passes|
      	@po_player_total_passes << passes["PASS"]
      end

      recc = b[1] #gets all PassesReceived by playerA from teammates
      recd = recc["headers"]        
      rece = recc["rowSet"]

      @po_ReceivedData = []
      "ZIPPING!!"
      rece.each do |row|    	
        hash = Hash[*d.zip(row).flatten]
         # keys_to_delete.each do |key|
         #   hash.delete(key)
         # end
        @po_ReceivedData << hash 
      end

      @po_player_total_ast_recd = []
      @po_player_total_pass_recd = []
      @po_ReceivedData.each do |passes|
 	    @po_player_total_ast_recd << passes["AST"]
 	    @po_player_total_pass_recd << passes["PASS"]
      end

      #NBA.com player's team totals data
      po_player_team_data = Unirest.get("http://stats.nba.com/stats/teamdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&TeamID=#{@po_playerdata[0]["TEAM_ID"]}&VsConference=&VsDivision=")
    
      a = po_player_team_data.body
      b = a["resultSets"]
      c = b[0] #overall team dashboard
      d = c["headers"]
      e = c["rowSet"]

      @po_playerteamdata = []
      "ZIPPING!!"
      e.each do |row|
    	hash = Hash[*d.zip(row).flatten]

    	@po_playerteamdata << hash 
      end

   # Team Lineups
   # twoman_lineups = Unirest.get("http://stats.nba.com/stats/teamdashlineups?DateFrom=&DateTo=&GameID=&GameSegment=&GroupQuantity=2&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&TeamID=#{@po_playerdata[0]["TEAM_ID"]}&VsConference=&VsDivision=")
   # a = twoman_lineups.body
   # b = a["resultSets"]
   # c = b[0]
   # d = c["headers"]
   # e = c["rowSet"]

   # @team_lineups_minutes = []
   # e.each do |row|
 	 # hash = Hash[*d.zip(row).flatten]
 	 # @team_lineups_minutes << hash 
   # end

       # Team Passing Totals 
       po_team_passing = Unirest.get("http://stats.nba.com/stats/teamdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Playoffs&TeamID=#{@po_playerdata[0]["TEAM_ID"]}&VsConference=&VsDivision=")
       a = po_team_passing.body
       b = a["resultSets"]
       c = b[0]
       d = c["headers"]
       e = c["rowSet"]
         # p team_passing
       @po_team_passes_per_player = []
       e.each do |row|
     	 hash = Hash[*d.zip(row).flatten]
     	 @po_team_passes_per_player << hash 
       end
       @po_team_passes_total = []
       # @team_assist_total = []
       @po_team_passes_per_player.each do |player|
     	 @po_team_passes_total << player["PASS"]
         # @team_assist_total << player["AST"]
       end


       #Team touches
       po_team_touches = Unirest.get("http://stats.nba.com/js/data/sportvu/2014/touchesTeamDataPost.json")
       a = po_team_touches.body
       b = a["resultSets"]
       p "TEAM RESULT SETS"
       c = b[0]
       d = c["headers"]
       e = c["rowSet"]

       po_team_touches_array = []
       e.each do |row|
     	 hash = Hash[*d.zip(row).flatten]
     	 po_team_touches_array << hash 
       end

       @po_team_touches_total = po_team_touches_array.select {|team| team["TEAM_ID"].to_i == @po_playerdata[0]["TEAM_ID"] }

       #Player Touches
       po_player_touches = Unirest.get("http://stats.nba.com/js/data/sportvu/2014/touchesDataPost.json").body["resultSets"][0]["rowSet"]

       @po_player_touches_total = po_player_touches.select{ |player| player[0].to_i == @po_playerdata[0]["PERSON_ID"] }
     	  
	end #Show
end
