class AbcsController < ApplicationController
  before_action :set_abc, only: [:show, :edit, :update, :destroy]

  # GET /abcs
  # GET /abcs.json
  def index
    @abcs = Abc.all
  end

  # GET /abcs/1
  # GET /abcs/1.json
  def show
  end

  # GET /abcs/new
  def new
    @abc = Abc.new
  end

  # GET /abcs/1/edit
  def edit
  end

  # POST /abcs
  # POST /abcs.json
  def create
    @abc = Abc.new(abc_params)

    respond_to do |format|
      if @abc.save
        format.html { redirect_to @abc, notice: 'Abc was successfully created.' }
        format.json { render :show, status: :created, location: @abc }
      else
        format.html { render :new }
        format.json { render json: @abc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /abcs/1
  # PATCH/PUT /abcs/1.json
  def update
    respond_to do |format|
      if @abc.update(abc_params)
        format.html { redirect_to @abc, notice: 'Abc was successfully updated.' }
        format.json { render :show, status: :ok, location: @abc }
      else
        format.html { render :edit }
        format.json { render json: @abc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abcs/1
  # DELETE /abcs/1.json
  def destroy
    @abc.destroy
    respond_to do |format|
      format.html { redirect_to abcs_url, notice: 'Abc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_abc
      @abc = Abc.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def abc_params
      params.fetch(:abc, {})
    end
end
