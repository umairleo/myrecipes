require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
 
def setup
  @chef = Chef.create!(name: "umair", email: "umair129@gmail.com", 
password: "password", password_confirmation: "password")
@chef2 = Chef.create!(name: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
@admin_user = Chef.create!(name: "john1", email: "john1@example.com",
                    password: "password", password_confirmation: "password", admin: true)


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
test "accept edit attempt by admin user" do
sign_in_as(@admin_user, "password")
get edit_chef_path(@chef)
assert_template 'chefs/edit'
patch chef_path(@chef), params: {chef:{name:"umair1",email:"umair129@gmail.com"}}
assert_redirected_to @chef
assert_not flash.empty?
@chef.reload 
assert_match "umair1",@chef.name
assert_match "umair129@gmail.com",@chef.email
end
test "redirect edit attempt by another non admin user" do
 sign_in_as(@chef2, "password")
updated_name ="joe"
updated_email= "joe@example.com"
patch chef_path(@chef), params: {chef:{name:"updated_name",email:"updated_email"}}
assert_redirected_to chefs_path
assert_not flash.empty?
@chef.reload 
assert_match "umair",@chef.name
assert_match "umair129@gmail.com",@chef.email
end
end
