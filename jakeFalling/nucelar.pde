import java.net.InetAddress;
import java.util.Date;
import org.apache.commons.net.ntp.NTPUDPClient;
import org.apache.commons.net.ntp.TimeInfo;

/*
Paco Brevers
nucelar (because fuck it) 
Accede a un servidor de NTP y devuelve el delay de la llamada.
En caso de no poder acceder devuelve un random.
*/

public class nucelar {

  private float ruido;
  
  public static final String TIME_SERVER = "time-a.nist.gov";
  
  public nucelar() {
    ruido = round(random(5000));
  }
  
  public void hazRuido() {
    
    String TIME_SERVER = "time-a.nist.gov";   
    TimeTCPClient client = new TimeTCPClient();
    
    try {
      client.connect(TIME_SERVER);
      int lapso = millis();
      client.getTime();
      int lapsoFin = millis();
      this.ruido = map(lapsoFin-lapso, 0, 250, 0.1, 1.5);
    } catch (Exception e) {
      print("FOSTION al intentar acceder al NTP");
    } finally {
      try {
        client.disconnect();
      } catch (Exception e){
        print("Si llega aqui, detesto java aun mas");
      }
    }
  }
  
  public float getRuido(){
    return ruido;
  }
}