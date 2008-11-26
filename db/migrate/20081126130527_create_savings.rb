class CreateSavings < ActiveRecord::Migration
  def self.up
    create_table :savings do |t|
      t.integer :advance_id
      t.integer :periods
      t.float :saving

      t.timestamps
    end
  end

  def self.down
    drop_table :savings
  end
end
