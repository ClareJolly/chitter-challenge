# As a Maker
# So that I can let people know what I am doing
# I want to post a message (peep) to chitter

feature 'Adding Peep' do
  scenario 'a user can add a peep' do
    create_single_peep
    # p URI.parse(current_url)
    expect(page).to have_content('Peep: Woohoo, I am peeping')
  end
end
