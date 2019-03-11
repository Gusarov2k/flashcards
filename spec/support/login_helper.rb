module LogInHelper
  def log_in(email, password, action)
    visit log_in_path(locale: :en)
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button action
  end
end
