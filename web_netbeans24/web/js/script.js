document.addEventListener('DOMContentLoaded', function() {
  var myCarousel = document.getElementById('hero-carousel');
  var carousel = new bootstrap.Carousel(myCarousel, {
    interval: false // Desactiva el auto-desplazamiento inicial
  });
  
  // Función para avanzar automáticamente
  function autoAdvance() {
    carousel.next();
    setTimeout(autoAdvance, 6000); // 6 segundos
  }
  
  // Iniciar el auto-desplazamiento después de 3 segundos
  setTimeout(autoAdvance, 6000);
});