package BusinessEntify;
public class CarouselBE {
    private int id_carusel;
    private String video;
    private String nombre;
    
    //Constructor
    public CarouselBE() {
    }
    
    //Getters and Setters

    public int getId_carusel() {
        return id_carusel;
    }

    public void setId_carusel(int id_carusel) {
        this.id_carusel = id_carusel;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }    
}
