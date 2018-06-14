class Client::CarsController < ApplicationController
  def index
    client_params = {
                     search: params[:search],
                     sort_by: params[:sort_by],
                     sort_order: params[:sort_order],
                     category: params[:category]
                    }
    response = Unirest.get(
                           "http://localhost:3000/api/cars",
                           parameters: client_params
                           )
    @cars = response.body
    render 'index.html.erb'
  end

  def new
    @car = {}
    render 'new.html.erb'
  end

  def create
    @car = {
                   'user_id' => params[:user_id],
                   'year' => params[:year],
                   'make' => params[:make],
                   'model' => params[:model],
                   'mileage' => params[:mileage]
                  }

    response = Unirest.post(
                            "http://localhost:3000/api/cars",
                            parameters: @car
                            )

    if response.code == 200
      flash[:success] = "Successfully created Car"
      redirect_to "/client/cars/"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized to make a car"
      redirect_to "/"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    car_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/cars/#{car_id}")
    @car = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/cars/#{params[:id]}")
    @car = response.body
    render 'edit.html.erb'
  end

  def update
    @car = {
                   'user_id' => params[:user_id],
                   'year' => params[:year],
                   'make' => params[:make],
                   'model' => params[:model],
                   'mileage' => params[:mileage]
                   }

    response = Unirest.patch(
                            "http://localhost:3000/api/cars/#{params[:id]}",
                            parameters: @car
                            )

    if response.code == 200
      flash[:success] = "Successfully updated Car"
      redirect_to "/client/cars/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/cars/#{params['id']}")
    if response.code == 200
      flash[:success] = "Successfully destroyed car"
      redirect_to "/client/cars"
    else
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    end
  end
end
