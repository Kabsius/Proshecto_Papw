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

      <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img class="first-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide">
            <div class="container">
              <div class="carousel-caption text-left">
                <h1>Example headline.</h1>
                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                <p><a class="btn btn-lg btn-primary" href="art_det.jsp" role="button">Ver </a></p>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <img class="second-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Second slide">
            <div class="container">
              <div class="carousel-caption">
                <h1>Another example headline.</h1>
                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                <p><a class="btn btn-lg btn-primary" href="art_det.jsp" role="button">Ver</a></p>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <img class="third-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Third slide">
            <div class="container">
              <div class="carousel-caption text-right">
                <h1>One more for good measure.</h1>
                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                <p><a class="btn btn-lg btn-primary" href="art_det.jsp" role="button">Ver</a></p>
              </div>
            </div>
          </div>
        </div>
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>


      <!-- Marketing messaging and featurettes
      ================================================== -->
      <!-- Wrap the rest of the page in another container to center all the content. -->

      <div class="container marketing">
          
          <div class="row center">
              <h3><b>Productos Destacados</b></h3>
          </div>

        <!-- Three columns of text below the carousel -->
        <div class="row">
       <%
           List<Producto> nuevos = (List) request.getAttribute("nuevos");
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
