class TreesController < ApplicationController
  def index
    # Get all trees data from database and render it as JSON.
    render json: Tree.all.to_json(:include => :birds)
  end

  def show
    tree = Tree.find(params[:id])
    render json: tree.to_json(:include => :birds)
  end

  def create
    tree = Tree.new(tree_params)

    return render_validation_error(tree.errors) if tree.invalid?
    
    tree.save!
    render json: tree
  end

  def update
    tree = Tree.find(params[:id])
    tree.assign_attributes(tree_params)

    return render_validation_error(tree.errors) if tree.invalid?

    tree.save!
    render json: tree.to_json(:include => :birds)
  end

  def delete
    tree = Tree.find(params[:id])
    tree.delete
    render json: {message: 'tree deleted'}
  end

  def update_birds
    begin
      tree = Tree.find(params[:id])
      tree.bird_ids = params[:bird_ids]

      tree.save!
    rescue StandardError => error
      return render_error(error)
    end

    render json: tree.to_json(:include => :birds)
  end

  def render_validation_error(errors)
    res = errors.map do |error|
      { field: error.attribute, message: error.full_message }
    end

    render json: res, status: :unprocessable_entity
  end

  def render_error(error)
    res = { message: error.message }
    render json: res, status: :internal_server_error
  end

  def tree_params
    # Rails automatically loads the request body into the params hash.
    # The parameters will be wrapped with a key choosen based on the controller's name.
    # In this case, the request body can be accessed as params[:tree]
    
    # We require tree object to be present. With permit, we can filter what parameters we want.
    # In this case, we only want to have name and description parameters.
    params.require(:tree).permit(:name, :species, :height, :bird_ids)
  end
end
