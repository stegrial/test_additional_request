require 'spec_helper'
require 'net/http'

def delete_saved_elements
  base_url = "http://localhost:9515"
  url = URI("#{base_url}/clear_elements")

  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Delete.new(url)
  response = http.request(request)

  if response.code == 200.to_s
    puts "All elements were deleted"
  else
    puts "Elements can not be deleted"
    puts response.body
  end
end

describe 'Preconditions' do

  before(:all) do
    Capybara.page.driver.browser.manage.window.resize_to(1440, 800)
  end

  after(:all) do
    delete_saved_elements
  end

  feature 'Cloud Bees - Change History modal' do
    scenario 'Recording IL' do
      visit 'https://ectest.trueautomation.io/flow'

      puts '-Admin does login'
      find(:css, ta('cloud_bees:login_page:username', '.at-login-username')).set('admin')
      find(:css, ta('cloud_bees:login_page:password', '.at-login-password')).set('changeme')
      find(:css, ta('cloud_bees:login_page:sign_in_btn', '.at-login-button')).click

      puts '-Admin clicks on the Hamburger menu button'
      find(:css, ta('cloud_bees:ham_menu', '.at-main-menu-btn')).click

      puts '-Admin chooses the Change History section in the Hamburger menu'
      find(:css, ta('cloud_bees:change_history', '.at-main-menu-change_history')).click

      puts '-Admin chooses the second item in table Change History'
      find(:xpath, ta('cloud_bees:change_history:second_item', "//div[text()='2.']")).click

      puts '-Admin clicks on dropdown Last Changes'
      find(:xpath, ta('cloud_bees:change_history:dropdown_last_changes', "//div[text()='Last changes']")).click

      sleep 3
    end
  end
end
