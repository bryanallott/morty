class SavingsController < ApplicationController
  layout 'default'
  before_filter(:get_advance)

  # GET /savings
  # GET /savings.xml
  def index
    @savings = @advance.savings

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @savings }
    end
  end

  # GET /savings/1
  # GET /savings/1.xml
  def show
    @savings = Savings.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @savings }
    end
  end

  # GET /savings/new
  # GET /savings/new.xml
  def new
    @savings = Savings.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @savings }
    end
  end

  # GET /savings/1/edit
  def edit
    @savings = Savings.find(params[:id])
  end

  # POST /savings
  # POST /savings.xml
  def create
    @savings = Savings.new(params[:savings])

    respond_to do |format|
      if @savings.save
        flash[:notice] = 'Savings was successfully created.'
        format.html { redirect_to(@savings) }
        format.xml  { render :xml => @savings, :status => :created, :location => @savings }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @savings.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /savings/1
  # PUT /savings/1.xml
  def update
    @savings = Savings.find(params[:id])

    respond_to do |format|
      if @savings.update_attributes(params[:savings])
        flash[:notice] = 'Savings was successfully updated.'
        format.html { redirect_to(@savings) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @savings.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /savings/1
  # DELETE /savings/1.xml
  def destroy
    @savings = Savings.find(params[:id])
    @savings.destroy

    respond_to do |format|
      format.html { redirect_to(savings_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_advance
    @advance = Advance.find(params[:advance_id])
    @loan = @advance.loan
  end
end
