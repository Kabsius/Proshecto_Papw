<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Index</title>
            <script scr="js/registro.js"></script>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/carousel.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
  </head>
  <body onload="index();" >



 <jsp:include page="header.jsp"/> 

<section >
   <div  id="categorias"class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <ul class="nav flex-column my-5">
              
              

 <jsp:useBean id="categoria" scope="page" class="modelo.cboCategorias"></jsp:useBean>
          <%
               ResultSet pList = categoria.categorias();
                while(pList.next()){
         %>
              <li class="nav-item">
                  <a class="nav-link" href="resultadosBusqueda?tipo=1&catId=<%= pList.getInt("id_categoria")  %>">
                  <span data-feather="file"></span>
                  <%= pList.getString("categoria") %>
                </a>
              </li>
         <%
                  }
         %>
            
            </ul>
</div>  </nav> </div> </div> 
   
</section>
<aside>
    <main role="main">

  


      <!-- Marketing messaging and featurettes
      ================================================== -->
      <!-- Wrap the rest of the page in another container to center all the content. -->

      <div class="container marketing py-3">
          
          <div class="row center my-5">
              <div class="col-2"></div>
              <div class="col-8 text-center" style="font-size: 13px;">
                   <h5><b>Resultados de la busqueda:</b></h5>
                   <br>
                   <br>
                   <form action="resultadosBusqueda" method="GET" class="form-inline mt-2 mt-md-0">
                       <input type="hidden" name="tipo" value="3">
                       <label for="ini">Fecha Inicio</label>
                       <input class="form-control mx-3" type="date" name="inicio" id="ini" required> 
                       <label for="fn">Fecha Fin</label>
                       <input type="date" class="form-control mx-3" name="fin" id='fn' required>
                       <button class="btn btn-outline-success my-2 my-sm-0" type="submit" value="Filtrar"><i class="fas fa-filter"></i> Filtrar</button>
                   </form>
                   <hr>
              </div>
              <div class="col-2"></div>
             
          </div>

        <!-- Three columns of text below the carousel -->
        <div class="row py-2">
       <%
           List<Producto> nuevos = (List) request.getAttribute("resultados");
           if(nuevos != null){
                                                    
             for(Producto art : nuevos){
       %>
          <div class="col-lg-4 my-3">
            <img class="rounded-circle" src="GetImagen?id=<%= art.getIdProducto() %>&tipo=1&num=1" alt="Generic placeholder image" width="140" height="140">
            <h2><%= art.getNombre() %></h2>
            <p><%= art.getCategoria() %></p>
            
            <p><a class="btn btn-info" href="detalleProducto?id=<%= art.getIdProducto() %>" role="button">Ver detalles &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
        <%     }
            }
else{
        out.println("<h3>No hay resultados para esta búsqueda...</h3>");
}
        %>
        </div><!-- /.row -->


       
      <!-- FOOTER -->
      <footer class="container">
       
        <p>&copy; 2017-2019 Esaus and Co, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
      </footer>
    </main>
</aside>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-slim.min.js"><\/script>')</script>
    
    <script src="js/bootstrap.min.js"></script>


  <script src="js/registro.js"></script>

  </body>
</html>
