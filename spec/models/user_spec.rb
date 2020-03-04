describe User do
  it 'validates user email' do
    expect { User.create!(email: 'xyz') }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
