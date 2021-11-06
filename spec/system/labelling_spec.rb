require 'rails_helper'
RSpec.describe 'Labeling function', type: :system do
  describe 'Labeling function on the task' do
    context "If it's possible to add a label when creating a task" do
      it 'you can check the label' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task,user:user)
        label = FactoryBot.create(:label)
        FactoryBot.create(:labelling,task:task,label:label)
        visit tasks_path
        expect(page).to have_content("label1",count:2)
      end
    end
    context "If multiple labels can be added when creating a task" do
      it 'you can check multiple labels' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        # task = FactoryBot.create(:task,user:user)
        label = FactoryBot.create(:label)
        label2 = FactoryBot.create(:label2)
        # FactoryBot.create(:labelling,task:task,label:label)
        # visit tasks_path
        # expect(page).to have_content("label1",count:2)
        # expect(page).to have_content("label2",count:2)
        visit new_task_path
        fill_in "task_title",with:"test"
        fill_in "task_content",with:"test"
        check "label1"
        check "label2"
        # all("#checkbox")[1].click
        click_button "登録する"
        visit tasks_path
        expect(page).to have_content "test"
        expect(page).to have_content("label1",count:2)
        expect(page).to have_content("label2",count:2)
      end
    end
  end

  describe 'Search for the label you added' do
    context 'If you search for the label alone' do
      it 'You can only check the results that applyable results' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task,title:"aa",user:user)
        task2 = FactoryBot.create(:second_task,title:"aa",user:user)
        label = FactoryBot.create(:label)
        label2= FactoryBot.create(:label2)
        FactoryBot.create(:labelling,task:task,label:label)
        FactoryBot.create(:labelling,task:task2,label:label2)
        visit tasks_path
        select(value="label1", from: "label_id")
        click_button "search"
        expect(page).to have_content("label1",count:2)

      end
    end
    context 'If you search the label and title together' do
      it 'You can only check the results that applyable results' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task,title:"aa",user:user)
        task2 = FactoryBot.create(:second_task,title:"aa",user:user)
        label = FactoryBot.create(:label)
        label2= FactoryBot.create(:label2)
        FactoryBot.create(:labelling,task:task,label:label)
        FactoryBot.create(:labelling,task:task2,label:label2)
        visit tasks_path
        select(value="label1", from: "label_id")
        fill_in "title",with: "aa"
        click_button "search"
        expect(page).to have_content("aa",count:1)
        expect(page).to have_content("label1",count:2)
      end
    end
    context 'If you search for the label and the progress' do
      it 'You can only check the results that applyable results' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task,title:"aa",user:user)
        task2 = FactoryBot.create(:second_task,title:"aa",user:user)
        label = FactoryBot.create(:label)
        label2= FactoryBot.create(:label2)
        FactoryBot.create(:labelling,task:task,label:label)
        FactoryBot.create(:labelling,task:task2,label:label2)
        visit tasks_path
        select(value="label1", from: "label_id")
        select(value="未着手",from: "status")
        click_button "search"
        expect(page).to have_content "未着手"
        expect(page).to have_content("label1",count:2)
      end
    end
    context 'If you search for labels, titles, and progress' do
      it 'You can only check the results that applyable results' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task,title:"aa",user:user)
        task2 = FactoryBot.create(:second_task,title:"aa",user:user)
        label = FactoryBot.create(:label)
        label2= FactoryBot.create(:label2)
        FactoryBot.create(:labelling,task:task,label:label)
        FactoryBot.create(:labelling,task:task2,label:label2)
        visit tasks_path
        select(value="label1", from: "label_id")
        fill_in "title",with: "aa"
        select(value="未着手",from: "status")
        click_button "search"
        expect(page).to have_content "未着手"
        expect(page).to have_content("label1",count:2)
        expect(page).to have_content("aa",count:1)
      end
    end
  end

  describe 'Labeling function on the task detail page' do
    context 'If you go to the job detail page where you added the label' do
      it 'You can check the additional labels' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task,user:user)
        label = FactoryBot.create(:label)
        FactoryBot.create(:labelling,task:task,label:label)
        visit task_path(task.id)
        expect(page).to have_content("label1",count:1)
      end
    end
  end
end
