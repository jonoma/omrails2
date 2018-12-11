class ListsController < InheritedResources::Base

  # GET /lists/new
  def new
    @list = current_user.lists.new
  end

  # GET /lists/1/edit
  def edit
    @list = current_user.lists.find(params[:id])
  end

  # POST /lists
  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new 
    end
  end

  # PATCH/PUT /lists/1
  def update
    @list = current_user.list.find(params[:id])
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lists/1
  def destroy
    @list = current_user.lists.find(params[:id])
    @list.destroy
    redirect_to lists_url, notice: 'List was successfully destroyed.'
  end

  private

    def list_params
      params.require(:list).permit(:user, :title)
    end
end

