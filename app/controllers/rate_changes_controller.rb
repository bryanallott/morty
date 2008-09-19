class RateChangesController < ApplicationController
  layout 'default'
  before_filter(:get_loan)
  # GET /rate_changes
  # GET /rate_changes.xml
  def index
    @rate_changes = RateChange.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rate_changes }
    end
  end

  # GET /rate_changes/1
  # GET /rate_changes/1.xml
  def show
    @rate_change = RateChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rate_change }
    end
  end

  # GET /rate_changes/new
  # GET /rate_changes/new.xml
  def new
    @rate_change = RateChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rate_change }
    end
  end

  # GET /rate_changes/1/edit
  def edit
    @rate_change = RateChange.find(params[:id])
  end

  # POST /rate_changes
  # POST /rate_changes.xml
  def create
    @rate_change = RateChange.new(params[:rate_change])

    respond_to do |format|
      if @rate_change.save
        flash[:notice] = 'RateChange was successfully created.'
        format.html { redirect_to(@rate_change) }
        format.xml  { render :xml => @rate_change, :status => :created, :location => @rate_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rate_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rate_changes/1
  # PUT /rate_changes/1.xml
  def update
    @rate_change = RateChange.find(params[:id])

    respond_to do |format|
      if @rate_change.update_attributes(params[:rate_change])
        flash[:notice] = 'RateChange was successfully updated.'
        format.html { redirect_to(@rate_change) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rate_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_changes/1
  # DELETE /rate_changes/1.xml
  def destroy
    @rate_change = RateChange.find(params[:id])
    @rate_change.destroy

    respond_to do |format|
      format.html { redirect_to(rate_changes_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_loan
    @loan = Loan.find(params[:loan_id])
  end
end
