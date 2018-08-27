 function   COSTFUNCTION_for_CLUSTERING= COST_ANT_V3_1(Path);
  global ProblemParams;

 N=ProblemParams.NODE.Number;
  No_INT= COST_INTERFRENCE(Path);

  COSTFUNCTION_for_CLUSTERING= 0.15*(No_INT)+0.85*(numel(Path)/N)
 

 
  
    
   
    

    
