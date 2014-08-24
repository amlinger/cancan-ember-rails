class API::V1::AbilityController < ApplicationController

  def index
    user = User.create({ 
        :name  => "Anton Amlinger",
        :email => "anton.amlinger@localhost.com",
        :role  => "moderator"
    })
    
    @ability = Ability.new( user )
    respond_to do |format|
      format.json { render :json => @ability }
    end
  end

end