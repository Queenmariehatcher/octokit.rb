require 'helper'

describe Octokit::Client::Statuses do
  before do
    @client = oauth_client
  end

  context "with repository" do
    before do
      @commit_sha = @client.commits(@test_repo).first.sha
    end

    describe ".create_status", :vcr do
      it "creates status" do
        info = {
          :target_url => 'http://wynnnetherland.com'
        }
        @client.create_status(@test_repo, @commit_sha, 'success', info)
        assert_requested :post, github_url("/repos/#{@test_repo}/statuses/#{@commit_sha}")
      end
    end # .create_status
  end # with repository
end # Octokit::Client::Statuses
