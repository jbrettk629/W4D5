require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  subject(:user) do
    User.create!(
    username: 'Zoolander',
    password: 'mugatusucks',
    email: 'latigre@whymalemodels.com')
  end
    
  describe 'GET #new' do
    it 'renders the sign in page' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe 'POST #create' do
    context 'valid params' do
      
      it 'saves a new user into the database' do
        post :create, params: {user: {username: 'JK', password: 'starwars', email: 'jk@hogwarts.edu'}}
        jk = User.find_by(username: 'JK')
        expect(jk).not_to be_nil
      end
      
      it 'logs the user in and redirects to the user\'s page' do
        post :create, params: {user: {username: 'JK', password: 'starwars', email: 'jk@hogwarts.edu'}}
        jk = User.find_by(username: 'JK')
        expect(session[:session_token]).to eq(jk.session_token)
      end
    end
    
    context 'invalid params' do 
      it 'redirects to the sign up page' do
        post :create, params: {user: {username: 'JK', password: 'star', email: 'jk@hogwarts.edu'}}
        expect(response).to render_template(:new)
      end 
    end 
  end

  describe 'GET #show' do 
    it 'redirects to an individual\'s page' do
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end 
  end 
  
  describe 'GET #index' do
    it 'show ALL THE USERS' do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe 'DELETE #destroy' do
    it 'removes the user from the database and renders sign in page' do
      to_query = user.id
      delete :destroy, params: {id: user.id}
      expect(response).to render_template(:new)
      query = User.find_by(id: to_query)
      expect(query).to be_nil
    end
  end
  
      
  # '#edit renders the user edit page'
  # '#update changes the user\'s info in the database'
end
