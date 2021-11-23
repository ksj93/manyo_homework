require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let!(:user) {FactoryBot.create(:user)}
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '通過テスト', content: '通過テスト',status:'通過テスト',
                        deadline: '2100-12-31',priority:0 ,user:user)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, title: 'aa',status: "着手",user:user) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "bb",status: "完了",user:user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('aa')).to include(task)
        expect(Task.search_title('aa')).not_to include(second_task)
        expect(Task.search_title('aa').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('着手')).to include(task)
        expect(Task.search_status('着手')).not_to include(second_task)
        expect(Task.search_status('着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('aa').search_status('着手')).to include(task)
        expect(Task.search_title('aa').search_status('着手')).not_to include(second_task)
        expect(Task.search_title('aa').search_status('着手').count).to eq 1
      end
    end
  end
end
