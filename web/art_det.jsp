
<%@page import="java.sql.ResultSet"%>
<%@page import="modelo.Sesion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Comentario"%>
<!DOCTYPE html>
<html>
<head>
	            <script scr="js/registro.js"></script>
	<link rel="stylesheet" type="text/css" href="css/index.css">
	    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/carousel.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/estilo.css">
    
    
	<link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
	
           <link rel="stylesheet" type="text/css" href="css/uikit.css">
          <link rel="stylesheet" type="text/css" href="css/raiting.css">
	<title></title>
</head>
<body  >


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

<%@page import="java.io.PrintWriter"%>
<%@page import="modelo.Producto"%>
			

 <div class="row my-4">
     <div class="col-lg-12">
         
<br>

<% 

    Producto actual = (Producto) request.getAttribute("producto");
%>
							<footer id="limpia"></footer>

	<section id="categoria" class="gn">
            
            
                        <label>Categoría: </label><br>
            <%
                if(actual!=null){
                    out.println("<label><h5> " + actual.getCategoria() + "</h5></label>");
                }
                else{
                     out.println("<label><h5> (No disponible) </h5></label>");
                }
            %><br><br>
					
            <label>Precio: </label> <br>
            <%
                if(actual!=null){
                    out.println("<label><h5> $ " + actual.getPrecio() + "</h5></label>");
                }
                else{
                     out.println("<label><h5> $ 00.00 </h5></label>");
                }
            %>
            <br><br>
            
            <label>Disponibles: </label><br>
            <%
                if(actual!=null){
                    out.println("<label><h5> " + actual.getCantidad()+ "</h5></label>");
                }
                else{
                     out.println("<label><h5> $ 00.00 </h5></label>");
                }
            %><br><br>
            
            <label> Valoraci&oacute;n</label><br>
            <ul class="rating-stars">
                        <li style="width:<%out.println((actual.getValoracion()/5)*100+"%"); %>" class="stars-active"> 
                            <i class="fa fa-star"></i> <i class="fa fa-star"></i> 
                            <i class="fa fa-star"></i> <i class="fa fa-star"></i> 
                            <i class="fa fa-star"></i> 
                        </li>
                        <li>
                            <i class="fa fa-star"></i> <i class="fa fa-star"></i> 
                            <i class="fa fa-star"></i> <i class="fa fa-star"></i> 
                            <i class="fa fa-star"></i> 
                        </li>
                    </ul>
                            <br><br>
            
  <%
     HttpSession misession = request.getSession(true);
     Sesion userAct = (Sesion) misession.getAttribute("usuario");
     if(userAct != null){
        
         out.println("<button type=\"button\" class=\"btn btn-success\" data-toggle=\"modal\" data-target=\"#valoracionArticulo\"><i class=\"fas fa-star mx-1\"></i>Valorar </button>");
     }
   %>
</section>


