class ProductsController < ApplicationController
	#Avoids the adding of favorites if there is no user logged.
	before_action :authorize, only: :favorite

	def index
		@products = Product.all.order(:name) 
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		
		#Permits to keep the web running even if it was intended to add a product completely empty. Does not save anything
		#in the database.
		if @product.save
      redirect_to root_path
    else
      render :new
    end

	end

	def favorite
		@product = Product.find(params[:id])
    
    type = params[:type]
    
    #Checks if the product is going to be added to the favorites list or not
    if type == "favorite"

    	#Checks if the product was already set as a favorite. Avoids having multiple displays of the same object.
    	if !current_user.favorites.exists?(@product.id)
      	current_user.favorites << @product
      	redirect_to '/', notice: "You added #{@product.name} to your favorites list!"
      else
      	redirect_to '/', notice: "That product is already in your favorites list!"
      end

    #In case that the type was set to "unfavorite" this will destroy the association between the user and the product
    #previously added into his favorite list. Notice that the instance of the product will not be deleted from the database.
    else type == "unfavorite"
      current_user.favorites.delete(@product)
      redirect_to current_user, notice: "You removed #{@product.name} from your favorites list!"
    end
  end

	private
    def product_params
      params.require(:product).permit(:name, :description, :image_url, :price)
    end

  #Auxilir method to authorize only logged users to enter certain roots
	def authorize
		if !logged_in?
			redirect_to root_path
		end
	end
end