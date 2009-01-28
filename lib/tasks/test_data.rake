namespace :test_data do
  desc "Setting up a loan for quick testing"
  task :main => [:create_loan]
  
  desc "Create a loan with an advance payment"

  task(:create_loan => :environment) do
    lut = Loan.new(:start=>'1Jun2007', :principal=>350000, :annual_interest=>12, :compounding_periods=>240)
    lut.save
    advance = Advance.new(:dop=>'1Sep2007', :amount=>20000, :loan=>lut)
    advance.save!
  end
end