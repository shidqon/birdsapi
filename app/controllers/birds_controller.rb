class BirdsController < ApplicationController
  def index
    # Get all birds data from database and render it as JSON.
    render json: Bird.all.to_json(:include => :trees)
  end

  def show
    bird = Bird.find(params[:id])
    render json: bird.to_json(:include => :trees)
  end

  def create
    bird = Bird.new(bird_params)

    return render_validation_error(bird.errors) if bird.invalid?
    
    bird.save!
    render json: bird
  end

  def update
    bird = Bird.find(params[:id])
    bird.assign_attributes(bird_params)

    return render_validation_error(bird.errors) if bird.invalid?

    bird.save!
    render json: bird
  end

  def delete
    bird = Bird.find(params[:id])
    bird.delete
    render json: {message: 'bird deleted'}
  end

  def render_validation_error(errors)
    res = errors.map do |error|
      { field: error.attribute, message: error.full_message }
    end

    render json: res, status: :unprocessable_entity
  end

  def bird_params
    # Rails automatically loads the request body into the params hash.
    # The parameters will be wrapped with a key choosen based on the controller's name.
    # In this case, the request body can be accessed as params[:bird]
    
    # We require bird object to be present. With permit, we can filter what parameters we want.
    # In this case, we only want to have name and description parameters.
    params.require(:bird).permit(:name, :description)
  end
end
