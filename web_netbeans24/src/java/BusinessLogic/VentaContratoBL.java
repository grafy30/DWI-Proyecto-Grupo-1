package BusinessLogic;

import BusinessEntify.VentaContratoBE;
import DataAccessObject.VentaContratoDAO;
import java.util.ArrayList;

/**
 * Capa de lógica de negocio para gestionar contratos de venta.
 */
public class VentaContratoBL implements IBaseBL<VentaContratoBE> {

    private final VentaContratoDAO ventaDAO;

    /**
     * Constructor que inicializa la capa DAO correspondiente.
     */
    public VentaContratoBL() {
        this.ventaDAO = new VentaContratoDAO();
    }

    /**
     * Crea un nuevo contrato de venta.
     *
     * @param input Objeto VentaContratoBE con los datos a registrar.
     * @return true si se creó correctamente, false si ocurrió un error.
     */
    @Override
    public boolean Create(VentaContratoBE input) {
        return ventaDAO.Create(input);
    }

    /**
     * Lee un contrato de venta según su ID.
     *
     * @param input ID del contrato (en formato String).
     * @return Objeto VentaContratoBE con los datos encontrados, o null si no existe.
     */
    @Override
    public VentaContratoBE Read(String input) {
        return ventaDAO.Read(input);
    }

    /**
     * Devuelve una lista con todos los contratos registrados.
     *
     * @return Lista de objetos VentaContratoBE.
     */
    @Override
    public ArrayList<VentaContratoBE> ReadAll() {
        return ventaDAO.ReadAll();
    }

    /**
     * Actualiza un contrato de venta existente.
     *
     * @param input Objeto VentaContratoBE con los nuevos datos.
     * @return true si se actualizó correctamente, false en caso contrario.
     */
    @Override
    public boolean Update(VentaContratoBE input) {
        return ventaDAO.Update(input);
    }

    /**
     * Elimina un contrato de venta por ID.
     *
     * @param input ID del contrato a eliminar.
     * @return true si se eliminó correctamente, false en caso contrario.
     */
    @Override
    public boolean Delete(String input) {
        return ventaDAO.Delete(input);
    }
}
