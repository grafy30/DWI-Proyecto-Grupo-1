package BusinessLogic;

import DataAccessObject.ServiciosDAO;
import BusinessEntify.ServiciosBE;
import java.util.List;

/**
 * Lógica de negocio para la gestión de servicios y pedidos de clientes.
 * Compatible con el DAO y con los procedimientos de servicios_functions.sql.
 */
public class ServiciosBL {

    private final ServiciosDAO serviciosDAO = new ServiciosDAO();

    // --- Operaciones para el catálogo de servicios ---

    // Agregar un nuevo servicio al catálogo
    public boolean agregarServicio(ServiciosBE servicio) {
        return serviciosDAO.createServicio(servicio);
    }

    // Obtener un servicio del catálogo por ID
    public ServiciosBE obtenerServicioPorId(int id) {
        return serviciosDAO.readServicioById(id);
    }

    // Listar todos los servicios del catálogo
    public List<ServiciosBE> listarServicios() {
        return serviciosDAO.readAllServicios();
    }

    // Actualizar un servicio del catálogo
    public boolean actualizarServicio(ServiciosBE servicio) {
        return serviciosDAO.updateServicio(servicio);
    }

    // Eliminar un servicio del catálogo
    public boolean eliminarServicio(int id) {
        return serviciosDAO.deleteServicio(id);
    }

    // --- Operaciones para pedidos de servicios de clientes ---

    // Registrar un pedido de servicio de un cliente (servicios_cliente)
    public boolean registrarPedidoServicio(ServiciosBE pedido) {
        return serviciosDAO.createPedidoServicio(pedido);
    }

    // Obtener un pedido de servicio por su ID (servicios_cliente)
    public ServiciosBE obtenerPedidoServicioPorId(int id) {
        return serviciosDAO.readPedidoServicioById(id);
    }

    // Listar todos los pedidos de servicios de clientes
    public List<ServiciosBE> listarPedidosServicios() {
        return serviciosDAO.readAllPedidosServicios();
    }

    // Actualizar pedido de servicio de un cliente
    public boolean actualizarPedidoServicio(ServiciosBE pedido) {
        return serviciosDAO.updatePedidoServicio(pedido);
    }

    // Eliminar un pedido de servicio (servicios_cliente)
    public boolean eliminarPedidoServicio(int id) {
        return serviciosDAO.deletePedidoServicio(id);
    }
}