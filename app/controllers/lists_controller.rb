class ListsController <  ApplicationController
    before_action :authenticate_user!,only: %i[index new create]

    def index
      @lists = current_user.lists
    end

    def show
      @list = List.find(params[:id])
    end
  
    def new
      @list = List.new
    end
  
    def create
      @list =  List.new(params_list)
      @list.user = current_user
      if @list.save
        redirect_to @list
      else
        #flash.now[:failure] = "Você não pode criar listas sem nome"
        render :new
      end
    end
  
    private
  
    def params_list
      params.require(:list).permit(:name)
    end

  end
  