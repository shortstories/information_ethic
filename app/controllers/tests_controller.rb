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
    user_id = current_user.id
    times = Result.where("user_id = ?", user_id).count + 1
    tests_count = Test.all.count

    @answer1 = params[:answer]["1"]
    @answer2 = params[:answer]["2"]
    @answer3 = params[:answer]["3"]
    @answer4 = params[:answer]["4"]
    @answer5 = params[:answer]["5"]

    if ( !@answer1 || !@answer2 || !@answer3 || !@answer4 || !@answer5 )
      flash[:error] = "모든 문항에 체크해주세요."
      redirect_to :back
    else
      answer_count = @answer1.count + @answer2.count + @answer3.count + @answer4.count + @answer5.count
      if (tests_count != answer_count) 
        flash[:error] = "모든 문항에 체크해주세요."
        redirect_to :back
      else
        # 여기에서 모든 대답을 계산하고 결과에 넣는다.
        answer1_score = 0
        answer2_score = 0
        answer3_score = 0
        answer4_score = 0
        answer5_score = 0

        @answer1.each do |ans|
          answer1_score = answer1_score + ans[1].to_i
        end
        answer1_score = 0 if answer1_score < 0
        # 만점이 30점
        answer1_score = (answer1_score.to_f / 30) * 100


        @answer2.each do |ans|
          answer2_score = answer2_score + ans[1].to_i
        end
        answer2_score = 0 if answer2_score < 0
        # 만점 25점
        answer2_score = (answer2_score.to_f / 25) * 100

        @answer3.each do |ans|
          answer3_score = answer3_score + ans[1].to_i
        end
        # 만점 75점
        answer3_score = 0 if answer3_score < 0
        answer3_score = (answer3_score.to_f / 75) * 100

        @answer4.each do |ans|
          answer4_score = answer4_score + ans[1].to_i
        end 
        # 만점 50점
        answer4_score = 0 if answer4_score < 0
        answer4_score = (answer4_score.to_f / 50) * 100

        @answer5.each do |ans|
          answer5_score = answer5_score + ans[1].to_i
        end
        # 만점 10점
        answer5_score = 0 if answer5_score < 0
        answer5_score = (answer5_score.to_f / 10) * 100

        new_result = Result.new do |r|
          r.user_id = user_id
          r.times = times
          r.score_1 = answer1_score
          r.score_2 = answer2_score
          r.score_3 = answer3_score
          r.score_4 = answer4_score
          r.score_5 = answer5_score 
        end

        new_result.save


        if (times > 1)
          @assigned_exercises = AssignedExercise.where("user_id = ?", current_user.id);
          @assigned_exercises.destroy
        end
        # 여기서 부터는 이제 문제를 할당한다.
        # 각 카테고리에 대해서 커트라인 설정
        cutline1 = 50
        cutline2 = 50
        cutline3 = 50
        cutline4 = 50


        # 사이버 언어폭력
        if ( answer1_score >= cutline1 ) 
          Exercise.where("category = ?", 1).each do |exercise|
            ass_exer = AssignedExercise.new
            ass_exer.user_id = current_user.id
            ass_exer.passed = 0            
            ass_exer.exercise_id = exercise.id
            ass_exer.save
          end
        end

        # 사이버 언어폭력
        if ( answer2_score >= cutline2 ) 
          Exercise.where("category = ?", 2).each do |exercise|
            ass_exer = AssignedExercise.new
            ass_exer.user_id = current_user.id
            ass_exer.passed = 0            
            ass_exer.exercise_id = exercise.id
            ass_exer.save
          end
        end

        # 사이버 언어폭력
        if ( answer3_score >= cutline3 ) 
          Exercise.where("category = ?", 3).each do |exercise|
            ass_exer = AssignedExercise.new
            ass_exer.user_id = current_user.id
            ass_exer.passed = 0            
            ass_exer.exercise_id = exercise.id
            ass_exer.save
          end
        end

        # 사이버 언어폭력
        if ( answer4_score >= cutline4 ) 
          Exercise.where("category = ?", 4).each do |exercise|
            ass_exer = AssignedExercise.new
            ass_exer.user_id = current_user.id
            ass_exer.passed = 0            
            ass_exer.exercise_id = exercise.id
            ass_exer.save
          end
        end

        # 공통 영역 5회기
        ass_exer = AssignedExercise.new
        ass_exer.user_id = current_user.id
        ass_exer.passed = 0            
        ass_exer.exercise_id = 19
        ass_exer.save
      end
    end
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
