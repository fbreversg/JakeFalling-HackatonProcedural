/** Todo el credito a https://www.openprocessing.org/sketch/47994 **/

public class logisticMap extends discreteDynamicalSystem{

  public logisticMap(){
  dimension=0;
  parameters=null;
 }
 public logisticMap(float lambda){
  this.dimension=1;
  parameters=new float[]{lambda};
 }
 public float[] transitionFunction(float[] s){
  return new float[]{parameters[0]*s[0]*(1-s[0])};
 }
 /*
 params: 
 params[0]: where from lambda parameter
 params[1]: where to lambdaParameter
 params[2]: xMagnification factor
 params[3]: yMagnification factor
 params[4]: minimal orbit point
 */
 public void bifurcationDiagram(float[] s0, int orbitIterations, int numberOfOrbits, float[] params){
  pushMatrix();
  translate(0,height);
  for(int i=0;i<numberOfOrbits;i++){
   float lambdaLambda=(float) i/(float) (numberOfOrbits-1);
   float l=params[0]*(1-lambdaLambda)+params[1]*lambdaLambda;
   setParameters(new float[]{l});
   float[][] orb=orbit(s0, orbitIterations);
   for(int j=round(orbitIterations*params[4]);j<orbitIterations;j++){
     point(lambdaLambda*params[2],-orb[j][0]*params[3]);
   }
  }
  popMatrix();
 }
 /*
 params[0]: x magnification factor
 params[1]: y magnification factor
 */
 public void orbitDiagram(float[][] s0, int orbitIterations, float[] params){
  for(int i=0;i<s0.length;i++){
   float[][] orb=orbit(s0[i],orbitIterations);
   beginShape();
   for(int j=0;j<orb.length;j++){
    float lambdaX=(float) j/(float) (orb.length-1);
    curveVertex(lambdaX*params[0],(orb[j][0]+s0[i][0])*params[1]);
   }
   endShape();
  }
 }
}