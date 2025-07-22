package services;

import BusinessEntify.ClientesBE;
import BusinessEntify.ServiciosBE;
import BusinessEntify.ServiciosClienteBE;
import BusinessEntify.VentaContratoBE;
import BusinessLogic.ServiciosBL;
import DataAccessObject.ClientesDAO;
import DataAccessObject.ServiciosClienteDAO;
import DataAccessObject.VentaContratoDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ContratarServicio", urlPatterns = {"/ContratarServicio"})
public class ContratarServicio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // 1. Obtener parámetros del formulario
            String idServicioStr = request.getParameter("idServicio");
            String nombreCompleto = request.getParameter("nombreCompleto");
            String email = request.getParameter("email");
            String telefono = request.getParameter("telefono");
            String fechaInicioStr = request.getParameter("fechaInicio");

            // 2. Validar entrada
            if (idServicioStr == null || idServicioStr.isEmpty()) {
                throw new Exception("ID de servicio no proporcionado");
            }

            int idServicio = Integer.parseInt(idServicioStr);
            Date fechaInicio = Date.valueOf(fechaInicioStr);

            if (fechaInicio.toLocalDate().isBefore(LocalDate.now())) {
                throw new Exception("La fecha de inicio no puede ser anterior a hoy");
            }

            // 3. Obtener información del servicio
            ServiciosBL serviciosBL = new ServiciosBL();
            ServiciosBE servicio = serviciosBL.Read(idServicioStr);
            if (servicio == null) {
                throw new Exception("Servicio no encontrado");
            }

            // 4. Validar sesión y obtener ID cliente
            HttpSession session = request.getSession();
            Integer idUsuario = (Integer) session.getAttribute("idUsuario");

            if (idUsuario == null) {
                session.setAttribute("datosContratacion", request.getParameterMap());
                response.sendRedirect("registro.jsp?from=contratacion");
                return;
            }

            // 5. Buscar cliente por ID de usuario
            ClientesDAO clienteDAO = new ClientesDAO();
            ClientesBE cliente = clienteDAO.findByUsuarioId(idUsuario);

            if (cliente == null) {
                throw new Exception("Cliente no encontrado para el usuario logueado");
            }

            int idCliente = cliente.getId_cliente();

            // 6. Crear objeto VentaContratoBE y registrar contrato de venta
            VentaContratoBE ventaContrato = new VentaContratoBE();
            ventaContrato.setNombre("Contrato de " + servicio.getNombre_servicio());
            ventaContrato.setDescripcion("Servicio contratado: " + servicio.getNombre_servicio());
            ventaContrato.setUbicacion("Por definir");
            ventaContrato.setFecha_inicio(fechaInicio);
            ventaContrato.setFecha_fin(null); // Se definirá más adelante
            ventaContrato.setEstado("Planificación");
            ventaContrato.setCliente_id(idCliente);
            ventaContrato.setPresupuesto(servicio.getPrecio_base());

            VentaContratoDAO ventaDAO = new VentaContratoDAO();
            boolean ventaCreada = ventaDAO.Create(ventaContrato);

            if (!ventaCreada) {
                throw new Exception("No se pudo crear el contrato de venta");
            }

            // NOTA: Para obtener el ID de la venta recién creada, necesitarías modificar 
            // el método Create en VentaContratoDAO para que retorne el ID generado
            // Por ahora, asumimos que se puede obtener de alguna manera
            // int idVentaGenerado = ventaContrato.getId_venta(); // Si el Create lo setea
            // 7. Registrar servicio_cliente con los nombres de campos correctos
            ServiciosClienteDAO servicioClienteDAO = new ServiciosClienteDAO();
            ServiciosClienteBE sc = new ServiciosClienteBE();

            // Usar los nombres de campos correctos según la tabla
            sc.setId_cliente(idCliente);
            sc.setId_servicio(idServicio);
            sc.setId_personal_asignado(null); // Se asignará más adelante
            // sc.setId_venta(idVentaGenerado); // Vincular con el contrato de venta
            sc.setFecha_inicio(fechaInicio); // Date, no String
            sc.setFecha_fin(null); // Se definirá más adelante
            sc.setEstado("Cotización"); // Valor del ENUM
            sc.setPrecio_final(servicio.getPrecio_base()); // Establecer precio inicial
            sc.setDetalles("Contratación inicial del servicio: " + servicio.getNombre_servicio());
            sc.setCalificacion(null); // Se establecerá después del servicio
            sc.setComentarios(null); // Se establecerá después del servicio
            // fecha_contratacion se establece automáticamente por la BD

            boolean creado = servicioClienteDAO.Create(sc);
            if (!creado) {
                throw new Exception("No se pudo registrar el servicio al cliente");
            }

            // 8. Redirigir a página de confirmación o pago
            response.sendRedirect("pago.jsp?idServicio=" + idServicio + "&idCliente=" + idCliente);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Formato de datos incorrecto");
            request.getRequestDispatcher("detalle-servicio.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al contratar servicio: " + e.getMessage());
            request.getRequestDispatcher("detalle-servicio.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para procesar contratación de servicios";
    }
}
