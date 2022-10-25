# frozen_string_literal: true

class SendTweetReactionCommand
    def initialize(options)
      @reaction_id = options["reaction_id"]
      @user_id = Reaction.find(@reaction_id).action.widget.user.id
      @token_refreshed = options["refresh_token"]
      @message = options["content"]
    end

    def to_h
      { reaction_id: @reaction_id, user_id: @user_id, token_refreshed: @token_refreshed, message: @message }
    end
end