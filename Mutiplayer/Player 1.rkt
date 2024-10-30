(require 2htdp/image)
(require 2htdp/universe)

;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;     ;;;;  ;;;;;; ;;;  ;;; ;;;;;;  ;;;;;     ;;    ;;;               ;;;;    ;;;  ;;;  ;;;  ;;; ;  ;;;;;;;   ;;   ;;;  ;;; ;;;;;;;  ;;; ; 
;    ;   ;   ;   ;  ;;   ;   ;   ;   ;   ;     ;     ;               ;   ;   ;   ;  ;;   ;  ;   ;;  ;  ;  ;    ;    ;;   ;  ;  ;  ; ;   ;; 
;   ;        ; ;    ; ;  ;   ; ;     ;   ;    ; ;    ;              ;       ;     ; ; ;  ;  ;          ;      ; ;   ; ;  ;     ;    ;      
;   ;        ;;;    ; ;  ;   ;;;     ;   ;    ; ;    ;              ;       ;     ; ; ;  ;   ;;;;      ;      ; ;   ; ;  ;     ;     ;;;;  
;   ;   ;;;  ; ;    ;  ; ;   ; ;     ;;;;     ; ;    ;              ;       ;     ; ;  ; ;       ;     ;      ; ;   ;  ; ;     ;         ; 
;   ;    ;   ;      ;  ; ;   ;       ;  ;     ;;;    ;   ;          ;       ;     ; ;  ; ;       ;     ;      ;;;   ;  ; ;     ;         ; 
;    ;   ;   ;   ;  ;   ;;   ;   ;   ;   ;   ;   ;   ;   ;           ;   ;   ;   ;  ;   ;;  ;;   ;     ;     ;   ;  ;   ;;     ;    ;;   ; 
;     ;;;   ;;;;;; ;;;  ;;  ;;;;;;  ;;;   ; ;;; ;;; ;;;;;;            ;;;     ;;;  ;;;  ;;  ; ;;;     ;;;   ;;; ;;;;;;  ;;    ;;;   ; ;;;  
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          

