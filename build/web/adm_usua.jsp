<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
	    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/carousel.css" rel="stylesheet">
	<script src="js/registro.js"></script>
		<link rel="stylesheet" type="text/css" href="css/estilo.css">
                 
	<link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
	<title>indice</title>
</head>
<body onload="index();">

     <jsp:include page="header.jsp"/> 

							

<div class="row my-5">
    <div class="col-lg-3" id="categoria">
        


					<button id="boton" class="pptobtn" >Presupuestos</button>
					<br> <br>
					<button id="boton" class="nuevoProdbtn">Nuevo producto</button>
					<br> <br>
					<button id="boton" class="admn" >Productos agregados</button>
					<br> <br>
					
				
    </div>
     <div class="col-lg-9">
         

<aside id="ppto"  class="carrito" style="width: 90%;">
						
		<label>Presupuestos</label>	
							
		<table class="table table-sm">
                    <thead>
                      <tr class="bg-dark" style="color: #FFF">
                        <th scope="col">Usuario</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Estatus</th>
                        <th scope="col"></th>
                      </tr>
                    </thead>
                    <tbody id="listPresupuestos">

                    </tbody>
                </table>


</aside>

						
<form  method="POST"  action="NuevoProducto" enctype="multipart/form-data" id="producto" style="width: 90%;">
<table style="width: 90%; text-align: left;">


    
    
<br>	
<tr>
<td colspan="2">
	<label>Nombre</label>
	<input  class="form-control" name="nombreP" type="text" required placeholder="Ingrese aqui su nombre"  autofocus="on"  >
	<br>
</td>
</tr>

<tr>
<td colspan="2">
	<label>Descripcion</label>
	<input class="form-control" name="descP" type="text" required placeholder="Ingrese aqui su nombre"    >
	<br>
</td>
</tr>

<tr>
<td>
	<label>Precio</label>
	<input class="form-control" type="number" name="precioP" value=1.00  min="0.50" step="0.50" required   >
	<br>

</td>
<td>
	<label>Unidades</label>
	<input class="form-control" type="number" name="unidadesP" value=1  min="1" step="1" required >
	<br>

</td>
</tr>
<tr>
<td >
	<label>Oferta</label>
	<input class="form-control" type="number" name="ofertaP" value=1.00  min="0.50" step="0.50" required >
	<br>
        
</td>
<td >
	<label>Categoria</label>
        
         <jsp:useBean id="categoria" scope="page" class="modelo.cboCategorias"></jsp:useBean>
                                                    <%
                                                            ResultSet pList = categoria.categorias();
                                                            %>
        <select class="form-control" name="categoriaP">
            <option value="0" selected disabled>Seleccione una categoria</option>
            <%
                           while(pList.next()){
                                                                 %>
        <option value="<%= pList.getString("id_categoria") %>"> <%= pList.getString("categoria")%></option>
                                                                 <%
                                                                    }
                                                                %>
        </select>
	<br>
        
</td>
	</tr>
<tr>
<td colspan="2">
	<label>Imagen del Producto</label>
        <input class="form-control-file" type="file" name="foto" ><br>
        <input class="form-control-file" type="file" name="foto2" ><br>
        <input class="form-control-file" type="file" name="foto3" ><br>
        
</td>
	</tr>
 
<tr>
    <td colspan="2">
	<label>Video del Producto</label>
	<input class="form-control-file" type="file" name="videoP" required ><br>
        
</td>
</tr>
</table>
	<button  name="aceptar" id="boton" onclick="ver();" >Aceptar</button>


	<button type="reset" name="cancelar" id="boton">Cancelar</button>

</form>




	<aside id="productosAdministracion"  class="carrito" style="width: 90%;">
						
		<label>Administrar Productos</label>	
                <table class="table table-sm">
                    <thead>
                      <tr class="bg-dark" style="color: #FFF">
                        <th scope="col">Nombre</th>
                        <th scope="col">Categoria</th>
                        <th scope="col">Existencias</th>
                        <th scope="col">Opciones</th>
                      </tr>
                    </thead>
                    <tbody id="listaProductos">

                    </tbody>
                </table>
						
	</aside>

    </div>
