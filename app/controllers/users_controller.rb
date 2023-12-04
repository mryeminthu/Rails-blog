class UsersController < 
  
  def index
    @users = User.all
  end

end
  