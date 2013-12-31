class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string  :match_type
      t.date    :date
      t.string  :rival_name
      t.string  :my_team
      t.string  :rival_team
      t.integer :my_score
      t.integer :rival_score
      t.integer :my_shots
      t.integer :rival_shots
      t.integer :my_shots_on_goal
      t.integer :rival_shots_on_goal
      t.integer :my_possession
      t.integer :rival_possession
      t.integer :my_pass_accuracy
      t.integer :rival_pass_accuracy
      t.integer :my_tackles_made
      t.integer :rival_tackles_made
      t.integer :my_fouls
      t.integer :rival_fouls
      t.integer :my_yellow_cards
      t.integer :rival_yellow_cards
      t.integer :my_red_cards
      t.integer :rival_red_cards
      t.integer :my_offsides
      t.integer :rival_offsides
      t.integer :my_pass_attempts
      t.integer :rival_pass_attempts
      t.integer :my_passes_made
      t.integer :rival_passes_made
      t.string  :digest

      t.timestamps
    end
    add_index :matches, :digest
  end
end
