require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # visit new_session_path
        # fill_in 'session_email', with: 'a@gmail.com'
        # fill_in 'session_password', with: 'password1'
        # click_on 'Log in'
        visit new_task_path
        fill_in 'task_name', with:'タスク名'
        fill_in 'task_content', with:'タスク詳細'
        fill_in 'task_deadline', with: Date.new(2023, 3, 10)
        select '着手中', from: 'task_status'
        click_on '登録する'
        expect(page).to have_content 'タスク名'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '2023-03-10'
        expect(page).to have_content '着手中'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:task1) { FactoryBot.create(:task) }
    let!(:task2) { FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content task1.name
        # expect(page).to have_content 'タイトル１'
        expect(page).to have_content task1.content
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content task2.name
        expect(task_list[1]).to have_content task1.name
      end
    end
    context '優先順位に並んでいる場合' do
      it '優先順位が高い順番に表示される' do
        click_on "優先順位でソートする",  match: :first
        sleep(0.5)
        task_list = all('.task_row')  
        expect(task_list[0]).to have_content task2.name
        expect(task_list[1]).to have_content task1.name
      end
    end
  end
  describe '詳細表示機能' do
    let!(:task1) { FactoryBot.create(:task) }
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task)
        expect(page).to have_content task1.name
        expect(page).to have_content task1.content
      end
    end
  end
  describe '検索機能' do
    let!(:task1) { FactoryBot.create(:task) }
    let!(:task2) { FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'task_name', with: 'タイトル'
        click_button '検索'
        expect(page).to have_content 'タイトル'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select "着手中", from: 'task_status'
        click_button "検索"
        expect(page).to have_content '着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'task_name', with: 'タイトル１'
        select '着手中', from: 'task_status'
        click_button '検索'
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content '着手中'
      end
    end
  end
end