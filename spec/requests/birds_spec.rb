require 'rails_helper'

RSpec.describe "Birds", type: :request do
  let(:bird) { Bird.new(name: 'a bird', description: 'a description') }
  let(:birds) { [ bird ] }

  describe "GET /birds" do
    before do
      allow(Bird).to receive(:all).and_return(birds)
    end

    it 'returns list of birds' do
      get '/birds'
      expect(response.body).to eq(birds.to_json)
    end
  end

  describe "POST /birds" do
    before do
      allow_any_instance_of(Bird).to receive(:save!)
    end

    context 'validation fails' do
      it 'returns validation error' do
        post '/birds', :params => { bird: {name: '', description: ''}  }
        expect(JSON.parse(response.body)).to eq([ 
          { 'field' => 'name', 'message' => "Name can't be blank" },
          { 'field' => 'description', 'message' => "Description can't be blank" },
        ])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'successful' do
      it 'return a bird' do
        post '/birds', :params => { bird: { name: 'a bird', description: 'a description' } }
        expect(JSON.parse(response.body)).to include({ 'name' => 'a bird', 'description' => 'a description' })
      end
    end
  end

  describe "PATCH /birds" do
    before do
      allow(Bird).to receive(:find).with('1').and_return(bird)
      allow_any_instance_of(Bird).to receive(:save!)
    end

    context 'validation fails' do
      it 'return validation error' do
        patch '/birds/1', :params => { bird: { name: '', description: '' } }
        expect(JSON.parse(response.body)).to eq([
          { 'field' => 'name', 'message' => "Name can't be blank" },
          { 'field' => 'description', 'message' => "Description can't be blank" },
        ])
      end
    end

    context 'successfull' do
      it 'return a bird' do
        patch '/birds/1', :params => { bird: { name: 'a name', description: 'a description' } }
        expect(JSON.parse(response.body)).to include({
          'name' => 'a name',
          'description' => 'a description',
        })
      end
    end
  end

  describe "DELETE /birds" do
    before do
      allow(Bird).to receive(:find).with('1').and_return(bird)
      allow_any_instance_of(Bird).to receive(:delete)
    end

    context 'successful' do
      it 'return success message' do
        delete '/birds/1'
        expect(JSON.parse(response.body)).to eq({ 'message' => 'bird deleted' })
      end
    end
  end
end