(define MAX-CHARS-HORIZONTAL 20)
(define MAX-CHARS-VERTICAL 15)
(define IMAGE-WIDTH 30)
(define IMAGE-HEIGHT 30)
(define MIN-IMG-X 0)
(define MAX-IMG-X (sub1 MAX-CHARS-HORIZONTAL))
(define MIN-IMG-Y 0)
(define MAX-IMG-Y (sub1 MAX-CHARS-VERTICAL))
(define E-SCENE-W (* MAX-CHARS-HORIZONTAL IMAGE-WIDTH)) ;; def & testing draw-last-world
(define E-SCENE-H (* MAX-CHARS-VERTICAL IMAGE-HEIGHT)) ;; def & testing draw-last-world
(define NO-SHOT 'no-shot)

;                                                                                                                                                  
;                                                                                                                                                  
;                                                                                                                                                  
;    ;;;;; ;;;  ;;;  ;;; ;  ;;;;;;  ;;;;;   ;;;;;;;           ;;;;  ;;;      ;;;;;  ;;;;;; ;;;  ;;; ;;;;;;;        ;;;  ;;;   ;;    ;;; ;;; ;;;;;; 
;      ;    ;;   ;  ;   ;;   ;   ;   ;   ;  ;  ;  ;          ;   ;   ;         ;     ;   ;  ;;   ;  ;  ;  ;         ;;   ;     ;     ;; ;;   ;   ; 
;      ;    ; ;  ;  ;        ; ;     ;   ;     ;            ;        ;         ;     ; ;    ; ;  ;     ;            ; ;  ;    ; ;    ;; ;;   ; ;   
;      ;    ; ;  ;   ;;;;    ;;;     ;   ;     ;            ;        ;         ;     ;;;    ; ;  ;     ;            ; ;  ;    ; ;    ; ; ;   ;;;   
;      ;    ;  ; ;       ;   ; ;     ;;;;      ;            ;        ;         ;     ; ;    ;  ; ;     ;            ;  ; ;    ; ;    ; ; ;   ; ;   
;      ;    ;  ; ;       ;   ;       ;  ;      ;            ;        ;   ;     ;     ;      ;  ; ;     ;            ;  ; ;    ;;;    ;   ;   ;     
;      ;    ;   ;;  ;;   ;   ;   ;   ;   ;     ;             ;   ;   ;   ;     ;     ;   ;  ;   ;;     ;            ;   ;;   ;   ;   ;   ;   ;   ; 
;    ;;;;; ;;;  ;;  ; ;;;   ;;;;;;  ;;;   ;   ;;;             ;;;   ;;;;;;   ;;;;;  ;;;;;; ;;;  ;;    ;;;          ;;;  ;;  ;;; ;;; ;;; ;;; ;;;;;; 
;                                                                                                                                                  
;                                                                                                                                                  
;                                                                                                                                                  
;                                                                                                                                                  

(define MY-NAME "Marco")
(define MY-COLOR 'red)

;                                                                                                  
;                                                                                                  
;                                                                                                  
;   ;;;;    ;;;;;     ;;    ;;; ;;;         ;;;;;;           ;;; ;    ;;;;  ;;;;;; ;;;  ;;; ;;;;;; 
;    ;  ;    ;   ;     ;     ;   ;           ;   ;          ;   ;;   ;   ;   ;   ;  ;;   ;   ;   ; 
;    ;   ;   ;   ;    ; ;    ;   ;           ; ;            ;       ;        ; ;    ; ;  ;   ; ;   
;    ;   ;   ;   ;    ; ;    ; ; ;           ;;;             ;;;;   ;        ;;;    ; ;  ;   ;;;   
;    ;   ;   ;;;;     ; ;    ; ; ;           ; ;    ;;;;;;       ;  ;        ; ;    ;  ; ;   ; ;   
;    ;   ;   ;  ;     ;;;    ; ; ;           ;                   ;  ;        ;      ;  ; ;   ;     
;    ;  ;    ;   ;   ;   ;   ; ; ;           ;   ;          ;;   ;   ;   ;   ;   ;  ;   ;;   ;   ; 
;   ;;;;    ;;;   ; ;;; ;;;   ; ;           ;;;;;;          ; ;;;     ;;;   ;;;;;; ;;;  ;;  ;;;;;; 
;                                                                                                  
;                                                                                                  
;                                                                                                  
;                                                                                                  

;; leaderboard scene -> scene
;; Purpose: Draw the leaderboard of how many points each person has in the given scene
(define SCORE (text "Score: " 20 'white))
(define NAME (text MY-NAME 20 MY-COLOR))
(define DASH (text "-" 20 'white))
(define INIT-SCORE 0)

(define leaderboard (place-image SCORE 250 30
                                 (place-image NAME 310 30
                                              (place-image DASH 350 30
                                                           (rectangle E-SCENE-W (* 1/8 E-SCENE-H) "solid" 'black)))))
(define E-SCENE (above . leaderboard))

;; Contants for INIT-WORLD
(define AN-IMG-X (/ MAX-CHARS-HORIZONTAL 2))
(define INIT-ROCKET  AN-IMG-X)
(define INIT-DIR  'right)
(define INIT-SHOT NO-SHOT)
(define NUM-ALIENS 18)
(define NUM-ALIEN-LINES 3)
(define ALIENS-PER-LINE (/ NUM-ALIENS NUM-ALIEN-LINES))
(define STARTING-X-LINE (add1 (/ (- MAX-CHARS-HORIZONTAL ALIENS-PER-LINE) 2)))
(define INIT-LOA (build-list NUM-ALIENS (λ (n) (make-posn (+ STARTING-X-LINE (remainder n ALIENS-PER-LINE))
                                                          (quotient n ALIENS-PER-LINE)))))
(define INIT-LOS '())

;; Contants for INIT-WORLD2 
(define INIT-ROCKET2 15)
(define INIT-ALIEN2 (make-posn 3 MAX-IMG-Y))
(define DIR2 'left)
(define SHOT2     (make-posn AN-IMG-X (/ (sub1 MAX-CHARS-VERTICAL) 2)))

;                                                                                                          
;                                                                                                          
;                                                                                                          
;     ;;    ;;;     ;;;     ;;; ;;;           ;;;;    ;;;  ;;;  ;;;  ;;; ;  ;;;;;;;   ;;   ;;;  ;;; ;;;;;;;
;      ;     ;       ;       ;   ;           ;   ;   ;   ;  ;;   ;  ;   ;;  ;  ;  ;    ;    ;;   ;  ;  ;  ;
;     ; ;    ;       ;        ; ;           ;       ;     ; ; ;  ;  ;          ;      ; ;   ; ;  ;     ;   
;     ; ;    ;       ;        ; ;           ;       ;     ; ; ;  ;   ;;;;      ;      ; ;   ; ;  ;     ;   
;     ; ;    ;       ;         ;            ;       ;     ; ;  ; ;       ;     ;      ; ;   ;  ; ;     ;   
;     ;;;    ;   ;   ;   ;     ;            ;       ;     ; ;  ; ;       ;     ;      ;;;   ;  ; ;     ;   
;    ;   ;   ;   ;   ;   ;     ;             ;   ;   ;   ;  ;   ;;  ;;   ;     ;     ;   ;  ;   ;;     ;   
;   ;;; ;;; ;;;;;;  ;;;;;;    ;;;             ;;;     ;;;  ;;;  ;;  ; ;;;     ;;;   ;;; ;;;;;;  ;;    ;;;  
;                                                                                                          
;                                                                                                          
;                                                                                                          
;                                                                                                          

(define-struct ally (rocket name score))

;; Sample instances of ally
(define INIT-ALLY  (make-ally INIT-ROCKET  MY-NAME INIT-SCORE))
(define INIT-ALLY2 (make-ally INIT-ROCKET2 MY-NAME INIT-SCORE))

;; lor is a (listof ally)
;; Sample instances of lor
(define INIT-ALLIES  (list INIT-ALLY))
(define INIT-ALLIES2 (list INIT-ALLY2))

;                                                                                                                  
;                                                                                                                  
;                                                                                                                  
;   ;;; ;;;   ;;;   ;;;;;   ;;;     ;;;;              ;;;;    ;;;  ;;;  ;;;  ;;; ;  ;;;;;;;   ;;   ;;;  ;;; ;;;;;;;
;    ;   ;   ;   ;   ;   ;   ;       ;  ;            ;   ;   ;   ;  ;;   ;  ;   ;;  ;  ;  ;    ;    ;;   ;  ;  ;  ;
;    ;   ;  ;     ;  ;   ;   ;       ;   ;          ;       ;     ; ; ;  ;  ;          ;      ; ;   ; ;  ;     ;   
;    ; ; ;  ;     ;  ;   ;   ;       ;   ;          ;       ;     ; ; ;  ;   ;;;;      ;      ; ;   ; ;  ;     ;   
;    ; ; ;  ;     ;  ;;;;    ;       ;   ;          ;       ;     ; ;  ; ;       ;     ;      ; ;   ;  ; ;     ;   
;    ; ; ;  ;     ;  ;  ;    ;   ;   ;   ;          ;       ;     ; ;  ; ;       ;     ;      ;;;   ;  ; ;     ;   
;    ; ; ;   ;   ;   ;   ;   ;   ;   ;  ;            ;   ;   ;   ;  ;   ;;  ;;   ;     ;     ;   ;  ;   ;;     ;   
;     ; ;     ;;;   ;;;   ; ;;;;;;  ;;;;              ;;;     ;;;  ;;;  ;;  ; ;;;     ;;;   ;;; ;;;;;;  ;;    ;;;  
;                                                                                                                  
;                                                                                                                  
;                                                                                                                  
;                                                                                                                  

;; A world is either
;;  1. 'uninitialized
;;  2. a structure: (make-world lor loa dir los)
(define-struct world (allies aliens dir shots ticks2shoot))
(define INIT-TTS 3)

(define INIT-WORLD  (make-world INIT-ALLIES  INIT-LOA  INIT-DIR  INIT-LOS INIT-TTS))
(define INIT-WORLD2 (make-world INIT-ALLIES2 (list INIT-ALIEN2) DIR2 (list SHOT2)INIT-TTS))
(define WORLD3 (make-world (list (make-ally 7 MY-NAME INIT-SCORE)) (list (make-posn 3 3)) 'right (list (make-posn 3 3))INIT-TTS))
(define UNINIT-WORLD 'uninitialized) 

;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;   ;;;;    ;;;;;     ;;    ;;; ;;;  ;;;;; ;;;  ;;;   ;;;;          ;;;;;;  ;;; ;;;;;;  ;;;   ;;;;  ;;;;;;;  ;;;;;    ;;;  ;;;  ;;;  ;;; ; 
;    ;  ;    ;   ;     ;     ;   ;     ;    ;;   ;   ;   ;           ;   ;   ;   ;  ;;   ;   ;   ;  ;  ;  ;    ;     ;   ;  ;;   ;  ;   ;; 
;    ;   ;   ;   ;    ; ;    ;   ;     ;    ; ;  ;  ;                ; ;     ;   ;  ; ;  ;  ;          ;       ;    ;     ; ; ;  ;  ;      
;    ;   ;   ;   ;    ; ;    ; ; ;     ;    ; ;  ;  ;                ;;;     ;   ;  ; ;  ;  ;          ;       ;    ;     ; ; ;  ;   ;;;;  
;    ;   ;   ;;;;     ; ;    ; ; ;     ;    ;  ; ;  ;   ;;;          ; ;     ;   ;  ;  ; ;  ;          ;       ;    ;     ; ;  ; ;       ; 
;    ;   ;   ;  ;     ;;;    ; ; ;     ;    ;  ; ;  ;    ;           ;       ;   ;  ;  ; ;  ;          ;       ;    ;     ; ;  ; ;       ; 
;    ;  ;    ;   ;   ;   ;   ; ; ;     ;    ;   ;;   ;   ;           ;       ;   ;  ;   ;;   ;   ;     ;       ;     ;   ;  ;   ;;  ;;   ; 
;   ;;;;    ;;;   ; ;;; ;;;   ; ;    ;;;;; ;;;  ;;    ;;;           ;;;       ;;;  ;;;  ;;    ;;;     ;;;    ;;;;;    ;;;  ;;;  ;;  ; ;;;  
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                                                                                                                            

;; world --> scene
;; Purpose: To draw the world in E-SCENE
(define (draw-world a-world)
  (local [;; Color Constants
          (define SHOT-COLOR 'darkyellow)
          (define ALIEN-COLOR 'lightgreen)
          (define WINDOW-COLOR 'red)
          (define FUSELAGE-COLOR2 'gold)
          (define FUSELAGE-COLOR 'skyblue)
          (define NACELLE-COLOR 'blue)

          ;; Rocket Constants
          (define ROCKET-Y (sub1 MAX-CHARS-VERTICAL))

          ;; Image Functions          
          ;; color --> image
          ;; Purpose: Create an alien image of the given color
          (define (mk-alien-img a-color)
            (overlay (text "W" 25 a-color) (circle (/ IMAGE-WIDTH 4) 'solid a-color)))

          (define ALIEN-IMG (mk-alien-img ALIEN-COLOR))

          ;; color --> image
          ;; Purpose: Create shot image of the given color
          (define (mk-shot-img a-color)
            (radial-star 4 (/ IMAGE-WIDTH 8) (/ IMAGE-WIDTH 2) 'solid  a-color))

          (define SHOT-IMG (mk-shot-img SHOT-COLOR))

          ;; color --> image
          ;; Purpose: Create the fuselage image of the given color
          (define (mk-fuselage-img a-color)
            (circle (* 1/3 IMAGE-HEIGHT) 'solid a-color))

          (define FUSELAGE  (mk-fuselage-img FUSELAGE-COLOR))
          (define FUSELAGE2 (mk-fuselage-img FUSELAGE-COLOR2))
          (define FUSELAGE-W (image-width FUSELAGE))
          (define FUSELAGE-H (image-width FUSELAGE))

          ;; color --> image
          ;; Purpose: Create rocket window image
          (define (mk-window-img a-color)
            (ellipse 3 10 'solid a-color))

          ;; Sample expressions for mk-window-img
          (define WINDOW  (mk-window-img WINDOW-COLOR))

          ;; color --> image
          ;; Purpose: Create single booster image
          (define (mk-single-booster-img a-color)
            (rotate 180 (triangle (/ FUSELAGE-W 2) 'solid a-color)))

          ;; image --> image
          ;; Purpose: Create booster image
          (define (mk-booster-img a-sb-img)
            (beside a-sb-img a-sb-img))

          (define SINGLE-BOOSTER  (mk-single-booster-img NACELLE-COLOR))
          (define BOOSTER (mk-booster-img SINGLE-BOOSTER))

          ;; image image image --> image
          ;; Purpose: Create the main rocket image
          (define (mk-rocket-main-img a-window a-fuselage a-booster)
            (place-image a-window
                         (/ (image-width a-fuselage) 2)
                         (/ (image-height a-fuselage) 4)
                         (above a-fuselage a-booster)))

          ;; Sample expressions for mk-rocket-main-img
          (define ROCKET-MAIN  (mk-rocket-main-img WINDOW FUSELAGE  BOOSTER))
          (define ROCKET-MAIN2 (mk-rocket-main-img WINDOW FUSELAGE2 BOOSTER))

          ;; image color --> image
          ;; Purpose: Create a rocket nacelle image
          (define (mk-nacelle-img a-rocket-main-img a-color)
            (rectangle (image-width a-rocket-main-img)
                       (/ (image-height a-rocket-main-img) 4)
                       'solid
                       a-color))

          ;; Sample expressions for mk-nacelle-img
          (define NACELLE (mk-nacelle-img ROCKET-MAIN NACELLE-COLOR))

          ;; image image --> ci
          ;; Purpose: Create a rocket ci
          (define (mk-rocket-ci a-rocket-main-img a-nacelle-img)
            (place-image a-nacelle-img
                         (/ (image-width  a-rocket-main-img) 2)
                         (* 0.7 (image-height a-rocket-main-img))
                         a-rocket-main-img))

          (define ROCKET-IMG  (mk-rocket-ci ROCKET-MAIN  NACELLE))
          (define ROCKET-IMG2 (mk-rocket-ci ROCKET-MAIN2 NACELLE)) ;;***

          ;; image image-x image-y image --> image
          ;; Purpose: Place the first given image in the seocond given image at the given image coordinates
          (define (draw-ci char-img an-img-x an-img-y scn)
            (local [;; image-x --> pixel-x
                    ;; Purpose: To translate the given image-x to a pixel-x
                    (define (image-x->pix-x ix)
                      (+ (* ix IMAGE-WIDTH) (/ IMAGE-WIDTH 2)))
                    
                    ;; image-y --> pixel-y
                    ;; Purpose: To translate the given image-y to a pixel-y
                    (define (image-y->pix-y iy)
                      (+ (* iy IMAGE-HEIGHT) (/ IMAGE-HEIGHT 2)))
                    
                    ;; image image-x image-y image --> image
                    ;; Purpose: Place the first given image in the seocond given image at the given image coordinates
                    (define (draw-ci char-img an-img-x an-img-y scn)
                      (place-image char-img (image-x->pix-x an-img-x) (image-y->pix-y an-img-y) scn))]
              (draw-ci char-img an-img-x an-img-y scn)))

          (define (accum base-val ffirst comb a-lox)
            (if (empty? a-lox)
                base-val
                (comb (ffirst (first a-lox))
                      (accum base-val ffirst comb (rest a-lox)))))

          (define (id x) x)
          
          ;; (listof X) image --> image
          ;; Purpose: To draw the given list in the given scene
          (define (draw-lox draw-x a-lox scn) (accum scn id draw-x a-lox))

          ;; (X image --> image) --> ((listof X) image ! image)
          ;; Purpose: Return a function to draw a (listof X)
          (define (draw-lox-maker draw-x)
            (λ (a-lox scn) (draw-lox draw-x a-lox scn)))

          ;; loa scene --> scene
          ;; Purpose: To draw the given loa in the given scene
          (define draw-loa (draw-lox-maker (λ (an-alien scn)
                                             (draw-ci ALIEN-IMG
                                                      (posn-x an-alien)
                                                      (posn-y an-alien)
                                                      scn))))
          
          ;; los scene --> scene
          ;; Purpose: To draw the given los in the given scene
          (define draw-los (draw-lox-maker (λ (a-shot scn)
                                             (if (eq? a-shot NO-SHOT)
                                                 scn
                                                 (draw-ci SHOT-IMG
                                                          (posn-x a-shot)
                                                          (posn-y a-shot)
                                                          scn)))))

;                                                                                  
;                                                                                  
;                                                                                  
;     ;;    ;;;     ;;;     ;;; ;;;         ;;; ;;;   ;;    ;;; ;;; ;;;;;;  ;;;;;  
;      ;     ;       ;       ;   ;           ;; ;;     ;     ;   ;   ;   ;   ;   ; 
;     ; ;    ;       ;        ; ;            ;; ;;    ; ;    ;  ;    ; ;     ;   ; 
;     ; ;    ;       ;        ; ;            ; ; ;    ; ;    ; ;     ;;;     ;   ; 
;     ; ;    ;       ;         ;             ; ; ;    ; ;    ;;;     ; ;     ;;;;  
;     ;;;    ;   ;   ;   ;     ;             ;   ;    ;;;    ;  ;    ;       ;  ;  
;    ;   ;   ;   ;   ;   ;     ;             ;   ;   ;   ;   ;   ;   ;   ;   ;   ; 
;   ;;; ;;; ;;;;;;  ;;;;;;    ;;;           ;;; ;;; ;;; ;;; ;;;  ;; ;;;;;;  ;;;   ;
;                                                                                  
;                                                                                  
;                                                                                  
;                                                                                  

          ;; image --> (rocket scene --> scene)
          ;; Purpose: Create a rocket drawing function
          (define (draw-ally-maker rocket-img)
            (local [ ;; rocket scene --> scene
                    ;; Purpose: To draw the rocket in the given scene
                    (define (draw-ally a-rocket a-scene)
                      (draw-ci rocket-img a-rocket ROCKET-Y a-scene))]
              draw-ally))
          ;; rocket scene --> scene
          ;; Purpose: To draw the rocket in the given scene
          (define draw-rocket (draw-ally-maker ROCKET-IMG))

          ;; rocket scene --> scene
          ;; Purpose: To draw the rocket in the given scene
          (define draw-ally (draw-ally-maker ROCKET-IMG2))
          
          ;; lor scene --> scene
          ;; Purpose: Draw the given allies in the given scene
          (define draw-allies
            (draw-lox-maker (λ (an-ally scn)
                              (if (string=? (ally-name an-ally) MY-NAME)
                                  (draw-rocket (ally-rocket an-ally) scn)
                                  (draw-ally   (ally-rocket an-ally) scn)))))

                                                                                                                                         
;                                                                                                                                  
;                                                                                                                                  
;   ;;;;    ;;;;;     ;;    ;;; ;;;         ;;;     ;;;;;;    ;;    ;;;;    ;;;;;;  ;;;;;   ;;;;;     ;;;     ;;    ;;;;;   ;;;;   
;    ;  ;    ;   ;     ;     ;   ;           ;       ;   ;     ;     ;  ;    ;   ;   ;   ;   ;   ;   ;   ;     ;     ;   ;   ;  ;  
;    ;   ;   ;   ;    ; ;    ;   ;           ;       ; ;      ; ;    ;   ;   ; ;     ;   ;   ;   ;  ;     ;   ; ;    ;   ;   ;   ; 
;    ;   ;   ;   ;    ; ;    ; ; ;           ;       ;;;      ; ;    ;   ;   ;;;     ;   ;   ;;;;   ;     ;   ; ;    ;   ;   ;   ; 
;    ;   ;   ;;;;     ; ;    ; ; ;           ;       ; ;      ; ;    ;   ;   ; ;     ;;;;    ;   ;  ;     ;   ; ;    ;;;;    ;   ; 
;    ;   ;   ;  ;     ;;;    ; ; ;           ;   ;   ;        ;;;    ;   ;   ;       ;  ;    ;   ;  ;     ;   ;;;    ;  ;    ;   ; 
;    ;  ;    ;   ;   ;   ;   ; ; ;           ;   ;   ;   ;   ;   ;   ;  ;    ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;  
;   ;;;;    ;;;   ; ;;; ;;;   ; ;           ;;;;;;  ;;;;;;  ;;; ;;; ;;;;    ;;;;;;  ;;;   ; ;;;;;     ;;;   ;;; ;;; ;;;   ; ;;;;   
;                                                                                                                                  
;                                                                                                                                  
;                                                                                                                                  
;

          ;; shot --> Boolean
          ;; Purpose: To determine if the given shot has hit the given alien
          (define (hit? a-shot an-alien)
            (and (posn? a-shot)
                 (= (posn-x a-shot) (posn-x an-alien))
                 (= (posn-y a-shot) (posn-y an-alien))))

           (define (if-hit-any? a-shot an-alien)
            (and (and (not (empty?
                           a-shot))(not (empty? an-alien)))
            (or (hit? (first a-shot) (first an-alien))    
            (if-hit-any? a-shot (rest an-alien)))))
          
          (define (update-lb a-los a-loa a-lor)
              (map (λ (an-ally)(if (if-hit-any? a-los a-loa)
            (make-ally (ally-rocket an-ally) (ally-name an-ally) (add1 (ally-score an-ally)))
            an-ally))a-lor))
          
          ;; score scene --> scene
          ;; Purpose: draw the score of the ally, goes up by 1 everytime they hit an alien
          (define (draw-score score scene)
            (place-image (text (number->string score) 20 'white) 370 480 scene))

;                                                                                  
;                                                                                  
;                                                                                  
;   ;;;;    ;;;;;     ;;    ;;; ;;;         ;;; ;;;   ;;;   ;;;;;   ;;;     ;;;;   
;    ;  ;    ;   ;     ;     ;   ;           ;   ;   ;   ;   ;   ;   ;       ;  ;  
;    ;   ;   ;   ;    ; ;    ;   ;           ;   ;  ;     ;  ;   ;   ;       ;   ; 
;    ;   ;   ;   ;    ; ;    ; ; ;           ; ; ;  ;     ;  ;   ;   ;       ;   ; 
;    ;   ;   ;;;;     ; ;    ; ; ;           ; ; ;  ;     ;  ;;;;    ;       ;   ; 
;    ;   ;   ;  ;     ;;;    ; ; ;           ; ; ;  ;     ;  ;  ;    ;   ;   ;   ; 
;    ;  ;    ;   ;   ;   ;   ; ; ;           ; ; ;   ;   ;   ;   ;   ;   ;   ;  ;  
;   ;;;;    ;;;   ; ;;; ;;;   ; ;             ; ;     ;;;   ;;;   ; ;;;;;;  ;;;;   
;                                                                                  
;                                                                                  
;                                                                                  
;                                                                                  
   
          ;; world --> scene
          ;; Purpose: To draw the world in E-SCENE
          ;; ASSUMPTION: The given world is a structure
          (define (draw-world a-world)
            (draw-los (world-shots a-world)
                      (draw-loa (world-aliens a-world)
                                (draw-score (ally-score(first(world-allies a-world)))
                                            (draw-allies (world-allies a-world)
                                                         E-SCENE
                                                         )))))]
    (if (eq? a-world UNINIT-WORLD)
        E-SCENE
        (draw-world a-world))))

;; Sample expressions for draw-world *** 
(define WORLD-SCN1  (if (eq? INIT-WORLD UNINIT-WORLD)
                        E-SCENE
                        (draw-world INIT-WORLD)))
(define WORLD-SCN2  (if (eq? UNINIT-WORLD UNINIT-WORLD)
                        E-SCENE
                        (draw-world UNINIT-WORLD)))                                         


;; Tests using sample computations for draw-world
(check-expect (draw-world INIT-WORLD)   WORLD-SCN1)
(check-expect (draw-world UNINIT-WORLD) WORLD-SCN2)

;                                                                                                                  
;                                                                                                                  
;                                                                                                                  
;   ;;; ;;; ;;;;;;  ;;; ;;;         ;;;;;   ;;;;;     ;;;     ;;;;  ;;;;;;   ;;; ;   ;;; ;   ;;;;; ;;;  ;;;   ;;;; 
;    ;   ;   ;   ;   ;   ;           ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;   ;;  ;   ;;     ;    ;;   ;   ;   ; 
;    ;  ;    ; ;      ; ;            ;   ;   ;   ;  ;     ; ;        ; ;    ;       ;          ;    ; ;  ;  ;      
;    ; ;     ;;;      ; ;            ;   ;   ;   ;  ;     ; ;        ;;;     ;;;;    ;;;;      ;    ; ;  ;  ;      
;    ;;;     ; ;       ;             ;;;;    ;;;;   ;     ; ;        ; ;         ;       ;     ;    ;  ; ;  ;   ;;;
;    ;  ;    ;         ;             ;       ;  ;   ;     ; ;        ;           ;       ;     ;    ;  ; ;  ;    ; 
;    ;   ;   ;   ;     ;             ;       ;   ;   ;   ;   ;   ;   ;   ;  ;;   ;  ;;   ;     ;    ;   ;;   ;   ; 
;   ;;;  ;; ;;;;;;    ;;;           ;;;     ;;;   ;   ;;;     ;;;   ;;;;;;  ; ;;;   ; ;;;    ;;;;; ;;;  ;;    ;;;  
;                                                                                                                  
;                                                                                                                  
;                                                                                                                  
;                                                                                                                  

;; world key --> world or package
;; Purpose: Process a key event to return next world
(define (process-key a-world a-key)
  (local [;; world key --> world
          ;; Purpose: Process a key event to return next world
          ;; ASSUMPTION: The given world is a structure
          (define (process-key a-world a-key)
            (cond [(or (or (key=? a-key "right")(key=? a-key "d"))(key=? a-key "left") (key=? a-key "a"))
                   (make-package a-world (list 'move a-key))]
                  [(and (or (key=? a-key " ")(key=? a-key "w"))
                        (eq? 0 (world-ticks2shoot a-world)))
                   (make-package a-world (list 'shoot))]                         
                  [else a-world]))]
    (if (eq? a-world UNINIT-WORLD)
        a-world
        (process-key a-world a-key))))

;; Tests using sample values for process-key
(check-expect (process-key (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                       (list (make-posn 7 2))
                                       'right
                                       '()INIT-TTS)
                           "right")
              (make-package (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                        (list (make-posn 7 2))
                                        'right
                                        '()INIT-TTS)
                            (list 'move "right")))

(check-expect (process-key (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                       (list (make-posn 7 2))
                                       'right
                                       '()INIT-TTS)
                           "left")
              (make-package (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                        (list (make-posn 7 2))
                                        'right
                                        '()INIT-TTS)
                            (list 'move "left")))

(check-expect (process-key (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                       (list (make-posn 7 2))
                                       'right
                                       '()0)
                           " ")
              (make-package (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                        (list (make-posn 7 2))
                                        'right
                                        '()0)
                            (list 'shoot)))

(check-expect (process-key (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                                       (list (make-posn 7 2))
                                       'right
                                       '()INIT-TTS)
                           " ")
              (make-world (list (make-ally 10 MY-NAME INIT-SCORE))
                          (list (make-posn 7 2))
                          'right
                          '()INIT-TTS))

;                                                                          
;                                                                          
;                                                                          
;     ;;;;    ;;    ;;; ;;; ;;;;;;            ;;;  ;;;  ;;; ;;;;;;  ;;;;;  
;    ;   ;     ;     ;; ;;   ;   ;           ;   ;  ;    ;   ;   ;   ;   ; 
;   ;         ; ;    ;; ;;   ; ;            ;     ; ;    ;   ; ;     ;   ; 
;   ;         ; ;    ; ; ;   ;;;            ;     ;  ;  ;    ;;;     ;   ; 
;   ;   ;;;   ; ;    ; ; ;   ; ;            ;     ;  ;  ;    ; ;     ;;;;  
;   ;    ;    ;;;    ;   ;   ;              ;     ;  ;  ;    ;       ;  ;  
;    ;   ;   ;   ;   ;   ;   ;   ;           ;   ;    ;;     ;   ;   ;   ; 
;     ;;;   ;;; ;;; ;;; ;;; ;;;;;;            ;;;     ;;    ;;;;;;  ;;;   ;
;                                                                          
;                                                                          
;                                                                          
;                                                                          
     
;; world --> Boolean
;; Purpose: Detect if the game is over
(define (game-over? a-world)
  (and (not (eq? a-world UNINIT-WORLD))
       (or (ormap (λ (an-alien) (= (posn-y an-alien) MAX-IMG-Y)) 
                  (world-aliens a-world))
           (empty? (world-aliens a-world)))))

;; Sample expressions for game-over? ***
(define GAME-OVER1 (and (not (eq? INIT-WORLD2 UNINIT-WORLD))
                        (or (ormap (λ (an-alien) (= (posn-y an-alien) MAX-IMG-Y)) 
                                   (world-aliens INIT-WORLD2))
                            (empty? (world-aliens INIT-WORLD2)))))
(define GAME-OVER2 (and (not (eq? WORLD3 UNINIT-WORLD))
                        (or (ormap (λ (an-alien) (= (posn-y an-alien) MAX-IMG-Y)) 
                                   (world-aliens WORLD3))
                            (empty? (world-aliens WORLD3)))))
(define GAME-NOT-OVER (and (not (eq? INIT-WORLD UNINIT-WORLD))
                           (or (ormap (λ (an-alien) (= (posn-y an-alien) MAX-IMG-Y)) 
                                      (world-aliens INIT-WORLD))
                               (empty? (world-aliens INIT-WORLD)))))
(define GAME-NOT-DONE (and (not (eq? UNINIT-WORLD UNINIT-WORLD))
                           (or (ormap (λ (an-alien) (= (posn-y an-alien) MAX-IMG-Y)) 
                                      (world-aliens UNINIT-WORLD))
                               (empty? (world-aliens UNINIT-WORLD)))))
    
;; Tests using sample computations for game-over? ***
(check-expect (game-over? INIT-WORLD2)  GAME-OVER1)
(check-expect (game-over? WORLD3)       GAME-OVER2)
(check-expect (game-over? INIT-WORLD)   GAME-NOT-OVER)
(check-expect (game-over? UNINIT-WORLD)  GAME-NOT-DONE)

;; Tests using sample values for game-over? ***
(check-expect (game-over? (make-world (list (make-ally 8 MY-NAME INIT-SCORE)) (list (make-posn 0 3)) 'right NO-SHOT INIT-TTS))
              #false)
(check-expect (game-over? (make-world (list (make-ally 8 MY-NAME INIT-SCORE)) (list (make-posn 0 MAX-IMG-Y)) 'right (list (make-posn 12 11))INIT-TTS))
              #true)
(check-expect (game-over? (make-world (list (make-ally 8 MY-NAME INIT-SCORE)) (list (make-posn 0 5)) 'right (list (make-posn 0 5))INIT-TTS))
              #false)

;                                                                                  
;                                                                                  
;                                                                                  
;   ;;;       ;;     ;;; ;  ;;;;;;;          ;;; ;    ;;;;  ;;;;;; ;;;  ;;; ;;;;;; 
;    ;         ;    ;   ;;  ;  ;  ;         ;   ;;   ;   ;   ;   ;  ;;   ;   ;   ; 
;    ;        ; ;   ;          ;            ;       ;        ; ;    ; ;  ;   ; ;   
;    ;        ; ;    ;;;;      ;             ;;;;   ;        ;;;    ; ;  ;   ;;;   
;    ;        ; ;        ;     ;                 ;  ;        ; ;    ;  ; ;   ; ;   
;    ;   ;    ;;;        ;     ;                 ;  ;        ;      ;  ; ;   ;     
;    ;   ;   ;   ;  ;;   ;     ;            ;;   ;   ;   ;   ;   ;  ;   ;;   ;   ; 
;   ;;;;;;  ;;; ;;; ; ;;;     ;;;           ; ;;;     ;;;   ;;;;;; ;;;  ;;  ;;;;;; 
;                                                                                  
;                                                                                  
;                                                                                  
;                                                                                  

;; world --> scene throws error
;; Purpose: To draw the game's final scene
(define (draw-last-world a-world)
  (cond [(ormap (lambda (an-alien) (= (posn-y an-alien) MAX-IMG-Y))
                (world-aliens a-world))
         (place-image (text "NO ONE WINS! :(" 36 'red)
                      (/ E-SCENE-W 2)
                      (/ E-SCENE-H 4)
                      (draw-world a-world))]
        [(empty? (world-aliens a-world))
         (place-image (text "GAME IS OVER! :)" 36 'green)
                      (/ E-SCENE-W 2)
                      (/ E-SCENE-H 4)
                      (draw-world a-world))]
        [else (error (format "draw-last-world: Given world has ~s aliens and none have reached earth."
                             (length (world-aliens a-world))))]))

;; Sample Instance of (final) world ***
(define FWORLD1 (make-world (list (make-ally 13 MY-NAME INIT-SCORE)) (list (make-posn  0 MAX-IMG-Y)) 'right INIT-LOS INIT-TTS))
(define FWORLD2 (make-world (list (make-ally 7  MY-NAME INIT-SCORE)) (list (make-posn 19 MAX-IMG-Y)) 'left (list (make-posn 2 4))INIT-TTS))
(define FWORLD3 (make-world (list (make-ally 7  MY-NAME INIT-SCORE)) '() 'left (list (make-posn 19 3))INIT-TTS))

;; Sample expressions for draw-last-world
(define FWORLD1-VAL (place-image
                     (text "NO ONE WINS! :(" 36 'red)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD1)))
(define FWORLD2-VAL (place-image
                     (text "NO ONE WINS! :(" 36 'red)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD2)))
(define FWORLD3-VAL (place-image
                     (text "GAME IS OVER! :)" 36 'green)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD3)))

;; Tests using sample computations for draw-last-world
(check-expect (draw-last-world FWORLD1) FWORLD1-VAL)
(check-expect (draw-last-world FWORLD2) FWORLD2-VAL)
(check-expect (draw-last-world FWORLD3) FWORLD3-VAL)

;; Tests using sample values for draw-last-world ***
(check-error (draw-last-world (make-world (list (make-ally 10 MY-NAME INIT-SCORE)) (list (make-posn 3 3) (make-posn 7 8)) 'right (list (make-posn 2 3))INIT-TTS))
             "draw-last-world: Given world has 2 aliens and none have reached earth.")

;                                                                                                          
;                                                                                                          
;                                                                                                          
;   ;;; ;;;;;;  ;;; ;;; ;;;   ;;    ;;;;;    ;;; ;  ;;; ;;;   ;;    ;;;     ;;;      ;;;;; ;;;  ;;;   ;;;; 
;    ;   ;  ;;   ;   ;; ;;     ;     ;   ;  ;   ;;   ;   ;     ;     ;       ;         ;    ;;   ;   ;   ; 
;    ;   ;  ; ;  ;   ;; ;;    ; ;    ;   ;  ;        ;   ;    ; ;    ;       ;         ;    ; ;  ;  ;      
;    ;   ;  ; ;  ;   ; ; ;    ; ;    ;   ;   ;;;;    ;;;;;    ; ;    ;       ;         ;    ; ;  ;  ;      
;    ;   ;  ;  ; ;   ; ; ;    ; ;    ;;;;        ;   ;   ;    ; ;    ;       ;         ;    ;  ; ;  ;   ;;;
;    ;   ;  ;  ; ;   ;   ;    ;;;    ;  ;        ;   ;   ;    ;;;    ;   ;   ;   ;     ;    ;  ; ;  ;    ; 
;    ;   ;  ;   ;;   ;   ;   ;   ;   ;   ;  ;;   ;   ;   ;   ;   ;   ;   ;   ;   ;     ;    ;   ;;   ;   ; 
;     ;;;  ;;;  ;;  ;;; ;;; ;;; ;;; ;;;   ; ; ;;;   ;;; ;;; ;;; ;;; ;;;;;;  ;;;;;;   ;;;;; ;;;  ;;    ;;;  
;                                                                                                          
;                                                                                                          
;                                                                                                          
;                                                                                                          

;; mw --> world
;; Purpose: Unmarshal the world in the given tpm
(define (unmarshal-world a-mw)
  (make-world (map (λ (rn) (make-ally (first rn) (second rn) (third rn)))(first a-mw))
              (map (λ (xy) (make-posn (first xy) (second xy))) (second a-mw))
              (third a-mw)
              (map (λ (xy) (make-posn (first xy) (second xy))) (fourth a-mw))
              (fifth a-mw)))

;; Sample instances of tpm
(define TPM1 (cons 'world
                   (list (list (list 10 "Marco Ponce" INIT-SCORE INIT-TTS))
                         (list (list 5  8))
                         'right
                         (list (list 12 4))INIT-TTS)))

(define TPM2 (cons 'world
                   (list (list (list 0 "Ponce" INIT-SCORE INIT-TTS))
                         (list (list 5 3))
                         'right
                         (list (list 7 7))INIT-TTS)))

;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;   ;;;;;   ;;;;;     ;;;     ;;;;  ;;;;;;   ;;; ;   ;;; ;          ;;; ;;; ;;;;;;   ;;; ;   ;;; ;    ;;      ;;;;  ;;;;;; 
;    ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;   ;;  ;   ;;           ;; ;;   ;   ;  ;   ;;  ;   ;;     ;     ;   ;   ;   ; 
;    ;   ;   ;   ;  ;     ; ;        ; ;    ;       ;                ;; ;;   ; ;    ;       ;         ; ;   ;        ; ;   
;    ;   ;   ;   ;  ;     ; ;        ;;;     ;;;;    ;;;;            ; ; ;   ;;;     ;;;;    ;;;;     ; ;   ;        ;;;   
;    ;;;;    ;;;;   ;     ; ;        ; ;         ;       ;           ; ; ;   ; ;         ;       ;    ; ;   ;   ;;;  ; ;   
;    ;       ;  ;   ;     ; ;        ;           ;       ;           ;   ;   ;           ;       ;    ;;;   ;    ;   ;     
;    ;       ;   ;   ;   ;   ;   ;   ;   ;  ;;   ;  ;;   ;           ;   ;   ;   ;  ;;   ;  ;;   ;   ;   ;   ;   ;   ;   ; 
;   ;;;     ;;;   ;   ;;;     ;;;   ;;;;;;  ; ;;;   ; ;;;           ;;; ;;; ;;;;;;  ; ;;;   ; ;;;   ;;; ;;;   ;;;   ;;;;;; 
;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;                                                                                                                          

;; world tpm --> world
;; Purpose: Update the world with the given tpm
(define (process-message a-world a-tpm)
  (unmarshal-world (rest a-tpm)))

;; Sample expressions for process-message
(define PM-TPM1 (unmarshal-world (rest TPM1)))
(define PM-TPM2 (unmarshal-world (rest TPM2)))

;; Tests using sample computations for process-message
(check-expect (process-message INIT-WORLD  TPM1) PM-TPM1)
(check-expect (process-message INIT-WORLD2 TPM2) PM-TPM2)

;; Tests using sample values for process-message
(check-expect (process-message WORLD3
                               (list
                                'world
                                (list (list 9 "Ponce" INIT-SCORE))
                                (list (list 7 2))
                                'left
                                '()INIT-TTS))
              (make-world (list (make-ally 9 "Ponce" INIT-SCORE))
                          (list (make-posn 7 2))
                          'left
                          '()INIT-TTS))

;                                                                                                  
;                                                                                                  
;                                                                                                  
;   ;;;;;   ;;; ;;;;;;  ;;;         ;;;;;;  ;;; ;;;;;;  ;;;   ;;;;  ;;;;;;;  ;;;;;    ;;;  ;;;  ;;;
;    ;   ;   ;   ;  ;;   ;           ;   ;   ;   ;  ;;   ;   ;   ;  ;  ;  ;    ;     ;   ;  ;;   ; 
;    ;   ;   ;   ;  ; ;  ;           ; ;     ;   ;  ; ;  ;  ;          ;       ;    ;     ; ; ;  ; 
;    ;   ;   ;   ;  ; ;  ;           ;;;     ;   ;  ; ;  ;  ;          ;       ;    ;     ; ; ;  ; 
;    ;;;;    ;   ;  ;  ; ;           ; ;     ;   ;  ;  ; ;  ;          ;       ;    ;     ; ;  ; ; 
;    ;  ;    ;   ;  ;  ; ;           ;       ;   ;  ;  ; ;  ;          ;       ;    ;     ; ;  ; ; 
;    ;   ;   ;   ;  ;   ;;           ;       ;   ;  ;   ;;   ;   ;     ;       ;     ;   ;  ;   ;; 
;   ;;;   ;   ;;;  ;;;  ;;          ;;;       ;;;  ;;;  ;;    ;;;     ;;;    ;;;;;    ;;;  ;;;  ;; 
;                                                                                                  
;                                                                                                  
;                                                                                                  
;                                                                                                  

; Z --> world
; Purpose: To run the game
(define (run MY-COLOR)
  (big-bang 
    UNINIT-WORLD
    [on-draw draw-world]
    [name MY-NAME]
    [on-key process-key]
    [stop-when game-over? draw-last-world]
    [register LOCALHOST]
    [on-receive process-message]))

(run MY-COLOR)
