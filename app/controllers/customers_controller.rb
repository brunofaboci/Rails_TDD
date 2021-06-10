class CustomersController < ApplicationController

	def index
		@customers = Customer.all
	end

	def new
		@customer = Customer.new
	end

	def show
		@customer = Customer.find(params[:id])
	end

	def create
		@customer = Customer.new(customer_params)

		if @customer.save
			redirect_to customers_path, notice: 'Cliente cadastrado com sucesso!'
		else
			render :new
		end
	end

	def customer_params
		params.require(:customer).permit(:id, :first_name, :last_name, :email, :phone, :smoker, :avatar)
	end

end