<aside id="descripcion">

  <main role="main">

      <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
          <li data-target="#myCarousel" data-slide-to="3"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
              
              <% 
       if(actual != null){
        out.print("<img width=890 height=480 class=\"first-slide\" src=\"GetImagen?id=" + actual.getIdProducto() + "&tipo=1&num=1\" alt=\"First slide\">");
        
       } 
       else{
           
           out.print("<img width=890 height=480 class=\"first-slide\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==\" alt=\"First slide\">");
           
         
           
       }
      %>
            
            <div class="container">
              <div class="carousel-caption text-left">
      <% 
       if(actual != null){
         out.println("<h1>" + actual.getNombre()+"</h1>");
         out.println("<p>"+ actual.getDescripcion() +"</p>");
          if(userAct != null){
         out.println("<p><button id=\"addCarrito\" type=\"button\" onclick=\"agregarCarrito();\" class=\"btn btn-primary\"><i class=\"fas fa-cart-plus mx-1\"></i>Agregar a Carrito </button></p>");
     }
       } 
       else{
           out.println("<h1> PRODUCTO INEXISTENTE </h1>");
           out.println("<p> ... </p>");
           
       }
      %>
       
              

              </div>
            </div>
          </div>
          <div class="carousel-item">
                      <% 
       if(actual != null){
        out.print("<img width=890 height=480 class=\"second-slide\" src=\"GetImagen?id=" + actual.getIdProducto() + "&tipo=1&num=2\" alt=\"Second slide\">");
        
       } 
       else{
           
           out.print("<img width=890 height=480 class=\"second-slide\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==\" alt=\"Second slide\">");
           
         
           
       }
      %>
           
            <div class="container">
              <div class="carousel-caption">
                 <% 
       if(actual != null){
         out.println("<h1>" + actual.getNombre()+"</h1>");
         out.println("<p>"+ actual.getDescripcion() +"</p>");
          if(userAct != null){
            out.println("<p><button id=\"addCarrito\" type=\"button\"  onclick=\"agregarCarrito();\" class=\"btn btn-primary\"><i class=\"fas fa-cart-plus mx-1\"></i>Agregar a Carrito </button></p>");
          }
       } 
       else{
           out.println("<h1> PRODUCTO INEXISTENTE </h1>");
           out.println("<p> ... </p>");
           
       }
      %>
              </div>
            </div>
          </div>
          <div class="carousel-item">
                 <% 
       if(actual != null){
        out.print("<img width=890 height=480 class=\"third-slide\" src=\"GetImagen?id=" + actual.getIdProducto() + "&tipo=1&num=3\" alt=\"Third slide\">");
        
       } 
       else{
           
           out.print("<img width=890 height=480 class=\"third-slide\" src=\"data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==\" alt=\"third slide\">");
           
         
           
       }
      %>
            <div class="container">
              <div class="carousel-caption text-right">
                 <% 
       if(actual != null){
         out.println("<h1>" + actual.getNombre()+"</h1>");
         out.println("<p>"+ actual.getDescripcion() +"</p>");
         if(userAct != null){
            out.println("<p><button id=\"addCarrito\" type=\"button\" onclick=\"agregarCarrito();\" class=\"btn btn-primary\"><i class=\"fas fa-cart-plus mx-1\"></i>Agregar a Carrito </button></p>");
          }
       } 
       else{
           out.println("<h1> PRODUCTO INEXISTENTE </h1>");
           out.println("<p> ... </p>");
           
       }
      %>
              </div>
            </div>
          </div>
                   <div class="carousel-item">
                       <video class="fourth-slide" width="540" height="360" controls >
                            <% 
                                if(actual != null){
                                  out.println("<source src=\""+ actual.getRutaVideo() +"\" type=video/mp4>");
                                  
                                } 
                                else{
                                    out.println(" <source src=\"\">");
                                   

                                }
                               %>
                          
                       </video>
            <div class="container">
              <div class="carousel-caption">
                 <% 
       if(actual != null){
         out.println("<h1>" + actual.getNombre()+"</h1>");
         out.println("<p>"+ actual.getDescripcion() +"</p>");
       } 
       else{
           out.println("<h1> PRODUCTO INEXISTENTE </h1>");
           out.println("<p> ... </p>");
           
       }
      %>
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





    </main>
						</aside>
<section id="comentario">

Comentarios
<br>

    <input id="pdto"  name="pdtoId" type="hidden" value="<% if(actual!=null){out.print(actual.getIdProducto());}else{out.print("0");}%>" />
    
  <%
       
    
        if(userAct != null){
          out.println("<textarea style=\"resize: none; width: 80%;\" name=\"comenta\" id=\"comentarioProducto\"></textarea><br> <input class=\"btn btn-outline-success\" id=\"sendComent\" type=\"button\" name=\"Enviar\" value=\"Comentar\">");

        }
   
      %> 
    
<br><br>





<div id="CommentsDiv" class="overflow-auto" height="100">
  
    
</div>
</section>														
							



