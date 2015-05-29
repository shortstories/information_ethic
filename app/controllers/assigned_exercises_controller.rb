class AssignedExercisesController < ApplicationController
  before_action :set_assigned_exercise, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /assigned_exercises
  # GET /assigned_exercises.json
  def index
    @assigned_exercises = AssignedExercise.all
  end

  # GET /assigned_exercises/1
  # GET /assigned_exercises/1.json
  def show
  end

  # GET /assigned_exercises/new
  def new
    @assigned_exercise = AssignedExercise.new
  end

  # GET /assigned_exercises/1/edit
  def edit
  end

  # POST /assigned_exercises
  # POST /assigned_exercises.json
  def create
    @assigned_exercise = AssignedExercise.new(assigned_exercise_params)

    respond_to do |format|
      if @assigned_exercise.save
        format.html { redirect_to @assigned_exercise, notice: 'Assigned exercise was successfully created.' }
        format.json { render :show, status: :created, location: @assigned_exercise }
      else
        format.html { render :new }
        format.json { render json: @assigned_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assigned_exercises/1
  # PATCH/PUT /assigned_exercises/1.json
  def update
    respond_to do |format|
      if @assigned_exercise.update(assigned_exercise_params)
        format.html { redirect_to @assigned_exercise, notice: 'Assigned exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @assigned_exercise }
      else
        format.html { render :edit }
        format.json { render json: @assigned_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assigned_exercises/1
  # DELETE /assigned_exercises/1.json
  def destroy
    @assigned_exercise.destroy
    respond_to do |format|
      format.html { redirect_to assigned_exercises_url, notice: 'Assigned exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assigned_exercise
      @assigned_exercise = AssignedExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assigned_exercise_params
      params[:assigned_exercise]
    end
end
