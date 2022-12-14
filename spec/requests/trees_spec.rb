require 'rails_helper'

RSpec.describe "Trees", type: :request do
  let(:tree) { Tree.new(name: 'a tree', species: 'species 1', height: 2000) }
  let(:trees) { [ tree ] }

  describe "GET /trees" do
    before do
      allow(Tree).to receive(:all).and_return(trees)
    end

    it 'returns list of trees' do
      get '/trees'
      expect(response.body).to eq(trees.to_json)
    end
  end

  describe "POST /trees" do
    before do
      allow_any_instance_of(Tree).to receive(:save!)
    end

    context 'validation fails' do
      it 'returns validation error' do
        post '/trees', :params => { tree: {name: '', species: '', height: 0 }  }
        expect(JSON.parse(response.body)).to eq([ 
          { 'field' => 'name', 'message' => "Name can't be blank" },
          { 'field' => 'species', 'message' => "Species can't be blank" },
          { 'field' => 'height', 'message' => "Height must be greater than 0" },
        ])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'successful' do
      it 'return a tree' do
        post '/trees', :params => { tree: { name: 'a tree', species: 'species 1', height: 2000 } }
        expect(JSON.parse(response.body)).to include({
          'name' => 'a tree',
          'species' => 'species 1',
          'height' => 2000,
        })
      end
    end
  end

  describe "PATCH /trees" do
    before do
      allow(Tree).to receive(:find).with('1').and_return(tree)
      allow_any_instance_of(Tree).to receive(:save!)
    end

    context 'validation fails' do
      it 'return validation error' do
        patch '/trees/1', :params => { tree: { name: '', species: '', height: 0 } }
        expect(JSON.parse(response.body)).to eq([ 
          { 'field' => 'name', 'message' => "Name can't be blank" },
          { 'field' => 'species', 'message' => "Species can't be blank" },
          { 'field' => 'height', 'message' => "Height must be greater than 0" },
        ])
      end
    end

    context 'successfull' do
      it 'return a tree' do
        patch '/trees/1', :params => { tree: { name: 'a tree', species: 'species 1', height: 2000 } }
        expect(JSON.parse(response.body)).to include({
          'name' => 'a tree',
          'species' => 'species 1',
          'height' => 2000,
        })
      end
    end
  end

  describe "DELETE /trees" do
    before do
      allow(Tree).to receive(:find).with('1').and_return(tree)
      allow_any_instance_of(Tree).to receive(:delete)
    end

    context 'successful' do
      it 'return success message' do
        delete '/trees/1'
        expect(JSON.parse(response.body)).to eq({ 'message' => 'tree deleted' })
      end
    end
  end
end
