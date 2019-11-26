<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>


<script type="text/javascript" src="js/registro.js"></script>
<link rel="stylesheet" type="text/css" href="css/estilo.css">
<link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
	<title></title>
</head>
<body onload="iniciar();">

<button id="salir"><a href="Index">Regresar</a></button>

<form action="ServletRegistro" method="POST" enctype="multipart/form-data" id="Form">
<table>

<br>	

<td>
	<label>Nombre</label>
	<input  name="nombre" type="text" required="on" placeholder="Ingrese aqui su nombre" id="label" autofocus="on"  >
	<br>
</td>
<td>
	<label>Apellido Paterno</label>
	<input type="text" name="apellidoP" required="on" placeholder="Ingrese aqui su apellido" id="label"  >
	<br>
</td>

<td>
	<label>Apellido Materno</label>
	<input type="text" name="apellidoM" required="on" placeholder="Ingrese aqui su apellido" id="label"  >
	<br>
</td>

</table>
<table>
	<td>
	<label>Usuario</label>
	<input type="text" name="nombreUsuario" required="on" placeholder="Nombre de usuario" id="label1"  >
	
</td>
<td>
	<label>Password</label>
	<input type="password" name="passwordUsuario" required="on" placeholder="Password" id="label1"  >
</td>
<td>
	<label>Confirme Password</label>
	<input type="password" name="cpassword" required="on" placeholder="Confirme su password" id="label1"  >
	
</td>
</table>
<table>
<td>
	<label>Telefono de casa</label>
	<input type="text" name="telefono" chars="0-9" required="on" placeholder="Telefono" id="label" >
	<br>

</td>

<td>
	<label>Celular</label>
	<input type="text" name="celular" chars="0-9" required="on" placeholder="Celular" id="label" >
	<br>
</td>
</table>
<table>
<td>
	<LABEL>Correo electronico</LABEL>
	<input type="email" name="correo"  required="on" placeholder="ingrese su correo electronico" id="correo" >
	<br>
</td>
</table>
<table>
<td>
	<label>Imagen de perfil</label>
	<input type="file" name="imagen_usuario"  placeholder="Selecciona una imagen de perfil">
</td>
	<br>
</table>
    
<input type="hidden" name="presupuesto" chars="0-9" value="0" id="label" >
<input type="hidden" name="nivel" chars="0-9"   value="1" id="label" >

	<button type="submit" name="aceptar" id="boton">Registrar</button>


	<button type="reset" name="cancelar" id="boton">Cancelar</button>


</form
</body>
</html>