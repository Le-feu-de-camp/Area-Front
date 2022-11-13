require "rails_helper"

RSpec.describe DiscoverMovieReactionCommandHandler do
    describe "#DiscoverMovieReaction" do
        let(:email) {"test@email.com"}
        let(:widget) { create(:widget, user_id:user.id)}
        let(:action) { create(:action, widget_id:widget.id)}
        let(:reaction) { create(:reaction, action_id:action.id)}
        let(:mocked_response) { {"page"=>1,
            "results"=>
             [{"adult"=>false,
               "backdrop_path"=>"/ttsFffDoso5BIqNugMoQDBI9A34.jpg",
               "genre_ids"=>[10402, 99],
               "id"=>939984,
               "original_language"=>"ko",
               "original_title"=>"BTS Permission to Dance On Stage - Seoul: Live Viewing",
               "overview"=>
                "Rejoignez-nous pour une expérience incontournable où BTS et les ARMY ne formeront plus qu’un avec la musique et la danse lors du concert diffusé en direct de Séoul dans les cinémas du monde entier !",
               "popularity"=>7.956,
               "poster_path"=>"/fJW3YaGPg5TatAG5Gugz4QWO6d3.jpg",
               "release_date"=>"2022-03-12",
               "title"=>"BTS Permission to dance on stage - Seoul : Live viewing",
               "video"=>true,
               "vote_average"=>9.2,
               "vote_count"=>100 }] }}
        let(:options) { { "reaction_id"=>reaction.id, "language"=>"en.US", "region"=>"FR", "adult"=>"false", "min_date"=>"2001", "min_score"=>"5" }}
        context "when the user has token" do
            let(:gmail) { GmailClientTest.new(token, user.email)}
            let(:user) { create(:user, google_token:token, email:email)}
            let(:token) { FFaker::Internet.password}
            let(:expected_mail) {"RnJvbTogPHRlc3RAZW1haWwuY29tPgpUbzogPHRlc3RAZW1haWwuY29tPgpTdWJqZWN0OiBBUkVBIE1vdmllIFJlY29tbWFuZGF0aW9uICgxMy8xMS8yMDIyKQpDb250ZW50LXR5cGU6IHRleHQvaHRtbDtjaGFyc2V0PXV0Zi04Cgo8IWRvY3R5cGUgaHRtbD4KPGh0bWw-CiAgPGhlYWQ-CiAgICA8bWV0YSBuYW1lPSd2aWV3cG9ydCcgY29udGVudD0nd2lkdGg9ZGV2aWNlLXdpZHRoLCBpbml0aWFsLXNjYWxlPTEuMCcvPgogICAgPG1ldGEgaHR0cC1lcXVpdj0nQ29udGVudC1UeXBlJyBjb250ZW50PSd0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgnIC8-CiAgICA8dGl0bGU-U2ltcGxlIFRyYW5zYWN0aW9uYWwgRW1haWw8L3RpdGxlPgogIDwvaGVhZD4KICA8Ym9keT4KICAgIDxkaXYgc3R5bGU9J3RleHQtYWxpZ246IGNlbnRlcjsnPgogICAgICA8aDE-PHU-QlRTIFBlcm1pc3Npb24gdG8gZGFuY2Ugb24gc3RhZ2UgLSBTZW91bCA6IExpdmUgdmlld2luZzwvdT48L2gxPgogICAgICA8aT4yMDIyLTAzLTEyPC9pPgogICAgICA8cD5SZWpvaWduZXotbm91cyBwb3VyIHVuZSBleHDDqXJpZW5jZSBpbmNvbnRvdXJuYWJsZSBvw7kgQlRTIGV0IGxlcyBBUk1ZIG5lIGZvcm1lcm9udCBwbHVzIHF14oCZdW4gYXZlYyBsYSBtdXNpcXVlIGV0IGxhIGRhbnNlIGxvcnMgZHUgY29uY2VydCBkaWZmdXPDqSBlbiBkaXJlY3QgZGUgU8Opb3VsIGRhbnMgbGVzIGNpbsOpbWFzIGR1IG1vbmRlIGVudGllciAhPC9wPgogICAgICA8aW1nIHNyYz0naHR0cHM6Ly9pbWFnZS50bWRiLm9yZy90L3AvdzUwMC9mSlczWWFHUGc1VGF0QUc1R3VnejRRV082ZDMuanBnJyBoZWlnaHQ9JzMwMHB4Jy8-PGJyLz4KICAgICAgPGEgaHJlZj0naHR0cHM6Ly93d3cudGhlbW92aWVkYi5vcmcvbW92aWUvOTM5OTg0JyB0YXJnZXQ9J19ibGFuayc-UGx1cyBkJ2luZm9zPC9hPgogICAgPC9kaXY-CiAgPC9ib2R5Pgo8L2h0bWw-"}
            it "sends mail" do
                command = DiscoverMovieReactionCommand.new(options)
                handler = DiscoverMovieReactionCommandHandler.new
                expect{handler.call(command.to_h, gmail, mocked_response)}.to change(gmail, :send_mail_request).by(1)
                expect(gmail.last_mail).to eq(expected_mail)
            end
        end

        context "when the user hasn't token" do
            let(:gmail) { GmailClientTest.new(nil, user.email)}
            let(:user) { create(:user, google_token:nil, email:email)}
            it "sends mail" do
                command = DiscoverMovieReactionCommand.new(options)
                handler = DiscoverMovieReactionCommandHandler.new
                expect{handler.call(command.to_h, gmail, mocked_response)}.not_to change(gmail, :send_mail_request)
            end
        end
    end
end


