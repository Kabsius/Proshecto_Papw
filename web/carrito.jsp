<%@page import="modelo.Producto"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>

  <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="js/registro.js"></script>
<link rel="stylesheet" type="text/css" href="css/estilo.css">
<link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">


 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <script src="js/bootstrap.min.js"></script>

	<title></title>
</head>
<body >

 <%@page import="java.io.PrintWriter"%>   
 <jsp:include page="header.jsp"/> 
    
 <div class="container" id="Form" style="min-height: 600px !important">
     
     <% 

    List<Producto> carritoDet = (List) request.getAttribute("detalles");
%>
     <div class="row">
         <div class="col-lg-12">
             <h4>Solicitud de Presupuesto (Cotización)</h4>
         </div>
     </div>
     <div class="row">
         <div class="col-lg-10">
             <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Item</th>
                            <th scope="col">Nombre</th>
                            <th scope="col" width="120">Cantidad</th>
                            <th scope="col"  width="50"></th>
                        </tr>
                    </thead>
                    <tbody id="tablaCarrito">
                        
                    <%
                        if(carritoDet!=null){
                            int var = 0;
                            for(Producto det : carritoDet)
                            {
                                var+=1;
                                String cot = "cot" + det.getIdProducto();
                                 String pres = "cot" + det.getIdPresupuesto();
                    %>
                    <tr id="<%= var %>">
                            <input type="hidden" name="" id="presCar" value="<%= det.getIdPresupuesto()%>">
                            <input type="hidden" name="" id="<%= cot %>" value="<%= det.getIdProducto()%>">
                            <td><img src="GetImagen?id=<%= det.getIdProducto() %>&tipo=1&num=1" alt="..." class="img-thumbnail" style="width: 90px; height: 90px !important;"></td>
                            <td><%= det.getNombre() %></td>
                            <td><input class="form-control" type="number" min="1" name="cantidad" id="cnt<%= det.getIdProducto()%>" value="<%= det.getCantidad()%>" onchange="editarCantidad(<%= det.getIdProducto()%>, <%= det.getIdPresupuesto()%>, this.id)"></td>
                            <td><button class="btn btn-block btn-danger" onclick="eliminarArticulo(<%= var %>,<%= det.getIdProducto()%>, <%= det.getIdPresupuesto()%>);"><i class="fas fa-trash-alt"></i> </button></td>
                        </tr>
                    <%
                            }
                        }
                    %>  
                        
                    </tbody>
             </table>
         </div>
         <div class="col-lg-2">
             <button type="button" class="btn btn-block btn-success" onclick="solicitarPresupuesto();" ><i class="fas fa-cash-register"></i> Presupuestar</button>
             <br>
             <button type="button" class="btn btn-block btn-danger"><i class="fas fa-trash-alt"></i> Vaciar</button>
         </div>
     </div>
     <div class="row">
         
     </div>
     
 </div>
 

<script>
      function eliminarArticulo(element, prod, compra){
          var rem = "#" + element;
          var prod = parseInt(prod);
          var compra = parseInt(compra);
          
          var data={
              compra: compra,
              producto: prod,
          };
          
         
          var confr = confirm('¿Desea eliminar el articulo de su carrito de compra?');

           if(confr===true){
               $.ajax({
                   url: 'eliminarProducto',
                   type: 'POST',
                   data: data,
                   beforesend: function(){
                       
                   },
                   success: function(e){
                       $(rem).remove();
                       location.reload();
                   }
               });
           }
      }
      
      function editarCantidad(prod, compra, idCbo){
          var prod = parseInt(prod);
          var compra = parseInt(compra);
          var id = "#" + idCbo;
          var cant = $(id).val();
          
          var data = {
              compra: compra,
              producto: prod,
              cantidad: cant
          };
          
          $.ajax({
                   url: 'UpdateCantidad',
                   type: 'POST',
                   data: data,
                   beforesend: function(){
                       
                   },
                   success: function(e){
                      
                       
                   }
               });
          
      }
      
      function solicitarPresupuesto(){
          var usuario = document.getElementById("usuarioActual").value;
          var compra = document.getElementById("presCar").value;
         
          var edo= 1;
          
          var data = {
              compra: compra,
              usuario: usuario,
              estatus: edo
          };
          
          $.ajax({
                   url: 'UpdateEstatus',
                   type: 'POST',
                   data: data,
                   beforesend: function(){
                       
                   },
                   success: function(e){
                      
                       alert("Revise Mis Cotizaciones --> Pressupuestos para ver más detalles.");
                       location.reload();
                   }
               });
           
      }
</script>



     

</body>
</html>