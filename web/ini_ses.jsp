<!DOCTYPE html>
<html>
<head>

		<script type="text/javascript" src="js/registro.js"></script>
	<link rel="stylesheet" type="text/css" href="css/estilo.css">
 <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
   <link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">

	<title></title>
</head>
<body onload="sesion();">
	<form method="POST" id="FORM" action="LoginUsuario">
		<br><br> <br> <br>
		<ol>
			<label id="label_se">Nombre de usuario</label>
		<input type="text" name="nombre" id="label_se" autofocus="on" placeholder="Ingrese su nombre de usuario" >
			<br>
			<label id="label_se">Password</label>
		<input type="password" name="password" id="label_se"  placeholder="Ingrese su password" >
			<br>
</ol>

	<button type="submit" name="aceptar" id="boton">Aceptar</button>


	<button class="btn-cancele" type="reset" name="cancelar" id="boton">Cancelar</button>
	
		
	</form>

    
    <script>
        $(".btn-cancele").click(function(){
            window.location="Index";
        });
    </script>
</body>
</html>