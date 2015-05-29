require 'test_helper'

class AssignedExercisesControllerTest < ActionController::TestCase
  setup do
    @assigned_exercise = assigned_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assigned_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assigned_exercise" do
    assert_difference('AssignedExercise.count') do
      post :create, assigned_exercise: {  }
    end

    assert_redirected_to assigned_exercise_path(assigns(:assigned_exercise))
  end

  test "should show assigned_exercise" do
    get :show, id: @assigned_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assigned_exercise
    assert_response :success
  end

  test "should update assigned_exercise" do
    patch :update, id: @assigned_exercise, assigned_exercise: {  }
    assert_redirected_to assigned_exercise_path(assigns(:assigned_exercise))
  end

  test "should destroy assigned_exercise" do
    assert_difference('AssignedExercise.count', -1) do
      delete :destroy, id: @assigned_exercise
    end

    assert_redirected_to assigned_exercises_path
  end
end
