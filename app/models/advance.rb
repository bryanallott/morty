class Advance < ActiveRecord::Base
  belongs_to :loan
  has_one :saving
  after_save :create_saving
  
private
  def create_saving()
    #create the saving
    return true if(self.loan.nil?)

    #what are the current figures?
    interest = self.loan.total_interest
    schedules = self.loan.schedules.length
    
    #this effects a recalculation of the schedules
    #with this advance incorporated
    self.loan.save!
    self.loan.reload

    saving = Saving.new(:advance => self)
    saving.periods = (schedules - self.loan.schedules.length)
    saving.saving = (interest - self.loan.total_interest)
    saving.save!
  end
end
