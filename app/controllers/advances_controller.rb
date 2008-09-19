class AdvancesController < ApplicationController
  layout 'default'
  before_filter(:get_loan)
  # GET /advances
  # GET /advances.xml
  def index
    @advances = Advance.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advances }
    end
  end

  # GET /advances/1
  # GET /advances/1.xml
  def show
    @advance = Advance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advance }
    end
  end

  # GET /advances/new
  # GET /advances/new.xml
  def new
    @advance = Advance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advance }
    end
  end

  # GET /advances/1/edit
  def edit
    @advance = Advance.find(params[:id])
  end

  # POST /advances
  # POST /advances.xml
  def create
    @advance = Advance.new(params[:advance])

    respond_to do |format|
      if @advance.save
        flash[:notice] = 'Advance was successfully created.'
        format.html { redirect_to(@advance) }
        format.xml  { render :xml => @advance, :status => :created, :location => @advance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /advances/1
  # PUT /advances/1.xml
  def update
    @advance = Advance.find(params[:id])

    respond_to do |format|
      if @advance.update_attributes(params[:advance])
        flash[:notice] = 'Advance was successfully updated.'
        format.html { redirect_to(@advance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /advances/1
  # DELETE /advances/1.xml
  def destroy
    @advance = Advance.find(params[:id])
    @advance.destroy

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
