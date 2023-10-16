# features/step_definitions/steps.rb
Given("I have entered {int} into the calculator") do |number|
  @number = number
end

When("I press add") do
  @result = @number + @number
end

When("I press subtract") do
  @result = @number - @number
end

When("I press multiply") do
  @result = @number * @number
end

When("I press divide") do
  @result = @number / @number
end

Then("the result should be {string} on the screen") do |expected_result|
  expect(@result.to_s).to eq(expected_result)
end
