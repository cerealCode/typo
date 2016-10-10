Then(/^I should see "([^"]*)" as header$/) do |text|
    item = page.find(:css, ".page-header").text
    expect(item).to eq(text), "Header for Categories not found"
  end