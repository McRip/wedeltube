When /^I upload a new video$/ do
  visit "/videos/new"
  fill_in 'video_title', :with => 'Testvideo'
  fill_in 'video_description', :with => 'Test Description'
  attach_file(:video, File.join(RAILS_ROOT, 'spec', 'test_files', 'Frau.avi'))
	click_button "Hochladen"
end