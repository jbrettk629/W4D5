
require 'rails_helper'
require 'spec_helper'



# describe User do 
  # let(:incomplete_user) { email: 'me@gmail.com', password: 'starwars'}
  # it 'validates_presence_of username' do 
  #   expect(incomplete_user).not_to be_valid 
  # end 
# end 

RSpec.describe User, type: :model do
  ron = User.create(username: 'rw', email: 'rw@email.com', password: 'starwars')
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:email)}
  it { should validate_length_of(:password).is_at_least(6)}
  it { should validate_presence_of(:session_token)}
  it { should validate_presence_of (:password_digest)}
  
  it { should validate_uniqueness_of(:username)}
  it { should validate_uniqueness_of(:email)}
  it { should validate_uniqueness_of(:session_token)}
  
  # it { :should have_many(:goals) }
  # it { :should have_many(:comments_written) }
  # it { :should have_many(:comments_received) }
  
  describe 'session_token' do
    it 'assigns session_token if one is not given' do
      harry = User.new(username: 'hp', email: 'hp@email.com', password: 'starwars')
      expect(harry.session_token).not_to be_nil
    end
  end
  
  describe 'password_encryption' do
    it 'does not save password in database' do
      User.create(username: 'hp', email: 'hp@email.com', password: 'starwars')
      user = User.find_by(username: 'hp')
      expect(user.password).not_to be('starwars')
    end
    
    it 'uses bcrypt to create a password_digest' do 
        
        expect(BCrypt::Password).to receive(:create).with('starwars')
        User.new(username: 'hp', email: 'hp@email.com', password: 'starwars')
    end  
  end
  
  # describe 'find user by credentials' do
  #   it 'finds a user with username and password' do
  #     ron = User.create(username: 'rw', email: 'rw@email.com', password: 'starwars')  
  #     expect(User.find_by_credentials('rw', 'starwars')).to eq(ron)
  #   end
  # end
end