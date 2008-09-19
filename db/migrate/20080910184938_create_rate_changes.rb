class CreateRateChanges < ActiveRecord::Migration
  def self.up
    create_table :rate_changes do |t|
      t.integer :loan_id
      t.date :changed
      t.float :annual_interest

      t.timestamps
    end
  end

  def self.down
    drop_table :rate_changes
  end
end
