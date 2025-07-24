<%@page import="java.util.List"%>
<%@page import="BusinessLogic.ServiciosBL"%>
<%@page import="BusinessEntify.ServiciosBE"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    ServiciosBL serviciosBL = new ServiciosBL();
    List<ServiciosBE> lista = serviciosBL.ReadAll();

    // Obtener el parámetro de categoría si existe
    String catId = request.getParameter("idCategoria");
    if (catId != null && !catId.isEmpty()) {
        int idCategoria = Integer.parseInt(catId);
        lista = serviciosBL.buscarPorCategoria(idCategoria);
    }

    // Convertir ImageIcon a Base64 para el JSP
    for (ServiciosBE servicio : lista) {
        if (servicio.getImagen() != null) {
            try {
                java.awt.image.BufferedImage bufferedImage = new java.awt.image.BufferedImage(
                        servicio.getImagen().getIconWidth(),
                        servicio.getImagen().getIconHeight(),
                        java.awt.image.BufferedImage.TYPE_INT_RGB);

                bufferedImage.getGraphics().drawImage(servicio.getImagen().getImage(), 0, 0, null);

                java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();
                javax.imageio.ImageIO.write(bufferedImage, "jpg", baos);
                String base64Image = Base64.getEncoder().encodeToString(baos.toByteArray());
                servicio.setImagenBase64(base64Image);
            } catch (Exception e) {
                System.out.println("Error al convertir imagen: " + e.getMessage());
            }
        }
    }

    request.setAttribute("serviciosList", lista);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Servicios de Diseño</title>
        <%@ include file="INCLUDE/header_links.jsp" %>
        <style>
            /* Estilos principales */
            .card-img-custom {
                height: 200px;
                object-fit: cover;
                width: 100%;
            }
            .card {
                transition: transform 0.3s;
                border: 1px solid rgba(0,0,0,0.1);
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            .price-tag {
                font-size: 1.2rem;
                font-weight: bold;
                color: #2c3e50;
            }
            .duration-badge {
                background-color: #3498db;
                color: white;
                font-size: 0.8rem;
            }
            .servicios-header {
                background: linear-gradient(135deg, #2c3e50, #3498db);
                color: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
            }
            .filter-card {
                border-radius: 10px;
                overflow: hidden;
            }
            .filter-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #eee;
                padding: 1rem;
            }

            /* Estilo para vista de lista */
            .list-view-container .col-md-6 {
                flex: 0 0 100%;
                max-width: 100%;
            }
            .list-view-container .card {
                flex-direction: row !important;
                height: auto;
            }
            .list-view-container .card-img-top {
                width: 250px;
                height: 200px;
                border-radius: 0;
            }
            .list-view-container .card-body {
                padding: 1.5rem;
            }
        </style>
    </head>

    <body>
        <%@ include file="INCLUDE/header.jsp" %>              

        <section class="py-4">
            <div class="container">
                <div class="row">
                    <!-- Sidebar de Filtros -->
                    <div class="col-lg-3 mb-4">
                        <div class="card filter-card shadow-sm">
                            <div class="filter-header">
                                <h5 class="mb-0"><i class="fas fa-filter me-2"></i>Filtrar Servicios</h5>
                            </div>
                            <div class="card-body">
                                <form method="GET" action="" id="filter-form">
                                    <!-- Filtro por Categoría -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Categoría</label>
                                        <select class="form-select" name="idCategoria" onchange="document.getElementById('filter-form').submit();">
                                            <option value="">Todas las categorías</option>
                                            <option value="1" <%= (request.getParameter("idCategoria") != null && request.getParameter("idCategoria").equals("1")) ? "selected" : ""%>>Diseño Arquitectónico</option>
                                            <option value="2" <%= (request.getParameter("idCategoria") != null && request.getParameter("idCategoria").equals("2")) ? "selected" : ""%>>Construcción</option>
                                            <option value="3" <%= (request.getParameter("idCategoria") != null && request.getParameter("idCategoria").equals("3")) ? "selected" : ""%>>Consultoría Inmobiliaria</option>
                                            <option value="4" <%= (request.getParameter("idCategoria") != null && request.getParameter("idCategoria").equals("4")) ? "selected" : ""%>>Remodelación</option>
                                            <option value="5" <%= (request.getParameter("idCategoria") != null && request.getParameter("idCategoria").equals("5")) ? "selected" : ""%>>Planos y Legalización</option>
                                        </select>
                                    </div>

                                    <!-- Filtro por Precio -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Rango de Precio (S/.)</label>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <input type="number" class="form-control" name="minPrice" 
                                                       placeholder="Mín" value="${param.minPrice}" step="0.01" min="0">
                                            </div>
                                            <div class="col-6">
                                                <input type="number" class="form-control" name="maxPrice" 
                                                       placeholder="Máx" value="${param.maxPrice}" step="0.01" min="0">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2 mt-3">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-check me-1"></i> Aplicar Filtros
                                        </button>
                                        <a href="?" class="btn btn-outline-secondary">
                                            <i class="fas fa-broom me-1"></i> Limpiar Filtros
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Lista de Servicios -->
                    <div class="col-lg-9">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="mb-1">Servicios Disponibles</h2>
                                <p class="text-muted mb-0">
                                    Mostrando <strong>${serviciosList.size()}</strong> servicios
                                    <% if (request.getParameter("idCategoria") != null) { %>
                                    en esta categoría
                                    <% }%>
                                </p>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-outline-secondary active grid-view-btn">
                                    <i class="fas fa-th-large"></i>
                                </button>
                                <button type="button" class="btn btn-outline-secondary list-view-btn">
                                    <i class="fas fa-list"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Grid de Servicios -->
                        <div class="row" id="servicios-container">
                            <c:forEach items="${serviciosList}" var="servicio">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100 shadow-sm">
                                        <div class="position-relative">
                                            <c:choose>
                                                <c:when test="${not empty servicio.imagenBase64}">
                                                    <img src="data:image/jpeg;base64,${servicio.imagenBase64}" 
                                                         class="card-img-top card-img-custom" 
                                                         alt="${servicio.nombre_servicio}"
                                                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/no-image.jpg'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/assets/images/no-image.jpg" 
                                                         class="card-img-top card-img-custom" 
                                                         alt="Imagen no disponible">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="position-absolute top-0 end-0 m-2">
                                                <span class="badge duration-badge">
                                                    <i class="fas fa-clock me-1"></i> ${servicio.duracion_estimada} días
                                                </span>
                                            </div>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title">${servicio.nombre_servicio}</h5>
                                            <p class="card-text flex-grow-1 text-muted">${servicio.descripcion}</p>
                                            <div class="mt-auto">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <span class="price-tag">S/. ${servicio.precio_base}</span>
                                                    <small class="text-muted">
                                                        <i class="fas fa-tag me-1"></i> 
                                                        <c:choose>
                                                            <c:when test="${servicio.id_categoria == 1}">Diseño</c:when>
                                                            <c:when test="${servicio.id_categoria == 2}">Construcción</c:when>
                                                            <c:when test="${servicio.id_categoria == 3}">Consultoría</c:when>
                                                            <c:when test="${servicio.id_categoria == 4}">Remodelación</c:when>
                                                            <c:when test="${servicio.id_categoria == 5}">Legalización</c:when>
                                                        </c:choose>
                                                    </small>
                                                </div>
                                                <div class="d-grid gap-2">
                                                    <a href="detalle_servicio.jsp?id=${servicio.id_servicio}" 
                                                       class="btn btn-outline-primary btn-sm">
                                                        <i class="fas fa-eye me-1"></i> Ver Detalles
                                                    </a>
                                                    <button class="btn btn-success btn-sm contratar-btn" 
                                                            data-id="${servicio.id_servicio}">
                                                        <i class="fas fa-cart-plus me-1"></i> Contratar
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Mensaje cuando no hay resultados -->
                        <c:if test="${empty serviciosList}">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle fa-2x mb-3"></i>
                                <h4>No se encontraron servicios</h4>
                                <p>Intenta con otros criterios de búsqueda</p>
                                <a href="?" class="btn btn-primary">Mostrar todos</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="INCLUDE/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
<!-- SweetAlert -->

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  // Función para agregar al carrito
  function agregarAlCarrito(servicioId) {
    fetch('agregarAlCarrito', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: 'servicioId=' + encodeURIComponent(servicioId)
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "ok") {
        // Actualiza o crea el contador del carrito
        let contador = document.getElementById("contadorCarrito");

        if (contador) {
          contador.textContent = data.totalItems;
        } else {
          // Si el contador no existe aún (porque no había ítems en la sesión)
          const carritoLink = document.querySelector(".fa-shopping-cart").parentNode;
          const badge = document.createElement("span");
          badge.id = "contadorCarrito";
          badge.className = "position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger";
          badge.innerHTML = `${data.totalItems}<span class="visually-hidden">productos en el carrito</span>`;
          carritoLink.appendChild(badge);
        }

        // SweetAlert de éxito
        Swal.fire({
          icon: 'success',
          title: 'Agregado al carrito',
          text: '¡El servicio se agregó correctamente!',
          showConfirmButton: false,
          timer: 1500
        });
      } else {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'No se pudo agregar al carrito.'
        });
      }
    })
    .catch(error => {
      console.error('Error:', error);
      Swal.fire({
        icon: 'error',
        title: 'Error de red',
        text: 'Inténtalo de nuevo más tarde.'
      });
    });
  }

  // Botones de contratación
  document.querySelectorAll(".contratar-btn").forEach(button => {
    button.addEventListener("click", function () {
      const servicioId = this.getAttribute("data-id");
      agregarAlCarrito(servicioId);
    });
  });
  

  // Vista de lista y grid
  document.querySelector('.grid-view-btn').addEventListener('click', function () {
    document.getElementById('servicios-container').classList.remove('list-view-container');
    document.querySelector('.grid-view-btn').classList.add('active');
    document.querySelector('.list-view-btn').classList.remove('active');
  });

  document.querySelector('.list-view-btn').addEventListener('click', function () {
    document.getElementById('servicios-container').classList.add('list-view-container');
    document.querySelector('.list-view-btn').classList.add('active');
    document.querySelector('.grid-view-btn').classList.remove('active');
  });
</script>

    </body>
</html>