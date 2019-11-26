<!DOCTYPE html>
<html>
<head>

	<script src="js/registro.js"></script>
		<link rel="stylesheet" type="text/css" href="css/estilo.css">

		    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="form-validation.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
	<title>indice</title>
</head>
<body onload="index();">
 <jsp:include page="header.jsp"/> 
 <div class="container-fluid">
     <div class="row">
         <div class="col-lg-12 my-2">.</div>
     </div>
 </div>
 
 <div class="container-fluid my-5">
				

							<footer id="limpia"></footer>


<section id="categoria">


    <button id="boton" class="histBtn" >Historial de Compras</button>
    <br><br>
    <button id="boton" class="preBtnC" >Presupuestos</button>
    <br> <br>
					
</section>

<aside id="historialCompras"  class="carrito">
    <div class="row my-3 center">
        <div class="col-12 text-center">
            <h4>Historial de Compras</h4>
        </div>
        <div class="col-1"></div>
        <div class="col-10 text-right">
            <h6>Buscar: <input  size="30" type="text" id="busquedaHistorial" name="buscHist" placeholder="Buscar..."> </h6>
        </div>
        <div class="col-1"></div>
    </div>
    <div class="row">
        <div class="col-1"></div>
        <div class="col-10">
            <table class="table table-sm">
                    <thead>
                      <tr class="bg-dark center" style="color: #FFF">
                        <th scope="col">ID</th>
                        <th scope="col">FECHA</th>
                        <th scope="col">TOTAL</th>
                        <th scope="col">PAGO</th>
                        <th scope="col">OPCIONES</th>
                      </tr>
                    </thead>
                    <tbody id="listHistorialC">

                    </tbody>
        </table>
        </div>
        <div class="col-1"></div>
    </div>
</aside>

<aside id="PresupuestosCliente"  class="carrito">
    <div class="row my-3 center">
        <div class="col-12 text-center">
            <h4>Presupuestos</h4>
        </div>
        <div class="col-1"></div>
        <div class="col-10 text-right">
            <h6>Buscar: <input  size="30" type="text" id="busquedaPres" name="buscHist" placeholder="Buscar..."> </h6>
        </div>
        <div class="col-1"></div>
    </div>
    <div class="row">
        <div class="col-1"></div>
        <div class="col-10">
            <table class="table table-sm">
                    <thead>
                      <tr class="bg-dark center" style="color: #FFF">
                        <th scope="col">ID</th>
                        <th scope="col">FECHA</th>
                        <th scope="col">ESTATUS</th>
                        <th scope="col">OPCIONES</th>
                      </tr>
                    </thead>
                    <tbody id="listPresupuestosC">

                    </tbody>
        </table>
        </div>
        <div class="col-1"></div>
    </div>
</aside>

						






 </div>



							
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/holder.min.js"></script>
    <script>
      // Example starter JavaScript for disabling form submissions if there are invalid fields
      (function() {
        'use strict';

        window.addEventListener('load', function() {
          // Fetch all the forms we want to apply custom Bootstrap validation styles to
          var forms = document.getElementsByClassName('needs-validation');

          // Loop over them and prevent submission
          var validation = Array.prototype.filter.call(forms, function(form) {
            form.addEventListener('submit', function(event) {
              if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add('was-validated');
            }, false);
          });
        }, false);
      })();
      
      
$(document).ready(function () {
    
    $("#PresupuestosCliente").hide();
    $('#historialCompras').hide();
    
    $("#boton.histBtn").click(function(){
         $("#PresupuestosCliente").hide();
         $('#historialCompras').show();
         historialCompras();
    });
    $("#boton.preBtnC").click(function(){
         $("#PresupuestosCliente").show();
          $('#historialCompras').hide();
          presupuestos();
    });
 
    (function ($) {
 
        $('#busquedaHistorial').keyup(function () {
 
             var rex = new RegExp($(this).val(), 'i');
 
             $('#listHistorial tr').hide();
 
             $('#listHistorial tr').filter(function () {
               return rex.test($(this).text());
             }).show();
 
        })
 
    }(jQuery));
    
    (function ($) {
 
        $('#busquedaPres').keyup(function () {
 
             var rex = new RegExp($(this).val(), 'i');
 
             $('#listPresupuestosC tr').hide();
 
             $('#listPresupuestosC tr').filter(function () {
               return rex.test($(this).text());
             }).show();
 
        })
 
    }(jQuery));
 
});



 function presupuestos(){
          var actualU = document.getElementById("usuarioActual").value;
          
          var data = {user: actualU};
          $.ajax({
              url: 'getPresupuestos',
              type: 'POST',
              data: data,
              dataType: 'json',
              beforesend: function(){
                   $("#listPresupuestosC").html("");
              },
              success: function(e){
                   var cons = JSON.stringify(e);
                  console.log(e);
                    $("#listPresupuestosC").html("");
                 // var cons = JSON.stringify(e);
                  var texto = "";
                  for(var a=0; a < e.length; a++){
                      var val = e[a].presupuesto.estado === "Rechazado" ? "disabled" : "";
                      var boton01 = "<button type=\"button\" onclick=\"detallesPresupuesto(" + e[a].presupuesto.id + ");\" class=\"btn btn-info\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Ver detalles\"><i class=\"far fa-eye mx-2\"></i></button>";
                      var boton02 = "&nbsp;&nbsp; <button type=\"button\" class=\"btn btn-success\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Comprar y pagar\" onclick=\"modalPago("+ e[a].presupuesto.id + ")\" "+ val + "><i class=\"fas fa-money-bill-wave mx-2\"></i></button>";
                      var boton03 = "&nbsp;&nbsp; <button type=\"button\" class=\"btn btn-danger\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Rechazar\"  onclick=\"rechazarPresupuesto("+ e[a].presupuesto.id +");\" "+ val + "><i class=\"fas fa-minus-circle mx-2\"></i></button>";
                      
                      texto+= "<tr><td>"+ e[a].presupuesto.id +"</td><td>"+  e[a].presupuesto.fecha  +"</td><td>"+  e[a].presupuesto.estado + "</td><td>"+boton01 + boton02 + boton03 +"</td></tr>";
                  } 
                  $("#listPresupuestosC").append(texto);
              }
          });
      }
      
