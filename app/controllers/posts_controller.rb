class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
	  @post = Post.new(post_params(:title, :description))
	  @post.save
	  redirect_to post_path(@post)
	end

	def update
	  @post = Post.find(params[:id])
	  @post.update(post_params(:title))
	  redirect_to post_path(@post)
	end

	private

	def post_params(*args)
	  params.require(:post).permit(*args)
	end

	#by using the splat operator to allow the method to take additional arguments we make the code more flexible.

	def edit
	  @post = Post.find(params[:id])
	end

end

#require vs. permit
# the .require method is the most restrictive because it requires that all params being passed in require the key ":post". The user recieves an error otherwise.
# the .permit method is a bit more lenient. It allows for whatever key's are passed into it. In this case :title and :description. If it does not have one of those keys than rails will throw an error.


	# def create
	#   @post = Post.new(params.require(:post).permit(:title, :description))
	#   @post.save
	#   redirect_to post_path(@post)
	# end
	#
	# def update
	#   @post = Post.find(params[:id])
	#   @post.update(params.require(:post).permit(:title))
	#   redirect_to post_path(@post)
	# end

	# protecting our params like this would get tedious in the event of multiple controllers. Common practice is to refactor into:
	# def post_params
	# params.require(:post).permit(:title, :description)
	# end

	# which you can call as such: Post.new(post_params)
