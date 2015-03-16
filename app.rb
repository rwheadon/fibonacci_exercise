require 'sinatra'
require 'sinatra/flash'
require_relative 'fibonacci'

enable :sessions
set :session_secret, '14m45up3r53cr37' #supress sinatra warnings 

get '/login' do
  session[:user_in] = params[:post][:username] unless params[:post].nil?
  session[:pass_in] = params[:post][:password] unless params[:post].nil?
  session[:auth] = session[:pass_in] == "fibworld" ? true : false  unless params[:post].nil?
  if session[:auth]
   redirect to "/secure"
  else
    if (session[:pass_in].nil? || session[:user_in].nil?) || (session[:pass_in].empty? || session[:user_in].empty?)
      flash.now[:error] = "Please fill in all of the fields"
      erb :login
    else #we hava a password most likely
       flash.now[:error] = "Login credentials are incorrect"
      erb :login
    end 
  end 

end

get '/logout' do
  session[:user_in] = nil
  session[:pass_in] = nil
  session[:auth] = false
  flash[:error]=""
  redirect to "world"
end

get '/secure' do
  if session[:auth]
    erb :secure, locals: {name: session[:user_in]}
  else

    session[:user_in]=nil
    session[:pass_in]=nil
    redirect to "/login"
  end
end

get '/world' do
  if session[:auth]
    redirect to "secure"
  else
    flash[:error]=""
    erb :world
  end
end

get '/' do
  if session[:auth]
    redirect to "secure"
  else
    redirect to "world"
  end
end 

__END__
@@ login
<html>
<title>Login</title>
<head>
  <%= erb :styling %>
</head>
  <body>
    <h1>Login Form</h1>
   <form class="loginform" action="/login?" method"post">
     <table>
       <tbody>
         <tr>
           <td colspan="2" class="flashcell">
             <% if flash[:error] %>
                  <span class="alert alert-info">
               <%= flash[:error] %>
                    </span>
             <% end %>
           </td>
         </tr>
         <tr>
           <td class="aright">User Name:</td>
           <td><input type="text" id="username" class="logins" name="post[username]" /></td>
        </tr><tr>
          <td class="aright">Password:</td>
          <td><input type="password" id="password" class="logins" name="post[password]" /></td>
        </tr>
      </tbody>
      <tfoot>
        <tr><td></td><td><input type="submit" class="sbut btn btn-primary"></td></tr>
      </tfoot>
    </table>
          
    </form>
    <p class="centerlink">
      <a href="/world">Click here to return to main page</a>
    </p>
  </body>
</html>

@@ secure
<html>
<title>Private Page</title>
<head>
  <%= erb :styling %>
</head>
  <body>

    <%= erb :fib_header %>
    <div class="container">
    <p>
    Thanks for visiting Fib World  <b><%= name %></b><br /><br />
    </p>
    <p>The First 10 in our fibonacci sequence are:<br />
      <%= Fibonacci.new.fib(0, 1, 10, []).join(", ") %>
    </p>
    
    <p>
      <a href="/logout">Click here to log out</a>
    </p>
      
    </div>
    
  </body>
</html>

@@ world
<html>
<title>Public Page</title>
<head>
  <%= erb :styling %>
</head>
  <body>

    <%= erb :fib_header %>
    <div class="container">
    <p>
    Logging in will give you the sequence<br /><br />
    <a href="/secure">Click here to log in</a>
    </p>
  </div>
  </body>
</html>

@@ styling
<style>
body {
  font-family: verdana,tahoma,sans-serif;
}

h1 {
  text-align: center;
}

.loginform {
  display: block;
  width: 50%;
  background: #c0c0c0;
  margin: auto;
  padding: 20px;
}

.container {
  margin: auto;
  padding: 10px;
  width: 50%;
  background: #c0c0c0;
}

.centerlink {
  text-align: center;
}

.aright {
  text-align: right;
  padding: 5px;
}

.sbut {
  margin-top: 10px;
}

.flashcell {
  height: 50px;
  text-align: center;
  vertical-align: top;
}
</style>

@@ fib_header
  <h1>Welcome to Fib World!</h1>