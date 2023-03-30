require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  # user登録( 1名     )
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task_label) { FactoryBot.create(:task_label, task: task, label: label) }

  describe '新規タスク作成機能' do
    context 'タスクを新規作成した場合' do
      it 'ラベルも登録できる' do
        visit new_session_path
        fill_in "session_email", with: 'a@gmail.com'
        fill_in "session_password", with: 'password1'
        click_on "Log in"
        visit new_task_path
        fill_in 'task_name', with: 'new_task'
        fill_in 'task_content', with: 'new_content'
        fill_in 'task_deadline', with: Date.new(2023, 5, 4)
        select '着手中', from: 'task_status'
        select '中', from: 'task_priority'
        check "ラベル1"
        click_on '登録する'
        expect(page).to have_content 'new_task'
        expect(page).to have_content 'new_content'
        expect(page).to have_content '2023-05-04'
        expect(page).to have_content '着手中'
        expect(page).to have_content '中'
        expect(page).to have_content 'ラベル1'
        # 登録したuserでログインする
        # タスク新規作成がめんに行く
        # タスクを登録する(ラベルも含めて
        # (自動的にshowに飛んでます
        # 自動的に飛んだshowがめんに,ラベル名があればテストOK
        # systemspec チェックボックスで検索するといいよ


        # visit new_session_path
        # fill_in 'session_email', with: 'a@gmail.com'
        # fill_in 'session_password', with: 'password1'
        # click_on 'Log in'
        # visit new_task_path
        # fill_in 'task_name', with:'タスク名'
        # fill_in 'task_content', with:'タスク詳細'
        # fill_in 'task_deadline', with: Date.new(2023, 3, 10)
        # select '着手中', from: 'task_status'
        # click_on '登録する'
        # expect(page).to have_content 'タスク名'
        # expect(page).to have_content 'タスク詳細'
        # expect(page).to have_content '2023-03-10'
        # expect(page).to have_content '着手中'
      end
    end
  end
  describe 'ラベル検索機能' do
    context 'ラベルのみで検索した場合' do
      it 'ラベルを含むタスクで絞り込まれる' do
        visit new_session_path
        fill_in "session_email", with: 'a@gmail.com'
        fill_in "session_password", with: 'password1'
        click_on "Log in"
        visit tasks_path
        fill_in 'task_label_title', with: 'ラベル1'
        click_button '検索'
        expect(page).to have_content 'ラベル1'
    # let!(:task1) { FactoryBot.create(:task) }
    # let!(:task2) { FactoryBot.create(:second_task) }
    # before do
    #   visit tasks_path
    # end
    # context 'ラベル名で検索した場合' do
    #   it '該当のラベルが紐づいているタスクが表示される' do
    #     # テストで使用するためのタスクを作成
    #     # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
    #     # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
    #     expect(page).to have_content task1.name
    #     # expect(page).to have_content 'タイトル１'
    #     expect(page).to have_content task1.content
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
end