function historialCompras(){
          var actualU = document.getElementById("usuarioActual").value;
          
          var data = {user: actualU};
          $.ajax({
              url: 'Historial',
              type: 'POST',
              data: data,
              dataType: 'json',
              beforesend: function(){
                   $("#listHistorialC").html("");
              },
              success: function(e){
                   var cons = JSON.stringify(e);
                  console.log(e);
                    $("#listHistorialC").html("");
                 // var cons = JSON.stringify(e);
                  var texto = "";
                  for(var a=0; a < e.length; a++){
                      
                      var boton01 = "<button type=\"button\" onclick=\"detalleCompra("+e[a].compra.id+");\" class=\"btn btn-info\" data-toggle=\"tooltip modal\" data-target=\"#detalleSuCompra\" data-placement=\"top\" title=\"Ver detalles\"><i class=\"far fa-eye mx-2\"></i></button>";
                      var boton02 = "&nbsp;&nbsp; <button type=\"button\" class=\"btn btn-success\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Comprar y pagar\" onclick=\"\"><i class=\"fas fa-money-bill-wave mx-2\"></i></button>";
                      var boton03 = "&nbsp;&nbsp; <button type=\"button\" class=\"btn btn-danger\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Rechazar\" onclick=\"rechazarPresupuesto("+ e[a].compra.id +")\"><i class=\"fas fa-minus-circle mx-2\"></i></button>";
                      
                      texto+= "<tr><td>"+ e[a].compra.id +"</td><td>"+  e[a].compra.fecha  +"</td><td> $  "+  e[a].compra.total + "</td><td>" +e[a].compra.formaPago  + "</td><td>"+boton01+"</td></tr>";
                  } 
                  $("#listHistorialC").append(texto);
              }
          });
}


function detalleCompra(id){
    var idCompra = parseInt(id);
    var data = { compra: idCompra};
    $.ajax({
        url: 'detalleCompra',
        method: 'POST',
        dataType: 'json',
        data: data,
        beforesend: function(){
           
        },
        success: function(e){
            console.log(e[0].producto.nombre);
            var texto = "";
            $("#tableDetalleCompra").html("");
                  for(var a=0; a < e.length; a++){
                      texto+= "<tr><td>" + (a+1).toString() + "</td><td>" + e[a].producto.nombre + "</td><td>"+ e[a].producto.cantidad +"</td><td>"+ e[a].producto.precio+ "</td><td>"+ e[a].producto.total + "</td></tr> ";
                  }
                  
                  $("#tableDetalleCompra").append(texto);
             $("#detalleSuCompra").modal('show');
        }
    });
}

function modalPago(id ){
     
     var compra = parseInt(id);
     $("#compraId").val(compra);
     $("#formaPago").modal("show");
}
function realizarCompra(){
    var pago = $("#formaPagoCbo").val();
    var compra = $("#compraId").val();
   
    console.log(pago);
    if(pago!=null || pago!= "0"){
        
         
       
          
          var data = {
              compra: compra,
              formaPag: pago
          };
          
          $.ajax({
                   url: 'RealizarCompra',
                   type: 'POST',
                   data: data,
                   beforesend: function(){
                         $("#formaPago").modal("hide");
                   },
                   success: function(e){
                       console.log(e);
                       location.reload();
                   }
           });
    }
    else{
        alert("DEBE SELECCIONAR UNA FORMA DE PAGO.");
        $("#formaPago").modal("show");
    }
}

function rechazarPresupuesto(id){
        var usuario = document.getElementById("usuarioActual").value;
          var compra = parseInt(id);
         
          var edo= 4;
          
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
                      
                       alert("Ha rechazado el presupuesto. Si desea recuperarlo, contacte al administrador del sistema.");
                       location.reload();
                   }
           });
}

function detallesPresupuesto(id){
     var idCompra = parseInt(id);
    var data = { compra: idCompra};
    $.ajax({
        url: 'detallePresupuestoCliente',
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


    </script>
    
    
    <div class="modal fade" id="detalleSuCompra" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                <tbody id="tableDetalleCompra">   
                </tbody>
          </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        
      </div>
    </div>
  </div>
</div>
    
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
    
    
    
  
    
  <div class="modal fade" id="formaPago" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Forma de Pago</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div id="del" class="modal-body">
          <select class="form-control" id="formaPagoCbo">
              <option value="0" selected disabled>Seleccione una opcion</option>
              <option value="Tarjeta de crédito">Tarjeta de crédito</option>
              <option value="Tarjeta de débito">Tarjeta de débito</option>
              <option value="Depósito">Depósito</option>
              <option value="Efectivo">Efectivo</option>
          </select>
          
          <input type="hidden" value="" id="compraId">
          
      </div>
      <div class="modal-footer">
          <button type="button" onclick="realizarCompra();" class="btn btn-success" >Realizar Compra</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        
      </div>
    </div>
  </div>
</div>
    
    
</body>
</html>