<footer id="limpia">

</footer>
     </div>
 </div>

      
      
      
      
      
      
<!-- Modal -->
<div class="modal fade" id="valoracionArticulo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                             <fieldset class="rating">
				    <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
				    <input type="radio" id="star4half" name="rating" value="4.5" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
				    <input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
				    <input type="radio" id="star3half" name="rating" value="3.5" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
				    <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
				    <input type="radio" id="star2half" name="rating" value="2.5" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
				    <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
				    <input type="radio" id="star1half" name="rating" value="1.5" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
				    <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
				    <input type="radio" id="starhalf" name="rating" value="0.5" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
				 </fieldset>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" onclick="valorarArticulo();">Guardar</button>
      </div>
    </div>
  </div>
</div>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    
   
    
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


  <script src="js/registro.js"></script>

  
  
  
  
  <script>
      
      $(document).ready(function(){
        leerComentarios();
        $("#categorias").hide();
    });
    
    
    $("#sendComent").click(function(){
        var usuario = document.getElementById("usuarioActual").value;
    var comentario = document.getElementById("comentarioProducto").value;
    var idProd = document.getElementById("pdto").value;
    
    var data = {
        usuario: usuario,
        comentario: comentario,
        producto: idProd
    };
    if(comentario === "" || comentario === null){
        alert('No puede enviarse un comentario vacío');
    }else{
         $.ajax({
				type: "post",
				url:"comentarProducto" ,
				data: data,
				beforesend: function(){
                                        
				},
				success: function(e){
                                   console.log(e);
                                  location.reload();
                                   value = e;
				}

	});
       
    }
    });
    
    
    function leerComentarios(){
        var idProd = getParameterByName("id");
        var data = {
            producto: idProd
        };
         $.ajax({
				type: "POST",
				url:"LeerComentarios" ,
                                datatype: "JSON",
				data: data,
				beforesend: function(){
                                         $("#CommentsDiv").html("");
				},
				success: function(e){
                                    var arr = e;
                                    var cad = "";
                                    
                                    for(var i = 0; i<arr.length; i++){
                                        
                                        cad += "<div class=\"card text-left\" style=\"font-size: 13px;\"><div style=\"background-color: #aaddff !important;\"><b>"+ arr[i].Comentario.nickname + "</b><small class=\"text-right\" style=\"margin-left: 6em;\">"+ arr[i].Comentario.fecha +"</small></div><div><i class=\"card-text\">"+arr[i].Comentario.comentario+"</i></div></div>";
                                        
                                        
                                        
                                        // console.log(arr[i].Comentario);
                                    }
                                  
                                    $("#CommentsDiv").html(cad);
                                  
				}

	});
    }
    
    function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
    results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
  
    
    
    
function valorarArticulo(){


		var producto = document.getElementById("pdto").value;
		var raiting = parseFloat($("input[name=rating]:checked").val());

               
		var parametros= {
			"idP" : producto,
			"estrellas" : raiting,
		};

		
	
		$.ajax({
                            data: parametros,
                            url: "ValorarArticulo",
                            type: "POST",
                            beforesend: function(){
						
						

                            },
                            success: function(response){
						
				console.log(parametros);	
				alert("¡Gracias por su compra!");
				location.reload();	
						
                            }		
                });
}


function agregarCarrito(){
      var usuario = document.getElementById("usuarioActual").value;
      var idProd = document.getElementById("pdto").value;
      var cantidad = 1;
      
      var datos = {
          usuario : usuario,
          producto : idProd,
          cantidad: cantidad
      };
      
      $.ajax({
          url: 'agregarACarrito',
          type: 'POST',
          data: datos,
          beforesend: function(){
             
          },
          success: function(e){
              
              alert('Agregado a la solicitud de presupuesto.');
              location.href="verCarrito?id=" + usuario;
          }
      });
    
}
</script>
  
</body>
</html>