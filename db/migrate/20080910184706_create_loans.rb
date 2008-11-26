class CreateLoans < ActiveRecord::Migration
  def self.up
    create_table :loans do |t|
      t.date    :start
      t.float   :principal
      t.float   :annual_interest
      t.integer :compounding_periods
      
      t.timestamps
    end
  end

  def self.down
    drop_table :loans
  end
end
