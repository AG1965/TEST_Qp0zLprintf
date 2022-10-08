     H DFTACTGRP(*NO) BNDDIR('QC2LE')                                           
      
      *-------------------------------------------------------------------------
      * da machen wir eine Änderung online
      *-------------------------------------------------------------------------
      * Scott Klement https://www.scottklement.com/rpg/socktut/qrpglesrc.errno_h
     D sys_errno       PR              *   ExtProc('__errno')                   
                                                                                
     D strerror        PR              *   ExtProc('strerror')                  
     D    errnum                     10I 0 value                                
                                                                                
     D perror          PR                  ExtProc('perror')                    
     D    comment                      *   value options(*string)               
                                                                                
     D errno           PR            10I 0                                      
      *-------------------------------------------------------------------------
     D errStr          S            512A   VARYING                              
      *                                                                         
     D LF              C                   x'25'                                
      *                                                                         
     D Qp0zLprintf     PR            10I 0 EXTPROC('Qp0zLprintf')               
     D   formatString                  *   OPTIONS(*STRING)         VALUE       
     D   argument                      *   OPTIONS(*STRING:*NOPASS) VALUE       
     D   argument                      *   OPTIONS(*STRING:*NOPASS) VALUE       
     D   argument                      *   OPTIONS(*STRING:*NOPASS) VALUE       
     D   argument                      *   OPTIONS(*STRING:*NOPASS) VALUE       
     D   argument                      *   OPTIONS(*STRING:*NOPASS) VALUE       
     D   argument                      *   OPTIONS(*STRING:*NOPASS) VALUE       
      *                                                                         
     D rc              S                   LIKE(Qp0zLprintf)                    
                                                                                
         rc = Qp0zLprintf('%s' + LF:'Hello Joblog!');                           
         IF rc < 0;                                                             
           logError();                                                          
         ELSE;                                                                  
           logRC(rc);                                                           
         ENDIF;                                                                 
                                                                                
         rc = Qp0zLprintf('%s' + LF);                                           
         IF rc < 0;                                                             
           logError();                                                          
         ELSE;                                                                  
           logRC(rc);                                                           
         ENDIF;                                                                 
                                                                                
         rc = Qp0zLprintf('%s' + LF:*NULL);                                     
         IF rc < 0;                                                             
           logError();                                                          
         ELSE;                                                                  
           logRC(rc);                                                           
         ENDIF;                                                                 
                                                                                
         rc = Qp0zLprintf('Simon says "%s"' + LF:'Hello Joblog!');              
         IF rc < 0;                                                             
           logError();                                                          
         ELSE;                                                                  
           logRC(rc);                                                           
         ENDIF;                                                                 
                                                                                
         *INLR = *ON;                                                           

      *-------------------------------------------------------------------------
      * Scott Klement https://www.scottklement.com/rpg/socktut/qrpglesrc.errno_h
     P errno           B                                                        
     D errno           PI            10I 0                                      
     D p_errno         S               *                                        
     D wwreturn        S             10I 0 based(p_errno)                       
     C                   eval      p_errno = sys_errno()                        
     C                   return    wwreturn                                     
     P                 E                                                        
      *-------------------------------------------------------------------------
     P logError        B                                                        
     D                 PI                                                       
     D error           S             10I 0                                      
                                                                                
       error  = errno();                                                        
       IF 0 <> error;                                                           
         Qp0zLprintf('ERROR %s %s':%CHAR(error):%STR(strError(error)));         
       ENDIF;                                                                   
                                                                                
     P                 E                                                        
      *-------------------------------------------------------------------------
     P logRC           B                                                        
     D                 PI                                                       
     D   rc                          10I 0 CONST                                
                                                                                
         Qp0zLprintf('Wrote%2$s %1$s chars to the joblog' + LF:                 
                     %CHAR(rc) : ' exactly' );                                  
                                                                                
     P                 E                                                                                                                                                             
