class Test01sController < ApplicationController
  before_action :set_test01, only: [:show, :edit, :update, :destroy]

  # GET /test01s
  # GET /test01s.json
  def index
    @test01s = Test01.all
  end

  # GET /test01s/1
  # GET /test01s/1.json
  def show
  end

  # GET /test01s/new
  def new
    @test01 = Test01.new
  end

  # GET /test01s/1/edit
  def edit
  end

  # POST /test01s
  # POST /test01s.json
  def create
    @test01 = Test01.new(test01_params)

    respond_to do |format|
      if @test01.save
        format.html { redirect_to @test01, notice: 'Test01 was successfully created.' }
        format.json { render :show, status: :created, location: @test01 }
      else
        format.html { render :new }
        format.json { render json: @test01.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test01s/1
  # PATCH/PUT /test01s/1.json
  def update
    respond_to do |format|
      if @test01.update(test01_params)
        format.html { redirect_to @test01, notice: 'Test01 was successfully updated.' }
        format.json { render :show, status: :ok, location: @test01 }
      else
        format.html { render :edit }
        format.json { render json: @test01.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test01s/1
  # DELETE /test01s/1.json
  def destroy
    @test01.destroy
    respond_to do |format|
      format.html { redirect_to test01s_url, notice: 'Test01 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test01
      @test01 = Test01.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test01_params
      params.require(:test01).permit(:title, :price)
    end
end
