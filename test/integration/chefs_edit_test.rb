require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
 
def setup
  @chef = Chef.create!(name: "mashrur", email: "mashrur@example.com", 
password: "password", password_confirmation: "password")


end

test " reject an invalid edit"do
sign_in_as(@chef, "password")
get edit_chef_path(@chef)
assert_template 'chefs/edit'
patch chef_path(@chef), params: {chef:{name:"",email:"umair129@yahoo.com"}}
assert_template 'chefs/edit'
assert_select 'h2.panel-title'
assert_select 'div.panel-body'
end

test "Accept valid edit"do
sign_in_as(@chef, "password")
get edit_chef_path(@chef)
assert_template 'chefs/edit'
patch chef_path(@chef), params: {chef:{name:"umair1",email:"umair129@gmail.com"}}
assert_redirected_to @chef
assert_not flash.empty?
@chef.reload 
assert_match "umair1",@chef.name
assert_match "umair129@gmail.com",@chef.email
end 
end
