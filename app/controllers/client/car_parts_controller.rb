class Client::CarPartsController < ApplicationController
  def index
    client_params = {
                     search: params[:search],
                     sort_by: params[:sort_by],
                     sort_order: params[:sort_order],
                     category: params[:category]
                    }
    response = Unirest.get(
                           "http://localhost:3000/api/car_parts",
                           parameters: client_params
                           )
    @car_parts = response.body
    render 'index.html.erb'
  end

  def new
    @car_part = {}
    render 'new.html.erb'
  end

  def create
    @car_part = {
                   'maintenance_event_id' => params[:maintenance_event_id],
                   'price' => params[:price],
                   'date' => params[:date],
                   'part_number' => params[:part_number]
                  }

    response = Unirest.post(
                            "http://localhost:3000/api/car_parts",
                            parameters: @car_part
                            )

    if response.code == 200
      flash[:success] = "Successfully created Car Part"
      redirect_to "/client/car_parts/"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized to make a car part"
      redirect_to "/"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    car_part_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/car_parts/#{car_part_id}")
    @car_part = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/car_parts/#{params[:id]}")
    @car_part = response.body
    render 'edit.html.erb'
  end

  def update
    @car_part = {
                   'maintenance_event_id' => params[:maintenance_event_id],
                   'date' => params[:date],
                   'price' => params[:price],
                   'part_number' => params[:part_number]
                   }

    response = Unirest.patch(
                            "http://localhost:3000/api/car_parts/#{params[:id]}",
                            parameters: @car_part
                            )

    if response.code == 200
      flash[:success] = "Successfully updated Car Part"
      redirect_to "/client/car_parts/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/car_parts/#{params['id']}")
    if response.code == 200
      flash[:success] = "Successfully destroyed Car Part"
      redirect_to "/client/car_parts"
    else
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    end
  end
end

