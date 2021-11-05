require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成済みのタスク一覧が表示される' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        task = FactoryBot.create(:task, title: 'task',user:user)
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task, title: 'task',user:user)
        FactoryBot.create(:second_task, title: 'task',user:user)
        FactoryBot.create(:third_task, title: 'task',user:user)
        visit tasks_path
        expect(page).to have_content('task',count:Task.count)
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task, title: 'task',user:user)
        FactoryBot.create(:second_task, title: 'task2',user:user)
        FactoryBot.create(:third_task, title: 'task3',user:user)
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context 'タスクが作業期限の降順に並んでいる場合' do
      it '期限が遠いタスクが一番上に表示される' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task, title: 'task',deadline:'2100-12-29',user:user)
        FactoryBot.create(:second_task, title: 'task2',deadline:'2100-12-30',user:user)
        FactoryBot.create(:third_task, title: 'task3',deadline:'2100-12-31',user:user)
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context 'タスクが優先度の降順に並んでいる場合' do
      it '優先度が高い(DBで2)タスクが一番上に表示される' do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task, title: 'task',priority:0,user:user)
        FactoryBot.create(:second_task, title: 'task2',priority:1,user:user)
        FactoryBot.create(:third_task, title: 'task3',priority:2,user:user)
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'task3'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         user = FactoryBot.create(:user)
         RSpec.configuration.session[:user_id] = user.id
         task = FactoryBot.create(:third_task, title: 'task3',user:user)
         visit task_path(task.id)
         expect(page).to have_content 'task3'
       end
     end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task_search,user:user)
        FactoryBot.create(:task2_search,user:user)
        FactoryBot.create(:task3_search,user:user)
        visit tasks_path
        fill_in "title",with: "aa"
        click_button "search"
        expect(page).to have_content 'aa'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task_search,user:user)
        FactoryBot.create(:task2_search,user:user)
        FactoryBot.create(:task3_search,user:user)
        FactoryBot.create(:task4_search,user:user)
        FactoryBot.create(:task5_search,user:user)
        visit tasks_path
        select(value="着手",from: "status")
        click_button "search"
        expect(page).to have_content('着手',count:4)
        # expect(page).to have_content '着手'

      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        user = FactoryBot.create(:user)
        RSpec.configuration.session[:user_id] = user.id
        FactoryBot.create(:task_search,user:user)
        FactoryBot.create(:task2_search,user:user)
        FactoryBot.create(:task3_search,user:user)
        FactoryBot.create(:task4_search,user:user)
        FactoryBot.create(:task5_search,user:user)
        visit tasks_path
        fill_in "title",with: "aa"
        select(value="未着手",from: "status")
        click_button "search"
        expect(page).to have_content("aa")
        expect(page).to have_content('未着手',count:2)
      end
    end
  end
end
