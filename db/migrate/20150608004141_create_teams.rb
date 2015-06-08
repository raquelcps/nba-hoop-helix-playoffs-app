class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
    	t.string :team_city
    	t.string :team_name
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
