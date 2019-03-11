module FormHelper
  def check_form(value = 0)
    card.box = value
    card.save if value > 0
    within('form') do
      fill_in 'check[user_text]', with: 'home'
    end
    click_button 'Check'
    card.reload
  end
end
