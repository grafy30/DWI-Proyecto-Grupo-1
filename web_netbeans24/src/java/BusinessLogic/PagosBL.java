package BusinessLogic;

import BusinessEntify.PagosBE;
import DataAccessObject.PagosDAO;
import java.util.ArrayList;

public class PagosBL implements IBaseBL<PagosBE> {

    private final PagosDAO pagosDAO;

    public PagosBL() {
        this.pagosDAO = new PagosDAO();
    }

    @Override
    public boolean Create(PagosBE input) {
        return pagosDAO.Create(input);
    }

    @Override
    public PagosBE Read(String input) {
        return pagosDAO.Read(input);
    }

    @Override
    public ArrayList<PagosBE> ReadAll() {
        return pagosDAO.ReadAll();
    }

    @Override
    public boolean Update(PagosBE input) {
        return pagosDAO.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return pagosDAO.Delete(input);
    }
}
