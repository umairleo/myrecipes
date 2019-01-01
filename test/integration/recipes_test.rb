require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

def setup
@chef = Chef.create!(name:"murtaza",email:"murtaz@gmail.com")
@recipe = Recipe.create(name:"vegetable saute",description:"cooked for 20min in oil",chef:@chef)
@recipe2 = @chef.recipes.build(name:"chicken soup", description:"all vegetable sand chicken can make a soup")
@recipe2.save
end  

test "should get recipes index" do
get recipes_path
assert_response :success
end

test"should get recipes listing" do
get recipes_path
assert_template 'recipes/index'
assert_match @recipe.name, response.body
assert_match @recipe2.name, response.body
end

end
