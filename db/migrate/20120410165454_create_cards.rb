# -*- encoding : utf-8 -*-
class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.string :prompt1
      t.string :prompt2
      t.string :prompt3
      t.string :prompt4
      t.string :prompt5
      t.integer :times_used

      t.timestamps
    end
  end
end
