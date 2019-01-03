require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

def setup
@chef = Chef.create!(name:"emmad", email:"emmad@gmail.com", password: "password", password_confirmation: "password")
@recipe =@chef.recipes.build(name:"Chappli Kabbab", description: "Chapli Kabbab Recipe")
end
test "recipe without chef should be invalid" do
@recipe.chef_id = nil
assert_not @recipe.valid?
end

test "recipe should be valid" do
assert @recipe.valid?
end

test "name should be present" do
@recipe.name = ""
assert_not @recipe.valid?
end

test "description should be present" do
@recipe.description = ""
assert_not @recipe.valid?
end


test "description shouldn't be less than 5chracters"do 
@recipe.description ="a" * 3
assert_not @recipe.valid?
end

test "description shouldn't be more than 500 chracters"do
@recipe.description = "a" * 501
assert_not @recipe.valid?
end
 

end
