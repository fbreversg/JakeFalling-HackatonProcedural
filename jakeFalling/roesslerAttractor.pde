/** Todo el credito a https://www.openprocessing.org/sketch/47994 **/

public class roesslerAttractor extends discreteDynamicalSystem{
 public roesslerAttractor(){
  dimension=0;
  parameters=null;
 }
 public roesslerAttractor(float a, float b, float c){
  this.dimension=3;
  parameters=new float[]{a,b,c};
 }
 public float[] transitionFunction(float[] s){
  float x=-(s[1]+s[2]);
  float y=s[0]+parameters[0]*s[1];
  float z=parameters[1]+s[2]*(s[0]-parameters[2]);
  return new float[]{s[0]+0.01*x,s[1]+0.01*y,s[2]+0.01*z};
 }
 
 public void orbitDiagram(float[][] s0, int orbitIterations, float[] params){
  
 }
 
 public void bifurcationDiagram(float[] s0, int orbitIterations, int numberOfOrbits, float[] params){
  
 }
}