class AddNameAndPlayerIdToPlayers < ActiveRecord::Migration
  def change
  	change_table :players do |t|
      t.string :name
      t.integer :person_id

    end
  end
end
