# frozen_string_literal: true
require "rails_helper"

describe "RepositoriesController" do
  let!(:repository) { create(:repository) }
  let!(:tag) { create(:tag, repository: repository) }
  let!(:contribution) { create(:contribution, repository: repository) }

  describe "GET /github", type: :request do
    it "renders successfully when logged out" do
      visit hosts_path(host_type: 'github')
      expect(page).to have_content 'Repositories'
    end
  end

  describe "GET /github/search", type: :request, elasticsearch: true do
    it "renders successfully when logged out" do
      Repository.__elasticsearch__.refresh_index!
      visit github_search_path
      expect(page).to have_content repository.full_name
    end
  end

  describe "GET /github/search.atom", type: :request, elasticsearch: true do
    it "renders successfully when logged out" do
      Repository.__elasticsearch__.refresh_index!
      visit github_search_path(format: :atom)
      expect(page).to have_content repository.full_name
    end
  end

  describe "GET /github/languages", type: :request do
    it "renders successfully when logged out" do
      visit github_languages_path
      expect(page).to have_content 'Languages'
    end
  end

  describe "GET /github/trending", type: :request do
    it "renders successfully when logged out" do
      visit trending_path
      expect(page).to have_content 'Trending'
    end
  end

  describe "GET /github/new", type: :request do
    it "renders successfully when logged out" do
      visit new_repos_path
      expect(page).to have_content 'New'
    end
  end

  describe "GET /github/:owner/:name", type: :request do
    it "renders successfully when logged out" do
      visit "/github/#{repository.full_name}"
      expect(page).to have_content repository.full_name
    end
  end

  describe "GET /github/:owner/:name/tags", type: :request do
    it "renders successfully when logged out" do
      visit "/github/#{repository.full_name}/tags"
      expect(page).to have_content "#{repository.full_name} tags"
    end
  end

  describe "GET /github/:owner/:name/contributors", type: :request do
    it "renders successfully when logged out" do
      visit "/github/#{repository.full_name}/contributors"
      expect(page).to have_content "Committers to #{repository.full_name}"
    end
  end

  describe "GET /github/:owner/:name/forks", type: :request do
    it "renders successfully when logged out" do
      visit "/github/#{repository.full_name}/forks"
      expect(page).to have_content "Repositories forked from #{repository.full_name}"
    end
  end
end
