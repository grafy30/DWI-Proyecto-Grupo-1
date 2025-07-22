package BusinessLogic;

import BusinessEntify.VentaContratoBE;
import DataAccessObject.VentaContratoDAO;
import java.util.ArrayList;

public class VentaContratoBL implements IBaseBL<VentaContratoBE>{
    
    private final VentaContratoDAO ventaDAO;
    
    //constructor

    public VentaContratoBL() {
        this.ventaDAO = new VentaContratoDAO();
    }
    
    //implementaciones

    @Override
    public boolean Create(VentaContratoBE input) {
        return ventaDAO.Create(input);
    }

    @Override
    public VentaContratoBE Read(String input) {
        return ventaDAO.Read(input);
    }

    @Override
    public ArrayList<VentaContratoBE> ReadAll() {
        return ventaDAO.ReadAll();
    }

    @Override
    public boolean Update(VentaContratoBE input) {
        return ventaDAO.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return ventaDAO.Delete(input);
    }        
}
