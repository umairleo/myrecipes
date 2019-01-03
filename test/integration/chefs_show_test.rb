require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
 
def setup
@chef = Chef.create!(name:"murtaza",email:"murtaz@gmail.com",
 password: "password", password_confirmation: "password")
@recipe = Recipe.create(name:"vegetable saute",description:"cooked for 20min in oil",chef:@chef)
@recipe2 = @chef.recipes.build(name:"chicken soup", description:"all vegetable sand chicken can make a soup")
@recipe2.save
end 
test "should get chefs show " do
get chef_path(@chef)
assert_template 'chef/show'
assert_select "a[href=?]", recipe_path(@recipe), text:@recipe.name 
assert_select "a[href=?]", recipe_path(@recipe2), text:@recipe2.name 
assert_match @recipe.description, response.body
assert_match @recipe2.description, response.body
assert_match @chef.name, response.body
end

end

