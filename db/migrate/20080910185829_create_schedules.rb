class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.integer :loan_id
      t.date :period
      t.float :existing_capital
      t.float :interest_earned
      t.float :repayment
      t.float :interest_paid
      t.float :capital_paid

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
