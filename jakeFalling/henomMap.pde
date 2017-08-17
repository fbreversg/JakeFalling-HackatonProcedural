/** Todo el credito a https://www.openprocessing.org/sketch/47994 **/

public class henonMap extends discreteDynamicalSystem{

  public henonMap(){
  dimension=0;
  parameters=null;
 }
 public henonMap(float a, float b){
  this.dimension=2;
  parameters=new float[]{a,b};
 }
 public float[] transitionFunction(float[] s){
  float x=s[1]+1-parameters[0]*pow(s[0],2);
  float y=parameters[1]*s[0];
  return new float[]{x,y};
 }
 
 /*
  params[0]: x magnification parameter
  params[1]: y magnification parameter
  params[2]: xOffset
  params[3]: yOffset
 */
 public void orbitDiagram(float[][] s0, int orbitIterations, float[] params){
  pushMatrix();
  translate(params[2],params[3]);
  for(int i=0;i<s0.length;i++){
   float[][] orb=orbit(s0[i],orbitIterations);
   for(int j=0;j<orbitIterations;j++){
    point(orb[j][0]*params[0],orb[j][1]*params[1]);
   }
  }
  popMatrix();
 }
}