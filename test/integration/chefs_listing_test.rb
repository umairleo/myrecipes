require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
 def setup
    @chef = Chef.create!(name: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(name: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
  assert_select "a[href=?]", chef_path(@chef), text: @chef.name.capitalize
  assert_select "a[href=?]", chef_path(@chef2), text: @chef2.name.capitalize
  end
end
