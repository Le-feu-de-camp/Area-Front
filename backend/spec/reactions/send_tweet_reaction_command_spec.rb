require "rails_helper"

RSpec.describe SendTweetReactionCommand do
  describe "#to_h" do
    context "All informations" do
      let(:options) { { "action_id"=> 1, "content"=> "Je suis pas", "refresh_token"=> "ZAKO12121OKDZSKO2OS" } }
      it "returns a hash with the correct keys" do
        command = SendTweetReactionCommand.new(options)
        expect(command.to_h).to eq({ action_id: 1, message: "Je suis pas", token_refreshed: "ZAKO12121OKDZSKO2OS" })
      end
    end
  end
end