class Client::MaintenanceEventsController < ApplicationController
  def index
    client_params = {
                     search: params[:search],
                     sort_by: params[:sort_by],
                     sort_order: params[:sort_order],
                     category: params[:category]
                    }
    response = Unirest.get(
                           "http://localhost:3000/api/maintenance_events",
                           parameters: client_params
                           )
    @maintenance_events = response.body
    render 'index.html.erb'
  end

  def new
    @maintenance_event = {}
    render 'new.html.erb'
  end

  def create
    @maintenance_event = {
                   'car_id' => params[:car_id],
                   'price' => params[:price],
                   'provider' => params[:provider],
                   'price' => params[:price],
                   'date' => params[:date],
                   'mileage' => params[:mileage],
                   'complete' => params[:complete]

                  }

    response = Unirest.post(
                            "http://localhost:3000/api/maintenance_events",
                            parameters: @maintenance_event
                            )

    if response.code == 200
      flash[:success] = "Successfully created maintenance_event"
      redirect_to "/client/maintenance_events/"
    elsif response.code == 401
      flash[:warning] = "You Are Not Authorized To Make A Maintenance Event"
      redirect_to "/"
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    maintenance_event_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/maintenance_events/#{maintenance_event_id}")
    @maintenance_event = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/maintenance_events/#{params[:id]}")
    @maintenance_event = response.body
    render 'edit.html.erb'
  end

  def update
    @maintenance_event = {
                   'car_id' => params[:car_id],
                   'provider' => params[:provider],
                   'price' => params[:price],
                   'date' => params[:date],
                   'mileage' => params[:mileage],
                   'complete' => params[:complete]
                  }

    response = Unirest.patch(
                            "http://localhost:3000/api/maintenance_events/#{params[:id]}",
                            parameters: @maintenance_event
                            )

    if response.code == 200
      flash[:success] = "Successfully Updated Maintenance Event"
      redirect_to "/client/maintenance_events/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/maintenance_events/#{params['id']}")
    if response.code == 200
      flash[:success] = "Successfully Destroyed Maintenance Event"
      redirect_to "/client/maintenance_events"
    else
      flash[:warning] = "You are not Authorized"
      redirect_to '/'
    end
  end
end
