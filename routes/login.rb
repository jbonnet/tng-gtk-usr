post "/login" do
	role = ""
	puts "#{params[:username]}"
	puts "#{params[:password]}"


	@user = User.find_by_username(params[:username])

	@typed_password = "#{params[:password]}"

	puts "typed_password"
	puts @typed_password
	pwd = Digest::SHA1.hexdigest @typed_password.to_s
	puts "this is the login encrypted password"
	puts pwd
	#puts "paco encrypted"
	#pwd_2 = Digest::SHA1.hexdigest 'paco'
	#puts pwd_2


	@user['password']


	if pwd == @user['password']				

		payload = { username: "#{params[:username]}", exp: Time.now.to_i + 60 * 60, iat: Time.now.to_i}
		token = JWT.encode(payload, SECRET,'HS256')
		return 200, token.to_json

	else		
		puts "the pwd is not correct"
		puts pwd
		puts @user['password']
		msg="Unauthorized, wrong user or password"
		return 409, msg.to_json
	end



	if @user
		payload = { username: "#{params[:username]}", exp: Time.now.to_i + 60 * 60, iat: Time.now.to_i}
		token = JWT.encode(payload, SECRET,'HS256')
		return 200, token.to_json
	else
		msg="Unregistered user"
		return 404, msg.to_json
	end
  end

  post "/login/old" do
	role = ""
	puts "#{params[:username]}"
	puts "#{params[:password]}"

	@user = User.find_by_username(params[:username])

	if @user
		payload = { username: "#{params[:username]}", exp: Time.now.to_i + 60 * 60, iat: Time.now.to_i}
		token = JWT.encode(payload, SECRET,'HS256')
		return 200, token.to_json
	else
		msg="Unregistered user"
		return 404, msg.to_json
	end
  end

