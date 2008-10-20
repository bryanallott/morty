class AdvancesController < ApplicationController
  layout 'default'
  before_filter(:get_loan)

  def index
    @advances = Advance.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advances }
    end
  end

  def show
    @advance = Advance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advance }
    end
  end

  def new
    @advance = Advance.new(:loan=>@loan)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advance }
    end
  end

  def edit
    @advance = Advance.find(params[:id])
  end

  def create
    @advance = Advance.new(params[:advance])
    @advance.loan = @loan
    
    respond_to do |format|
      if @advance.save
        @loan.save!
        flash[:notice] = 'Advance was successfully created.'
        format.html { redirect_to(@advance) }
        format.xml  { render :xml => @advance, :status => :created, :location => @advance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advance.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @advance = Advance.find(params[:id])

    respond_to do |format|
      if @advance.update_attributes(params[:advance])
        @loan.save!
        flash[:notice] = 'Advance was successfully updated.'
        format.html { redirect_to(@advance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advance.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @advance = Advance.find(params[:id])
    @advance.destroy
    @loan.save!
    
    respond_to do |format|
      format.html { redirect_to(advances_url) }
      format.xml  { head :ok }
    end
  end

  private
  def get_loan
    @loan = Loan.find(params[:loan_id])
  end
end
