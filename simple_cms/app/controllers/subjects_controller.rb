class SubjectsController < ApplicationController

  layout "admin"

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def create
    # Instantiate a new object using the form parameters
    @subject =  Subject.new(subject_params)
    # Save the object
    if @subject.save
       # If save succeeds, redirect to index
       flash[:notice] = "Subject created successfully."
       redirect_to(:action => 'index')
    else
       # If save fails, redisplay the form so user can fix problems
       render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # Find an existing object using the form parameters
    @subject =  Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
       # If update succeeds, redirect to index
       flash[:notice] = "Subject updated successfully."
       redirect_to(:action => 'show', :id => @subject.id)
    else
       # If update fails, redisplay the form so user can fix problems
       render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private

    def subject_params
      # raises an error if subject is not set
      # and whitelists for mass-assignment
      params.require(:subject).permit(:name, :position, :visible)
    end

end
