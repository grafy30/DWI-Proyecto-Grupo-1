package BusinessEntify;

import java.sql.Timestamp;

public class PagosBE {

    private int idPago;
    private int idServicioCliente;
    private double monto;
    private Timestamp fechaPago;
    private String metodo; // 'Efectivo', 'Transferencia', 'Tarjeta', 'Otro'
    private String estado; // 'Pendiente', 'Completado', 'Rechazado'
    private String comprobante;

    public PagosBE() {
    }

    public PagosBE(int idPago, int idServicioCliente, double monto, Timestamp fechaPago, String metodo, String estado, String comprobante) {
        this.idPago = idPago;
        this.idServicioCliente = idServicioCliente;
        this.monto = monto;
        this.fechaPago = fechaPago;
        this.metodo = metodo;
        this.estado = estado;
        this.comprobante = comprobante;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

    public int getIdServicioCliente() {
        return idServicioCliente;
    }

    public void setIdServicioCliente(int idServicioCliente) {
        this.idServicioCliente = idServicioCliente;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public Timestamp getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Timestamp fechaPago) {
        this.fechaPago = fechaPago;
    }

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getComprobante() {
        return comprobante;
    }

    public void setComprobante(String comprobante) {
        this.comprobante = comprobante;
    }
}
