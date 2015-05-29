class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tests
  # GET /tests.json
  # tests의 index에서는 한번도 검사를 한 적이 없거나
  # 현재 주어진 assigned_exercises가 모두 pass일 때에만
  # 재검사를 허용하도록 한다.
  def index
    @results = Result.where("user_id = ?", current_user.id)
    @ass_exercises = AssignedExercise.where("user_id = ? and passed = ?", current_user.id, false)

    if ( @results.count > 0 && @ass_exercises.count > 0 )
      flash[:alert] = "모든 수행활동을 완료해야 재검사를 할 수 있습니다."
      redirect_to root_path      
    end

    @tests = Test.all
  end

  # POST /tests/submit
  # 제출을 누르면
  # 일단 기본적으로 점수를 매겨서 그 점수를 results에
  # 현재 current_user id를 넣어서 넘기고
  # 그 다음에 점수가 초과된 카테고리에 한해서
  # 해당하는 exercises들을 assigned_exericses에 넣는다.
  def submit

  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name, :category, :content)
    end
end
