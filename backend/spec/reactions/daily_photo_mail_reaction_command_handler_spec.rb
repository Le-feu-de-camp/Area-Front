require "rails_helper"

RSpec.describe DailyPhotoMailReactionCommandHandler do
  describe "daily_photo_bg" do
    let(:email) { "test@email.com" }
    let(:widget) { create(:widget, user_id: user.id) }
    let(:action) { create(:action, widget_id: widget.id) }
    let(:reaction) { create(:reaction, action_id: action.id) }
    let(:options) { { "reaction_id" => reaction.id, "email"=> email } }
    let(:mocked_response) {
      { "copyright"=>"Stan Honda",
       "date"=>"2022-11-12",
       "explanation"=>
       "A darker Moon sets over Manhattan in this night skyscape. The 16 frame composite was assembled from consecutive exposures recorded during the November 8 total lunar eclipse. In the timelapse sequence stars leave short trails above the urban skyline, while the Moon remains immersed in Earth's shadow. But the International Space Station was just emerging from the shadow into the sunlit portion of its low Earth orbit. As seen from New York City, the visible streak of this ISS flyover starts near a star in Taurus and tracks right to left, through the belt of Orion and over Sirius, alpha star of Canis Major. Gaps along the bright trail of the fast moving orbital outpost (and an aircraft flying closer to the horizon) mark the time between individual exposures in the sequence. The trail of bright planet Mars is at the top of the frame. Pleiades star cluster trails are high over the eclipsed Moon and Empire State Building.   Lunar Eclipse of November 2022: Notable Submissions to APOD  Love Eclipses? (US): Apply to become a NASA Partner Eclipse Ambassador",
       "hdurl"=>"https://apod.nasa.gov/apod/image/2211/StanHondaTLE-ISS1108.jpg",
       "media_type"=>"image",
       "service_version"=>"v1",
       "title"=>"Eclipse in the City",
       "url"=>"https://apod.nasa.gov/apod/image/2211/StanHondaTLE-ISS1108annotated1024.jpg" }
    }

    context "when user have a token" do
      let(:token) { FFaker::Internet.password }
      let(:user) { create(:user, email: email, google_token: token) }
      let(:gmail_service) { GmailClientTest.new(token, email) }
      it "changes the user's background" do
        command = DailyPhotoMailReactionCommand.new(options)
        handler = DailyPhotoMailReactionCommandHandler.new
        expected_coded_mail = "RnJvbTogPHRlc3RAZW1haWwuY29tPgpUbzogPD4KU3ViamVjdDogQVJFQSBEYWlseSBOYXNhIFBpY3R1cmUKQ29udGVudC10eXBlOiB0ZXh0L2h0bWw7Y2hhcnNldD11dGYtOAoKPGltZyBzcmM9J2h0dHBzOi8vYXBvZC5uYXNhLmdvdi9hcG9kL2ltYWdlLzIyMTEvU3RhbkhvbmRhVExFLUlTUzExMDhhbm5vdGF0ZWQxMDI0LmpwZycgYWx0PSdOYXNhIERhaWx5IFBpY3R1cmUnLz4="

        expect {
          handler.call(command.to_h, gmail_service,
                       mocked_response) }.to change(gmail_service, :send_mail_request).by(1)
        expect(gmail_service.last_mail).to eq(expected_coded_mail)
      end
    end
  end
end
