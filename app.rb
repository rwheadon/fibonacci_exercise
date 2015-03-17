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
 #couldn't get the flash[:error] to delete so clearing logic params for a better login page visit
 # by clearing session settings on non-auth sessions
  session[:user_in] = nil
  session[:pass_in] = nil
  session[:auth] = false
  redirect to "world"
end

get '/secure' do
  if session[:auth]
    erb :secure, locals: {name: session[:user_in]}
  else
     #couldn't get the flash[:error] to delete so clearing logic params for a better login page visit
     # by clearing session settings on non-auth sessions
    session[:user_in]=nil
    session[:pass_in]=nil
    redirect to "/login"
  end
end

get '/world' do
  if session[:auth]
    redirect to "secure"
  else
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
           <td><input type="text" id="username" class="logins" name="post[username]" autofocus/></td>
        </tr><tr>
          <td class="aright">Password:</td>
          <td><input type="password" id="password" class="logins" name="post[password]" /></td>
        </tr>
      </tbody>
      <tfoot>
        <tr><td></td><td><input type="submit" class="sbut"></td></tr>
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
  <%= erb :scripting %>
</head>
  <body>

    <%= erb :fib_header %>
    <div class="container">
    <p>
    Thanks for visiting Fib World  <b><%= name %></b><br /><br />
    </p>
    <p>
      The First 100 in our fibonacci sequence are:<table><tbody>
      <% Fibonacci.new.fib(0, 1, 100, []).each_with_index do | f, idx | %>
        <%= (idx+1) % 2 == 0 ? "<tr class=\"olemph\"><td class=\"liemph\">#{idx+1}<td class=\"lidataemph\">#{f}</td></tr>" : "<tr><td>#{idx+1}<td>#{f}</td></tr>" %>
      <% end %>
    </tbody></table>
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

@@ scripting
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.2.min.js"></script>

@@ styling
<link rel="stylesheet" type="text/css" href="css/fibapp.css"/>

@@ fib_header
  <h1>Welcome to Fib World!</h1>