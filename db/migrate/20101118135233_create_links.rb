class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :sentence_id
      t.integer :translation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
