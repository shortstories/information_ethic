class CreateAssignedExercises < ActiveRecord::Migration
  def change
    create_table :assigned_exercises do |t|
      t.integer :user_id, null: false
      t.integer :exercise_id, null: false
      t.boolean :passed, null: :no, default: false
    end

    add_foreign_key "assigned_exercises", "users", name: "fgk_ass_user"
    add_foreign_key "assigned_exercises", "exercises", name: "fgk_ass_exercise"
  end
end
