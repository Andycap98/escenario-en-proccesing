int jugadorX, jugadorY; // Posición del jugador
int jugadorTam = 20; // Tamaño del jugador
int velocidadJugador = 5; // Velocidad de movimiento del jugador
int puntaje = 0; // Puntaje del jugador

ArrayList<Pelota> pelotas; // Lista de pelotas

int numFilas = 5; // Número de filas de bloques
int numColumnas = 10; // Número de columnas de bloques
int bloqueAncho = 40; // Ancho del bloque
int bloqueAlto = 20; // Alto del bloque

void setup() {
  size(400, 600);
  jugadorX = width / 2;
  jugadorY = height - 50;
  pelotas = new ArrayList<Pelota>();
}

void draw() {
  background(135, 206, 250); // Cielo azul claro
  
  // Dibujar piso de bloques
  for (int fila = 0; fila < numFilas; fila++) {
    for (int columna = 0; columna < numColumnas; columna++) {
      int x = columna * bloqueAncho;
      int y = height - (fila * bloqueAlto) - bloqueAlto;
      fill(255, 165, 0); // Color naranja
      rect(x, y, bloqueAncho, bloqueAlto);
    }
  }
  
  // Dibujar jugador
  fill(0, 0, 255);
  rect(jugadorX, jugadorY, jugadorTam, jugadorTam);
  
  // Mover jugador con teclas del teclado
  if (keyPressed) {
    if (keyCode == LEFT) {
      jugadorX -= velocidadJugador;
    } else if (keyCode == RIGHT) {
      jugadorX += velocidadJugador;
    }
  }
  
  // Limitar movimiento del jugador dentro de la pantalla
  jugadorX = constrain(jugadorX, 0, width - jugadorTam);
  
  // Generar nuevas pelotas aleatoriamente
  if (frameCount % 30 == 0) {
    pelotas.add(new Pelota());
  }
  
  // Mover y dibujar pelotas
  for (int i = pelotas.size() - 1; i >= 0; i--) {
    Pelota pelota = pelotas.get(i);
    pelota.mover();
    pelota.mostrar();
    
    // Verificar colisión con el jugador
    if (pelota.colision(jugadorX, jugadorY, jugadorTam)) {
      gameOver();
    }
    
    // Eliminar pelotas fuera de la pantalla
    if (pelota.x > width || pelota.x < 0) {
      pelota.rebotar();
    }
    
    // Eliminar pelotas fuera de la pantalla
    if (pelota.y > height) {
      pelotas.remove(i);
      puntaje++;
    }
  }
  
  // Mostrar puntaje
  fill(0);
  textSize(20);
  text("Puntaje: " + puntaje, 10, 30);
  
  // Dibujar nubes (o estrellas) al azar en el cielo
  dibujarNubes();
}

void gameOver() {
  textSize(40);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/2);
  noLoop(); // Detener el bucle de dibujo
}

class Pelota {
  float x, y; // Posición de la pelota
  float diametro; // Diámetro de la pelota
  float velocidadX; // Velocidad horizontal de la pelota
  float velocidadY = 3; // Velocidad vertical de la pelota
  
  Pelota() {
    x = random(width);
    y = -20;
    diametro = random(20, 40);
    velocidadX = random(1, 3);
  }
  
  void mover() {
    x += velocidadX;
    y += velocidadY;
  }
  
  void rebotar() {
    velocidadX *= -1;
  }
  
  void mostrar() {
    // Aplicar tinte a la pelota
    tint(255, 0, 0); // Tinte rojo
    ellipse(x, y, diametro, diametro);
    noTint();
  }
  
  boolean colision(int px, int py, int tam) {
    float distancia = dist(x, y, px + tam/2, py + tam/2);
    return distancia < (diametro/2 + tam/2);
  }
}

void dibujarNubes() {
  // Dibujar nubes al azar en el cielo
  fill(255); // Color blanco para nubes
  noStroke();
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height/4); // Colocar nubes en la parte superior del cielo
    float tam = random(30, 60);
    ellipse(x, y, tam, tam);
  }
}
