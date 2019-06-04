describe Api::V1::TasksController, type: :controller do
  describe '#show' do
    let(:task) { create :task }

    it 'should return task' do
      get :show, params: {id: task.id}

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['success']).to eq true
      task_response = JSON.parse(response.body)['task']
      expect(task_response['id']).to eq task.id
      expect(task_response['description']).to eq task.description
      expect(task_response['completed']).to eq task.completed
      expect(task_response['completed_at']).to eq task.completed_at.strftime('%d/%m/%Y %I:%M%p')
    end

    it 'should return error if task is not found' do
      get :show, params: {id: 'error'}

      expect(response.status).to eq 400
      expect(JSON.parse(response.body)['success']).to eq false
    end
  end

  describe '#create' do
    context 'when attributes are valid' do
      it 'should create a task with description' do
        post :create, params: {task: {description: 'Task Description'}}

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['success']).to eq true
        expect(Task.count).to eq 1
        expect(Task.last.description).to eq 'Task Description'
        expect(Task.last.completed).to eq false
        expect(Task.last.completed_at).to eq nil
      end

      it 'should create a task with all attributes' do
        completed_time = Time.now - 1.days
        post :create, params: {task: {description: 'Task Description2', completed: true, completed_at: completed_time}}

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['success']).to eq true
        expect(Task.count).to eq 1
        expect(Task.last.description).to eq 'Task Description2'
        expect(Task.last.completed).to eq true
        expect(Task.last.completed_at.strftime('%d/%m/%Y %I:%M%p')).to eq completed_time.strftime('%d/%m/%Y %I:%M%p')
      end
    end

    context 'when attributes are invalid' do
      it 'should return error' do
        post :create, params: {task: {description: ''}}

        expect(response.status).to eq 400
        expect(JSON.parse(response.body)['success']).to eq false
        expect(Task.count).to eq 0
      end
    end
  end

  describe '#update' do
    let(:task) { create :task, description: 'Task Description' }

    it 'updates the task' do
      put :update, params: {id: task.id, task: {description: 'Updated Task Description'}}

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['success']).to eq true
      task.reload
      expect(task.description).to eq 'Updated Task Description'
    end

    it 'returns error if task is not found' do
      put :update, params: {id: 'error', task: {description: 'Updated Task Description'}}

      expect(response.status).to eq 400
      expect(JSON.parse(response.body)['success']).to eq false
    end

    it 'returns error if attributes are invalid' do
      put :update, params: {id: task.id, task: {description: ''}}
      expect(response.status).to eq 400
      expect(JSON.parse(response.body)['success']).to eq false
      task.reload
      expect(task.description).to eq 'Task Description'
    end
  end
end
