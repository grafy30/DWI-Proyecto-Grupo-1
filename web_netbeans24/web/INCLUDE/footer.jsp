<%-- 
    Document   : footer
    Created on : 1 may. 2025, 03:24:38
    Author     : DIEGO DAMIAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<footer class="footer">
  <div class="footer-container">
    <div class="footer-col">
      <h4>SERVICIO AL CLIENTE</h4>
      <ul>
        <li><a href="#">Términos y Condiciones</a></li>
        <li><a href="#">Libro de Reclamaciones</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>CONTÁCTANOS</h4>
      <ul>
        <li><a href="mailto:Drakell@gmail.com">Correo: Drakell@gmail.com</a></li>
        <li><a href="#">Dirección: Av. Perú 1234</a></li>
        <li><a href="#">Ubicación: Lima, Perú</a></li>
        <li><a href="#">Teléfono: +51 914088112</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>SÍGUENOS EN</h4>
      <div class="social-links">
        <a href="#"><img src="../imagenes/facebook.png" alt="Facebook" width="24"></a>
        <a href="#"><img src="../imagenes/instagram.png" alt="Instagram" width="24"></a>
        <a href="#"><img src="../imagenes/twitter.png" alt="Twitter" width="24"></a>
      </div>
    </div>
  </div>
</footer>

<style>
.footer {
  background-color: #222;
  color: #fff;
  padding: 40px 20px;
}

.footer-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 40px;
  max-width: 1200px;
  margin: 0 auto;
  text-align: center;
}

.footer-col {
  flex: 1 1 100%; /* Móvil: columna completa */
  max-width: 100%;
}

.footer h4 {
  margin-bottom: 20px;
}

.footer ul {
  list-style: none;
  padding: 0;
}

.footer a {
  color: #ccc;
  text-decoration: none;
}

.footer a:hover {
  text-decoration: underline;
  color: white;
}

.social-links a {
  margin: 0 10px;
  display: inline-block;
}

/* Tablet: 2 columnas */
@media (min-width: 600px) {
  .footer-col {
    flex: 1 1 45%;
    max-width: 45%;
  }
}

/* Escritorio: 3 columnas */
@media (min-width: 900px) {
  .footer-col {
    flex: 1 1 30%;
    max-width: 30%;
    text-align: left;
  }

  .footer-container {
    justify-content: space-between;
    text-align: left;
  }
}
</style>


