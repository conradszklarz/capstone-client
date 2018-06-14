class Client::CarServicesController < ApplicationController
  def index
    client_params = {
                     search: params[:search],
                     sort_by: params[:sort_by],
                     sort_order: params[:sort_order],
                     category: params[:category]
                    }
    response = Unirest.get(
                           "http://localhost:3000/api/car_services",
                           parameters: client_params
                           )
    @car_services = response.body
    render 'index.html.erb'
  end

  def new
    @car_service = {}
    render 'new.html.erb'
  end

  def create
    @car_service = {
                   'car_id' => params[:car_id],
                   'service_id' => params[:service_id] 
                  }

    response = Unirest.post(
                            "http://localhost:3000/api/car_services",
                            parameters: @car_service
                            )

    if response.code == 200
      flash[:success] = "Successfully created Car Service"
      redirect_to "/client/car_services/"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized to make a car service"
      redirect_to "/"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    car_service = params[:id]
    response = Unirest.get("http://localhost:3000/api/car_services/#{car_service}")
    @car_service = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/car_services/#{params[:id]}")
    @car_service = response.body
    render 'edit.html.erb'
  end

  def update
    @car_service = {
                   'car_id' => params[:car_id],
                   'service_id' => params[:service_id]
                  }

    response = Unirest.patch(
                            "http://localhost:3000/api/car_services/#{params[:id]}",
                            parameters: @car_service
                            )

    if response.code == 200
      flash[:success] = "Successfully Updated Car Service"
      redirect_to "/client/car_services/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/car_services/#{params['id']}")
    if response.code == 200
      flash[:success] = "Successfully destroyed car service"
      redirect_to "/client/car_services"
    else
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    end
  end
end
