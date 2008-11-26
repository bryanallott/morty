class Advance < ActiveRecord::Base
  belongs_to :loan
  has_many :savings
    
  def after_create
    return true if(!self.loan)

    saving = Saving.new(:advance => self)
    interest = self.loan.total_interest
        
    self.loan.save!
    
    hydrated_loan = Loan.find(self.loan.id)

    saving.periods = (self.loan.compounding_periods - hydrated_loan.schedules.length)
    saving.saving = (self.loan.total_interest - hydrated_loan.total_interest)
    saving.save!
  end
end
