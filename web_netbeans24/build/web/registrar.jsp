<%-- 
    Document   : registrar
    Created on : 1 may. 2025, 23:49:43
    Author     : DIEGO DAMIAN
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #141414;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card-form {
            background-color: #1f1f1f;
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            color: white;
            box-shadow: 0px 0px 20px rgba(255, 0, 87, 0.5);
        }

        .form-label {
            color: #ffffff;
        }

        .form-control, .form-select {
            background-color: #333;
            border: none;
            color: white;
        }

        .form-control:focus, .form-select:focus {
            background-color: #444;
            color: white;
        }

        .btn-submit {
            background-color: #ff0057;
            border: none;
            width: 100%;
        }

        .btn-submit:hover {
            background-color: #e6004c;
        }
    </style>
</head>
<body>
    <div class="card-form">
        <h2 class="text-center mb-4">Registrarse</h2>
        <form action="${pageContext.request.contextPath}/registrar.jsp" method="post">
            <div class="mb-3">
                <label for="usuario" class="form-label">Usuario</label>
                <input type="text" class="form-control" id="usuario" name="usuario" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
                <label for="nombres" class="form-label">Nombres</label>
                <input type="text" class="form-control" id="nombres" name="nombres" required>
            </div>
            <div class="mb-3">
                <label for="edad" class="form-label">Edad</label>
                <input type="text" class="form-control" id="edad" name="edad" required>
            </div>
            <div class="mb-4">
                <label for="genero" class="form-label">Género</label>
                <select class="form-select" id="genero" name="genero" required>
                    <option value="Masculino">Masculino</option>
                    <option value="Femenino">Femenino</option>
                </select>
            </div>
            <button type="submit" class="btn btn-submit">Registrarse</button>
        </form>
    </div>
</body>
</html>
