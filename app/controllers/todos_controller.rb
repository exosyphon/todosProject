class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @todos = current_user.todos.all
    respond_with(@todos)
  end

  def show
    respond_with(@todo)
  end

  def new
    @todo = Todo.new
    respond_with(@todo)
  end

  def edit
  end

  def create
    @todo = current_user.todos.new(todo_params)
    @todo.save
    respond_with(@todo)
  end

  def update
    @todo.update(todo_params)
    current_user.todos << @todo
    respond_with(@todo)
  end

  def destroy
    @todo.destroy
    respond_with(@todo)
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:text)
    end
end
