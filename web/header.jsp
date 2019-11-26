
	<%@page import="java.io.PrintWriter"%>
<%@page import="modelo.Sesion"%>
    <header>
 <% 
     HttpSession misession = request.getSession(true);
     Sesion user = (Sesion) misession.getAttribute("usuario");%>
 
      <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
          
          
          <% if(user!=null){
         out.println(" <img class=\"rounded-circle\" src=\"GetImagen?id="+ user.getIdUsuario() +"&tipo=2&num=0\" alt=\"Generic placeholder image\" width=\"80\" height=\"80\"> ");
            
}
else{
     out.println(" <img class=\"rounded-circle\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==\" alt=\"Generic placeholder image\" width=\"80\" height=\"80\"> ");
}
%>

<label><a class="navbar-brand" href="Index"><i class="fas fa-home"></i> Inicio</a></label>
  
<br>

<% if(user!=null){
    if(user.getIdUsuario()==1){
         out.println("<label><a class=\"navbar-brand\" href=\"AdministrarSitio\">" + user.getNombreUsuario() + "</a></label>");
    }
    else
    {
        out.println("<label><a class=\"navbar-brand\" href=\"perfil?id="+ user.getIdUsuario() +"\">" + user.getNombreUsuario() + "</a></label>");
    }
     out.println("<input type=\"hidden\" id=\"usuarioActual\" name=\"idUsuario\" value=\"" + user.getIdUsuario() + "\"");
}
else{
     out.println("<label><a class=\"navbar-brand\" href=\"Index\"> Usuario sin registrar</a></label>");
      out.println("<input type=\"hidden\" id=\"usuarioActual\" name=\"idUsuario\" value=\"1\"");
}
%>


        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
          
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <ul class="navbar-nav mr-auto">
              
              <li class="nav-item active">
              <a class="nav-link" onclick="abrir()"> <label>Categorias </label> <span class="sr-only">(current)</span></a>
            </li>
              
<% if(user!=null){
     
     if(user.getIdUsuario()>1){
         out.println("<li class=\"nav-item active\"><a class=\"nav-link\" href=\"perfil?id="+ user.getIdUsuario() +"\"><label>Mis Cotizaciones </label> <span class=\"sr-only\">(current)</span></a></li>");
          out.println("<li class=\"nav-item active\"><a class=\"nav-link\" href=\"verCarrito?id="+ user.getIdUsuario() + "\"><label> Cotizador</label> <span class=\"sr-only\">(current)</span></a></li>");
     }
     else if(user.getIdUsuario()== 1){
          out.println("<li class=\"nav-item active\"><a class=\"nav-link\" href=\"AdministrarSitio\"><label>Administrar </label> <span class=\"sr-only\">(current)</span></a></li>");
     }
}

%>
            

            


          </ul>
          <form action="resultadosBusqueda" method="GET" class="form-inline mt-2 mt-md-0">
              <input type="hidden" name="tipo" value="2">
            <input class="form-control mr-sm-2" type="text" name="filtro" placeholder="Buscar..." aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Buscar</button>
          </form>

           <ul class="navbar-nav mr-auto">           
                          
                          <% if(user!=null){
     out.println(" <li class=\"nav-item px-1\"><a class=\"nav-link\" href=\"Salir?logout=true\" >Cerrar sesion <span class=\"sr-only\">(current)</span></a></li>");
}
else{
     out.println(" <li class=\"nav-item px-1\"><a class=\"nav-link\" href=\"ini_ses.jsp\">Iniciar sesion <span class=\"sr-only\">(current)</span></a></li>");
     out.println(" <li class=\"nav-item px-1\"><a class=\"nav-link\" href=\"registro.jsp\">Regitrarse <span class=\"sr-only\">(current)</span></a></li>");
}
%>
             
                      
           </ul>
        </div>
      </nav>


    </header>