</div>
							

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <script src="js/bootstrap.min.js"></script>


  <script src="js/registro.js"></script>
  
  <script>
      $(document).ready(function(){
           $("#productosAdministracion").hide();
            $("#producto").hide();
             $("#ppto").hide();
           
           
           
          $("button.admn").click(function(){
              $("#productosAdministracion").show();
              $("#producto").hide();
               $("#ppto").hide();
              productos();
          });
          
           $("button.nuevoProdbtn").click(function(){
              $("#productosAdministracion").hide();
               $("#producto").show();
               $("#ppto").hide();
              
          });
          
           $("button.pptobtn").click(function(){
               $("#productosAdministracion").hide();
               $("#producto").hide();
               $("#ppto").show();
               presupuestos();
          });
          
          
          
      });
      
      function productos(){
          $.ajax({
              url: 'Administracion',
              type: 'POST',
              dataType: 'json',
              beforesend: function(){
                   $("#listaProductos").html("");
              },
              success: function(e){
                  console.log(e);
                    $("#listaProductos").html("");
                  var cons = JSON.stringify(e);
                  var texto = "";
                  for(var a=0; a < e.length; a++){
                      texto+= "<tr><td>"+ e[a].articulo.nombre +"</td><td>"+  e[a].articulo.categoria  +"</td><td>"+  e[a].articulo.cantidad + "</td><td><a style=\"text-decoration: none;\" href=\"detalleProducto?id="+ e[a].articulo.idProducto +"\"><button type=\"button\" class=\"btn btn-info\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Ver detalles\"><i class=\"far fa-eye mx-2\"></i></button></a> &nbsp;&nbsp; <button type=\"button\" class=\"btn btn-danger\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Eliminar\" onclick=\"eliminarProducto("+ e[a].articulo.idProducto +");\"><i class=\"fas fa-minus-circle mx-2\"></i></button></td></tr>";
                  }
                  $("#listaProductos").append(texto);
              }
          });
      }
      
      function eliminarProducto(id){
          
          var idp = parseInt(id);
          var msg = confirm("¿Realmente desea eliminar el producto?");
          
          if(msg === true){
              var data = {idProd: idp};
              console.log(data);
              $.ajax({
                  url: 'BajaDeProducto',
                  type: 'POST',
                  data: data,
                  beforesend: function(){
                      
                  },
                  success: function(e){
                      alert("Se ha eliminado el producto!");
                      location.reload();
                  }
              });
          }
          
          
      }
     
     
      function presupuestos(){
          
          var data = {user: "1"};
          $.ajax({
              url: 'getPresupuestos',
              type: 'POST',
              data: data,
              dataType: 'json',
              beforesend: function(){
                   $("#listPresupuestos").html("");
              },
              success: function(e){
                   var cons = JSON.stringify(e);
                  console.log(e);
                    $("#listPresupuestos").html("");
                 // var cons = JSON.stringify(e);
                  var texto = "";
                  for(var a=0; a < e.length; a++){
                       var val = e[a].presupuesto.estado === "Rechazado" || e[a].presupuesto.estado === "Comprado" ? "disabled" : "";
                      texto+= "<tr><td>"+ e[a].presupuesto.usuario +"</td><td>"+  e[a].presupuesto.fecha  +"</td><td>"+  e[a].presupuesto.estado + "</td><td><button type=\"button\" class=\"btn btn-info\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Ver detalles\" onclick=\"detallesPresupuesto("+e[a].presupuesto.id + ");\"><i class=\"far fa-eye mx-2\"></i></button> &nbsp;&nbsp; <button type=\"button\" class=\"btn btn-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Editar\" onclick=\"editarPresupuesto("+ e[a].presupuesto.id +");\""+ val + "><i class=\"fas fa-edit mx-2\"></i></button></td></tr>";
                  } 
                  $("#listPresupuestos").append(texto);
              }
          });
      }
      
      
      
 function detallesPresupuesto(id){
     var idCompra = parseInt(id);
    var data = { compra: idCompra};
    $.ajax({
        url: 'DetallePresupuestoAdmin',
        method: 'POST',
        dataType: 'json',
        data: data,
        beforesend: function(){
           
        },
        success: function(e){
            console.log(e);
            var texto = "";
            $("#tablaPresupuestoDetalle").html("");
                  for(var a=0; a < e.length; a++){
                      texto+= "<tr><td>" + (a+1).toString() + "</td><td>" + e[a].producto.nombre + "</td><td>"+ e[a].producto.cantidad +"</td><td>"+ e[a].producto.precio+ "</td><td>"+ e[a].producto.total + "</td></tr> ";
                  }
                  
                  $("#tablaPresupuestoDetalle").append(texto);
             $("#detallePresupuesto").modal('show');
        }
    });

  }
  
   function editarPresupuesto(id){
     var idCompra = parseInt(id);
    var data = { compra: idCompra};
    $.ajax({
        url: 'DetallePresupuestoAdmin',
        method: 'POST',
        dataType: 'json',
        data: data,
        beforesend: function(){
           
        },
        success: function(e){
            console.log(e);
             $("#confirm").prop("disabled", false);
            var texto = "";
           // var idhidden = "<input type=hidden value=\""+ idCompra+"\" id=\"cActual\">";
            $("#tablaPresupuestoDetalleAdmin").html("");
                  for(var a=0; a < e.length; a++){
                      texto+=  "<tr><td>" + (a+1).toString() + "</td><td>" + e[a].producto.nombre + "</td><td>"+ e[a].producto.cantidad +"</td><td><input class=\"form-control\" type=number id=\"preP"+ e[a].producto.idProducto + "\" value=\""+ e[a].producto.precio+ "\"></td><td><button type=button class=\"btn btn-primary\" onclick=\"confirmarPpto(" + e[a].producto.idProducto + "," + idCompra+");\"><i class=\"fas fa-clipboard-check\"></i></button></td></tr> ";
                  }
                  
                  $("#tablaPresupuestoDetalleAdmin").append(texto);
                  $("#cActual").val(idCompra);
                  
             $("#detallePresupuestoAdmin").modal('show');
        }
    });

  }
  
  
  function ver(){
      
      
            console.log($("input[name=precioP").val());
       
  }
  
  
  function confirmarPpto(idProd, idPres){
     
      
       var compra = parseInt(idPres);
       var producto = parseInt(idProd);
       var idpre = "#preP" + idProd;
       var prec = parseInt($(idpre).val());
       
       var datos = {
           compra: compra,
           producto: producto,
           precio: prec
       };
       console.log(datos);
       $.ajax({
           url: 'ConfirmarPrecioPresupuesto',
           type: 'POST',
           data: datos,
           beforesend: function(){
               
           },
           success: function(e){
               alert(e);
           }
           
       });
      
  }
  
  
  
  function confirmarPresupuesto(){
        
          var compra = document.getElementById("cActual").value;
        
          var edo= 4;
          
          var data = {
              compra: compra,
          
              estatus: edo
          };
          
          $.ajax({
                   url: 'ConfirmarPresupuestoCompleto',
                   type: 'POST',
                   data: data,
                   beforesend: function(){
                       
                   },
                   success: function(e){
                      $("#confirm").attr("disabled", "true");
                       alert("Se ha confirmado el presupuesto para el cliente.");
                       
                   }
           });
}
  
  
  </script>

   <div class="modal fade" id="detallePresupuesto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Detalle de su compra</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="del" class="modal-body">
          <table class="table">
                <thead>
                  <tr>
                    <th scope="col">Part.</th>
                    <th scope="col">Descripcion</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Total</th>
                  </tr>
                </thead>
                <tbody id="tablaPresupuestoDetalle">   
                </tbody>
          </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        
      </div>
    </div>
  </div>
</div>
  
  
  
 <div class="modal fade" id="detallePresupuestoAdmin" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Confirmar Precios de Presupuesto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="del" class="modal-body" style="font-size: 13px !important;">
          <table class="table">
                <thead>
                  <tr>
                    <th scope="col">Part.</th>
                    <th scope="col">Descripcion</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio</th>
                     <th scope="col">Confirmar</th>
                    
                  </tr>
                </thead>
                <tbody id="tablaPresupuestoDetalleAdmin">   
                </tbody>
          </table>
      </div>
      <div class="modal-footer">
          <input type=hidden value="" id="cActual">
          <button type="button"  id="confirm" class="btn btn-primary" onclick="confirmarPresupuesto();">Confirmar presupuesto</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        
      </div>
    </div>
  </div>
</div>
 
  
</body>
</html>