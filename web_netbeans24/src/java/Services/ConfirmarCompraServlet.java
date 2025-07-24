package Services;

import BusinessEntify.VentaContratoBE;
import BusinessEntify.ClientesBE;
import BusinessEntify.ServiciosClienteBE;
import BusinessLogic.VentaContratoBL;

import java.io.IOException;
import java.util.Map;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/confirmarCompra")
public class ConfirmarCompraServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ClientesBE cliente = (ClientesBE) sesion.getAttribute("clienteLogueado");
        Map<Integer, Integer> carrito = (Map<Integer, Integer>) sesion.getAttribute("carrito");

        if (cliente == null || carrito == null || carrito.isEmpty()) {
            response.sendRedirect("verCarrito.jsp?error=1");
            return;
        }

        // Crear objeto contrato
        VentaContratoBE contrato = new VentaContratoBE();
        contrato.setCliente_id(cliente.getId_cliente()); // ✅ CORREGIDO
        contrato.setEstado("Pendiente");

        ArrayList<ServiciosClienteBE> listaServicios = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : carrito.entrySet()) {
            ServiciosClienteBE item = new ServiciosClienteBE();
            item.setId_servicio(entry.getKey());
            item.setCantidad(entry.getValue()); // Asegúrate de tener este método en tu BE
            listaServicios.add(item);
        }

        contrato.setServiciosClienteBE(listaServicios);

        // Guardar el contrato usando la capa BL
        VentaContratoBL contratoBL = new VentaContratoBL();
        boolean exito = contratoBL.Create(contrato);

        if (exito) {
            sesion.removeAttribute("carrito");
            response.sendRedirect("checkout.jsp?success=1");
        } else {
            response.sendRedirect("verCarrito.jsp?error=2");
        }
    }
}
