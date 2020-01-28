class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = current_user.contacts.order(:full_name)
  end

  def show
  end

  def new
    @contact = Contact.new
    @introduction = Introduction.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    puts "...................................."
    puts contact_params[:introduction_attributes]
    puts "...................................."
    @introduction = Introduction.new(contact_params[:introduction_attributes])
    @introduction.contact = @contact
    if @contact.save && @introduction.save
      flash[:alert] = "Contact was successfully created."
      redirect_to @contact
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      flash[:alert] = "Contact was successfully updated."
      redirect_to @contact
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    flash[:alert] = "Contact was successfully destroyed."
    redirect_to contacts_url
  end

  def search
    @contacts = current_user.contacts.search(params[:phrase])
    respond_to do |format|
      format.js { render }
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact)
      .permit(
        :full_name,
        :email_primary,
        :email_secondary,
        :label_email_primary,
        :label_email_secondary,
        :phone_primary,
        :label_phone_primary,
        :phone_secondary,
        :label_phone_secondary,
        :notes,
        :organisation,
        introduction_attributes: [:introduced_by_id, :relationship, :_destroy],
      )
  end

  def authorize_user!
    unless can? :crud, @contact
      render :file => "public/401.html", :status => :unauthorized
    end
  end

end
