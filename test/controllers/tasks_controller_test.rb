require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: Time.now # I need to make the completion respond to a toggle
  }

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert  
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: Time.now.to_s,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      invalid_id = "NOT A VALID ID"
      get edit_task_path(invalid_id)
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      task_update = {
        task: {
          name: "walk the dog",
        },
      }

      patch task_path(task.id), params: task_update
      task.reload

      expect(task.name).must_equal "walk the dog"
    end

    it "will redirect to the root page if given an invalid id" do
      task_update = {
        task: {
          name: "write tests, yay!!",
        },
      }

      invalid_id = "Not a valid id"

      patch task_path(invalid_id), params: task_update

      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "successfully deletes a task" do
      id = Task.last
      expect {
        delete task_path(id)
      }.must_change "Task.count", -1
      must_respond_with :redirect
    end

    it "returns 404 if not found" do
      invalid_id = "Not a valid id"
      expect {
        delete task_path(invalid_id)
      }.wont_change "Task.count"
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here

  end
end
