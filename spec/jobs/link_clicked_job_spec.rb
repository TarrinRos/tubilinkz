require 'rails_helper'

# Простейший тест фоновой задачи — выполняем ее синхронно и проверяем
# сделанные ею в базе изменения
#
# http://edgeguides.rubyonrails.org/testing.html#testing-jobs
RSpec.describe LinkClickedJob, type: :job do
  let(:user) {User.create(email: 'test@example.com', password: '123456')}
  let(:link) {Link.create!(url: 'goodprogrammer.ru', clicks: 5, updated_at: '13:35', user: user)}

  before(:each) do
    LinkClickedJob.perform_now(link)
  end

  it 'increments click counter by 1' do
    expect(link.reload.clicks).to eq 6
  end

  it 'leaves updated_at untouched' do
    expect(link.reload.updated_at).to eq '13:35'
  end
end
