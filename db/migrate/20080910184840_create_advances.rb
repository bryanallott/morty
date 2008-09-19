class CreateAdvances < ActiveRecord::Migration
  def self.up
    create_table :advances do |t|
      t.integer :loan_id
      t.date :when
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :advances
  end
end
