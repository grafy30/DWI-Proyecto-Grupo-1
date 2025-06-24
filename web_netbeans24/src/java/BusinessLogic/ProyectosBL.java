package BusinessLogic;

import BusinessEntify.ProyectosBE;
import DataAccessObject.ProyectosDAO;
import java.util.ArrayList;

public class ProyectosBL implements IBaseBL<ProyectosBE> {

    private final ProyectosDAO proyectoDao;

    public ProyectosBL() {
        this.proyectoDao = new ProyectosDAO();
    }

    @Override
    public boolean Create(ProyectosBE input) {
        return proyectoDao.Create(input);
    }

    @Override
    public ProyectosBE Read(String input) {
        return proyectoDao.Read(input);
    }

    @Override
    public ArrayList<ProyectosBE> ReadAll() {
        return proyectoDao.ReadAll();
    }

    @Override
    public boolean Update(ProyectosBE input) {
        return proyectoDao.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return proyectoDao.Delete(input);
    }
}