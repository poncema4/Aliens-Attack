(require 2htdp/image)
(require 2htdp/universe)

;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;                                                       ;                                                                                  
;     ;;;;    ;;;   ;;;       ;;;   ;;;;;    ;;; ;      ;   ;;;;;     ;;      ;;;;  ;;; ;;;   ;;;;  ;;;;;     ;;;   ;;; ;;;;;;  ;;; ;;;;   
;    ;   ;   ;   ;   ;       ;   ;   ;   ;  ;   ;;     ;     ;   ;     ;     ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;;   ;   ;  ;  
;   ;       ;     ;  ;      ;     ;  ;   ;  ;          ;     ;   ;    ; ;   ;        ;  ;   ;        ;   ;  ;     ;  ;   ;  ; ;  ;   ;   ; 
;   ;       ;     ;  ;      ;     ;  ;   ;   ;;;;     ;      ;;;;     ; ;   ;        ; ;    ;        ;   ;  ;     ;  ;   ;  ; ;  ;   ;   ; 
;   ;       ;     ;  ;      ;     ;  ;;;;        ;    ;      ;   ;    ; ;   ;        ;;;    ;   ;;;  ;;;;   ;     ;  ;   ;  ;  ; ;   ;   ; 
;   ;       ;     ;  ;   ;  ;     ;  ;  ;        ;   ;       ;   ;    ;;;   ;        ;  ;   ;    ;   ;  ;   ;     ;  ;   ;  ;  ; ;   ;   ; 
;    ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;;   ;   ;       ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;   ;;   ;  ;  
;     ;;;     ;;;   ;;;;;;    ;;;   ;;;   ; ; ;;;   ;       ;;;;;   ;;; ;;;   ;;;   ;;;  ;;   ;;;   ;;;   ;   ;;;     ;;;  ;;;  ;;  ;;;;   
;                                                   ;                                                                                      
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          

;; Video Game Image Dimensions
(define IMAGE-WIDTH 30)
(define IMAGE-HEIGHT 30)

;; Color Constants
(define SHOT-COLOR 'darkyellow)
(define ALIEN-COLOR 'lightgreen)
(define ALIEN2-COLOR 'yellow)
(define ALIEN3-COLOR 'red)
(define WINDOW-COLOR 'red)
(define FUSELAGE-COLOR 'skyblue)
(define NACELLE-COLOR 'blue)

;; E-SCENE Constants
(define MAX-CHARS-HORIZONTAL 20)
(define MAX-CHARS-VERTICAL 15)
(define E-SCENE-W (* MAX-CHARS-HORIZONTAL IMAGE-WIDTH))
(define E-SCENE-H (* MAX-CHARS-VERTICAL IMAGE-HEIGHT))
(define E-SCENE .)

;; Rocket Constants
(define ROCKET-Y (sub1 MAX-CHARS-VERTICAL))

;; Key Constants
(define RA-KEY "right")
(define LA-KEY "left")
(define O-KEY  "m")

;; Shot Constants
(define NO-SHOT 'no-shot)

;; Structure Definitions
(define-struct world (rocket aliens dir shots ticks2shoot))
(define-struct alien(x y health))

;; SAMPLE INSTANCES
(define AN-IMG-X (/ MAX-CHARS-HORIZONTAL 2))
(define MIN-IMG-X 0)
(define MAX-IMG-X (sub1 MAX-CHARS-HORIZONTAL))

(define AN-IMG-Y (/ MAX-CHARS-VERTICAL 2))
(define MIN-IMG-Y 0)
(define MAX-IMG-Y (sub1 MAX-CHARS-VERTICAL))

(define IMG-Y>MIN1 AN-IMG-Y)
(define IMG-Y>MIN2 MAX-IMG-Y)

(define INIT-ROCKET  AN-IMG-X)
(define INIT-ROCKET2 15)

;; Sample instances of key
(define KEY1 "right")
(define KEY2 "left")
(define KEY3 "up")
(define KEY4 " ")

(define ALIEN-HEALTH 3)
(define HEALTH-IS-0 0)
(define TTS 3)

(define HEALTH-0-ALIEN (make-alien 0 0 HEALTH-IS-0))
(define INIT-ALIEN (make-alien MAX-IMG-X 0 ALIEN-HEALTH))
(define INIT-ALIEN2 (make-alien 3 MAX-IMG-Y ALIEN-HEALTH))
(define ALIEN3 (make-alien 4 MAX-IMG-Y ALIEN-HEALTH))
(define LEFT-EDGE-ALIEN  (make-alien MIN-IMG-X 10 ALIEN-HEALTH))
(define RIGHT-EDGE-ALIEN (make-alien MAX-IMG-X 6 ALIEN-HEALTH))
(define ALIEN-8-0 (make-alien 8 0 ALIEN-HEALTH))

(define INIT-DIR  'right)
(define DIR2 'left)
(define DIR3 'down)

(define INIT-SHOT NO-SHOT)
(define SHOT2 (make-posn (/ MAX-CHARS-HORIZONTAL 2) (/ (sub1 MAX-CHARS-VERTICAL) 2)))
(define SHOT3 (make-posn 4 MAX-IMG-Y))
(define SHOT4 (make-posn 14 MIN-IMG-Y))

(define E-LOA '())
(define INIT-LOA (list (make-alien 8 0 ALIEN-HEALTH) (make-alien 9 0 ALIEN-HEALTH) (make-alien 10 0 ALIEN-HEALTH) (make-alien 11 0 ALIEN-HEALTH) (make-alien 12 0 ALIEN-HEALTH) (make-alien 13 0 ALIEN-HEALTH)
                       (make-alien 8 1 ALIEN-HEALTH) (make-alien 9 1 ALIEN-HEALTH) (make-alien 10 1 ALIEN-HEALTH) (make-alien 11 1 ALIEN-HEALTH) (make-alien 12 1 ALIEN-HEALTH) (make-alien 13 1 ALIEN-HEALTH)
                       (make-alien 8 2 ALIEN-HEALTH) (make-alien 9 2 ALIEN-HEALTH) (make-alien 10 2 ALIEN-HEALTH) (make-alien 11 2 ALIEN-HEALTH) (make-alien 12 2 ALIEN-HEALTH) (make-alien 13 2 ALIEN-HEALTH)))
(define EDGE-LOA  (list ALIEN-8-0  LEFT-EDGE-ALIEN (make-alien 5 5 ALIEN-HEALTH)))
(define EDGE-LOA2 (list (make-alien 1 11 ALIEN-HEALTH) RIGHT-EDGE-ALIEN))
(define EARTH-REACHED-LOA (list (make-alien 1 11 ALIEN-HEALTH) (make-alien MAX-IMG-X MAX-IMG-Y ALIEN-HEALTH)))
(define LOA3 (list (make-alien 1 9 ALIEN-HEALTH) (make-alien 8 0 ALIEN-HEALTH)))
(define LOA4 (list (make-alien 1 9 ALIEN-HEALTH) (make-alien 8 5 ALIEN-HEALTH)))
     
(define INIT-LOS '())
(define INIT-TTS 2)
(define LOS2 (list (make-posn 8 0) (make-posn 10 5)))

(define ALIEN-ATTACK (make-world INIT-ROCKET  INIT-LOA  INIT-DIR  INIT-LOS TTS))
(define WORLD3 (make-world 7 (list (make-alien 3 3 ALIEN-HEALTH)) 'right (list (make-alien 3 3 ALIEN-HEALTH))TTS))

;                                                                                                  
;                                                                                                  
;                                                                                                  
;                                                                                                  
;     ;;    ;;;      ;;;;;  ;;;;;; ;;;  ;;;          ;;;;;  ;;; ;;;   ;;      ;;;;  ;;;;;;   ;;; ; 
;      ;     ;         ;     ;   ;  ;;   ;             ;     ;; ;;     ;     ;   ;   ;   ;  ;   ;; 
;     ; ;    ;         ;     ; ;    ; ;  ;             ;     ;; ;;    ; ;   ;        ; ;    ;      
;     ; ;    ;         ;     ;;;    ; ;  ;             ;     ; ; ;    ; ;   ;        ;;;     ;;;;  
;     ; ;    ;         ;     ; ;    ;  ; ;             ;     ; ; ;    ; ;   ;   ;;;  ; ;         ; 
;     ;;;    ;   ;     ;     ;      ;  ; ;             ;     ;   ;    ;;;   ;    ;   ;           ; 
;    ;   ;   ;   ;     ;     ;   ;  ;   ;;             ;     ;   ;   ;   ;   ;   ;   ;   ;  ;;   ; 
;   ;;; ;;; ;;;;;;   ;;;;;  ;;;;;; ;;;  ;;           ;;;;;  ;;; ;;; ;;; ;;;   ;;;   ;;;;;;  ; ;;;  
;                                                                                                  
;                                                                                                  
;                                                                                                  
;                                                                                                  

;; color --> image
;; Purpose: Create an alien image of the given color
(define (mk-alien-img a-color)
  (overlay (text "W" 25 a-color) (circle (/ IMAGE-WIDTH 4) 'solid a-color)))

;; Alien magee depending on the health of the mk-alien-img
(define ALIEN-IMG (overlay (text "W" 25 ALIEN-COLOR) (circle (/ IMAGE-WIDTH 4) 'solid ALIEN-COLOR)))
(define ALIEN2-IMG (overlay (text "W" 25 ALIEN2-COLOR) (circle (/ IMAGE-WIDTH 4) 'solid ALIEN2-COLOR)))
(define ALIEN3-IMG (overlay (text "W" 25 ALIEN3-COLOR) (circle (/ IMAGE-WIDTH 4) 'solid ALIEN3-COLOR)))

;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          
;    ;;; ;  ;;; ;;;   ;;;   ;;;;;;;          ;;;;;  ;;; ;;;   ;;      ;;;;  ;;;;;;   ;;; ; 
;   ;   ;;   ;   ;   ;   ;  ;  ;  ;            ;     ;; ;;     ;     ;   ;   ;   ;  ;   ;; 
;   ;        ;   ;  ;     ;    ;               ;     ;; ;;    ; ;   ;        ; ;    ;      
;    ;;;;    ;;;;;  ;     ;    ;               ;     ; ; ;    ; ;   ;        ;;;     ;;;;  
;        ;   ;   ;  ;     ;    ;               ;     ; ; ;    ; ;   ;   ;;;  ; ;         ; 
;        ;   ;   ;  ;     ;    ;               ;     ;   ;    ;;;   ;    ;   ;           ; 
;   ;;   ;   ;   ;   ;   ;     ;               ;     ;   ;   ;   ;   ;   ;   ;   ;  ;;   ; 
;   ; ;;;   ;;; ;;;   ;;;     ;;;            ;;;;;  ;;; ;;; ;;; ;;;   ;;;   ;;;;;;  ; ;;;  
;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          

;; color --> image
;; Purpose: Create shot image of the given color
(define (mk-shot-img a-color)
  (radial-star 4 (/ IMAGE-WIDTH 8) (/ IMAGE-WIDTH 2) 'solid  a-color))

;; Shot image for mk-shot-img
(define SHOT-IMG (radial-star 4
                              (/ IMAGE-WIDTH 8)
                              (/ IMAGE-WIDTH 2)
                              'solid
                              SHOT-COLOR))

;                                                                                                          
;                                                                                                          
;                                                                                                          
;                                                                                                          
;   ;;;;;     ;;;     ;;;;  ;;; ;;; ;;;;;;  ;;;;;;;          ;;;;;  ;;; ;;;   ;;      ;;;;  ;;;;;;   ;;; ; 
;    ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;  ;  ;            ;     ;; ;;     ;     ;   ;   ;   ;  ;   ;; 
;    ;   ;  ;     ; ;        ;  ;    ; ;       ;               ;     ;; ;;    ; ;   ;        ; ;    ;      
;    ;   ;  ;     ; ;        ; ;     ;;;       ;               ;     ; ; ;    ; ;   ;        ;;;     ;;;;  
;    ;;;;   ;     ; ;        ;;;     ; ;       ;               ;     ; ; ;    ; ;   ;   ;;;  ; ;         ; 
;    ;  ;   ;     ; ;        ;  ;    ;         ;               ;     ;   ;    ;;;   ;    ;   ;           ; 
;    ;   ;   ;   ;   ;   ;   ;   ;   ;   ;     ;               ;     ;   ;   ;   ;   ;   ;   ;   ;  ;;   ; 
;   ;;;   ;   ;;;     ;;;   ;;;  ;; ;;;;;;    ;;;            ;;;;;  ;;; ;;; ;;; ;;;   ;;;   ;;;;;;  ; ;;;  
;                                                                                                          
;                                                                                                          
;                                                                                                          
;                                                                                                          

;; color --> image
;; Purpose: Create the fuselage image of the given color
(define (mk-fuselage-img a-color)
  (circle (* 1/3 IMAGE-HEIGHT) 'solid a-color))

;; Fuselage for mk-fuselage-img
(define FUSELAGE (circle (* 1/3 IMAGE-HEIGHT)
                         'solid
                         FUSELAGE-COLOR))

(define FUSELAGE-W (image-width FUSELAGE))
(define FUSELAGE-H (image-width FUSELAGE))

;; color --> image
;; Purpose: Create rocket window image
(define (mk-window-img a-color)
  (ellipse 3 10 'solid a-color))

;; Window for mk-window-img
(define WINDOW (ellipse 3 10 'solid WINDOW-COLOR))

;; color --> image
;; Purpose: Create single booster image
(define (mk-single-booster-img a-color)
  (rotate 180 (triangle (/ FUSELAGE-W 2) 'solid a-color)))

;; One booster for mk-single-booster-img
(define SINGLE-BOOSTER (rotate 180 (triangle (/ FUSELAGE-W 2) 'solid NACELLE-COLOR)))

;; image --> image
;; Purpose: Create booster image
(define (mk-booster-img a-sb-img)
  (beside a-sb-img a-sb-img))
(define BOOSTER (beside SINGLE-BOOSTER SINGLE-BOOSTER))

;; image image image --> image
;; Purpose: Create the main rocket image
(define (mk-rocket-main-img a-window a-fuselage a-booster)
  (place-image a-window
               (/ (image-width a-fuselage) 2)
               (/ (image-height a-fuselage) 4)
               (above a-fuselage a-booster)))

;; Main rocket body for mk-rocket-main-img
(define ROCKET-MAIN (place-image WINDOW
                                 (/ (image-width FUSELAGE) 2)
                                 (/ (image-height FUSELAGE) 4)
                                 (above FUSELAGE BOOSTER)))

;; image color --> image
;; Purpose: Create a rocket nacelle image
(define (mk-nacelle-img a-rocket-main-img a-color)
  (rectangle (image-width a-rocket-main-img)
             (/ (image-height a-rocket-main-img) 4)
             'solid
             a-color))

;; Nacelle for mk-nacelle-img
(define NACELLE (rectangle (image-width ROCKET-MAIN)
                           (/ (image-height ROCKET-MAIN) 4)
                           'solid
                           NACELLE-COLOR))

;; image image --> ci
;; Purpose: Create a rocket ci
(define (mk-rocket-ci a-rocket-main-img a-nacelle-img)
  (place-image a-nacelle-img
               (/ (image-width  a-rocket-main-img) 2)
               (* 0.7 (image-height a-rocket-main-img))
               a-rocket-main-img))

(define ROCKET-IMG (place-image NACELLE
                                (/ (image-width  ROCKET-MAIN) 2)
                                (* 0.7 (image-height ROCKET-MAIN))
                                ROCKET-MAIN))

;                                                                                                                                          
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

;; image-x --> pixel-x
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
  (place-image char-img (image-x->pix-x an-img-x) (image-y->pix-y an-img-y) scn))

;; alien scene --> scene
;; Purpose: Draw the given alien in the given scene
(define (draw-alien an-alien scn)
  (cond [(= (alien-health an-alien) 3)(draw-ci ALIEN-IMG (alien-x an-alien)
                                               (alien-y an-alien)
                                               scn)]
        [(= (alien-health an-alien) 2)(draw-ci ALIEN2-IMG (alien-x an-alien)
                                               (alien-y an-alien)
                                               scn)]
        [else (draw-ci ALIEN3-IMG (alien-x an-alien)
                       (alien-y an-alien) scn)]))

;; rocket --> scene
;; Purpose: To draw the rocket in the given scene
(define (draw-rocket a-rocket a-scene)
  (draw-ci ROCKET-IMG a-rocket ROCKET-Y a-scene))
                            
;; shot scene --> scene
;; Purpose: To draw the shot in the given scene
(define (draw-shot a-shot scn)
  (if (eq? a-shot NO-SHOT)
      scn
      (draw-ci SHOT-IMG (posn-x a-shot) (posn-y a-shot) scn)))

;; loa scene --> scene
;; Purpose: To draw the given loa in the given scene
(define (draw-loa a-loa scn)
  (if (empty? a-loa)
      scn
      (draw-alien (first a-loa) (draw-loa (rest a-loa) scn))))

;; los scene --> scene
;; Purpose: To draw the given los in the given scene
(define (draw-los a-los scn)
  (if (empty? a-los)
      scn
      (draw-shot (first a-los)
                 (draw-los (rest a-los) scn))))

;; world --> scene
;; Purpose: To draw the world in E-SCENE
(define (draw-world a-world)
  (draw-los (world-shots a-world)
            (draw-loa (world-aliens a-world)
                      (draw-rocket (world-rocket a-world)
                                   E-SCENE))))

;                                                                                                                          
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

;; rocket --> rocket
;; Purpose: Move the given rocket right
(define (move-rocket-right a-rocket)
  (if (< a-rocket 17)
      (+ 3 a-rocket)
      (modulo a-rocket 3)))

;; rocket --> rocket
;; Purpose: Move the given rocket left
(define (move-rocket-left a-rocket)
  (if (> a-rocket 2)
      (- a-rocket 3)
      (- (sub1 MAX-CHARS-HORIZONTAL)(modulo a-rocket 3))))

;; shot rocket --> shot
;; Purpose: To create a new shot
(define (process-shooting a-rocket)
  (make-posn a-rocket MAX-IMG-Y))

;; world key --> world
;; Purpose: Process a key event to return next world
(define (process-key a-world a-key)
  (cond
    [(or (key=? a-key "right")(key=? a-key "d"))
     (make-world (move-rocket-right (world-rocket a-world))
                 (world-aliens a-world)
                 (world-dir a-world)
                 (world-shots a-world)
                 (world-ticks2shoot a-world))]
    [(or (key=? a-key "left")(key=? a-key "a"))
     (make-world (move-rocket-left (world-rocket a-world))
                 (world-aliens a-world)
                 (world-dir a-world)
                 (world-shots a-world)
                 (world-ticks2shoot a-world))]
    [(and (or (key=? a-key " ")(key=? a-key "w"))
          (eq? 0 (world-ticks2shoot a-world)))
     (make-world (world-rocket a-world)
                 (world-aliens a-world)
                 (world-dir a-world)
                 (cons (process-shooting
                        (world-rocket a-world))
                       (world-shots a-world))
                 TTS)]                   
    [else a-world]))
             
;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;   ;;;;;;;  ;;;;;    ;;;;  ;;; ;;;         ;;;;;   ;;;;;     ;;;     ;;;;  ;;;;;;   ;;; ;   ;;; ;   ;;;;; ;;;  ;;;   ;;;; 
;   ;  ;  ;    ;     ;   ;   ;   ;           ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;   ;;  ;   ;;     ;    ;;   ;   ;   ; 
;      ;       ;    ;        ;  ;            ;   ;   ;   ;  ;     ; ;        ; ;    ;       ;          ;    ; ;  ;  ;      
;      ;       ;    ;        ; ;             ;   ;   ;   ;  ;     ; ;        ;;;     ;;;;    ;;;;      ;    ; ;  ;  ;      
;      ;       ;    ;        ;;;             ;;;;    ;;;;   ;     ; ;        ; ;         ;       ;     ;    ;  ; ;  ;   ;;;
;      ;       ;    ;        ;  ;            ;       ;  ;   ;     ; ;        ;           ;       ;     ;    ;  ; ;  ;    ; 
;      ;       ;     ;   ;   ;   ;           ;       ;   ;   ;   ;   ;   ;   ;   ;  ;;   ;  ;;   ;     ;    ;   ;;   ;   ; 
;     ;;;    ;;;;;    ;;;   ;;;  ;;         ;;;     ;;;   ;   ;;;     ;;;   ;;;;;;  ; ;;;   ; ;;;    ;;;;; ;;;  ;;    ;;;  
;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;

;; world --> world
;; Purpose: Create a new world after a clock tick
(define (process-tick a-world)
  (make-world (world-rocket a-world)
              (remove-hit-aliens (move-loa (world-aliens a-world) (world-dir a-world))
                                 (move-los (world-shots a-world)))
              (new-dir-after-tick (move-loa (world-aliens a-world)
                                            (world-dir a-world))
                                  (world-dir a-world))
              (remove-shots (move-los (world-shots a-world))
                            (move-loa (world-aliens a-world)
                                      (world-dir a-world)))
              (if (eq? 0 (world-ticks2shoot a-world)) 0
                  (sub1 (world-ticks2shoot a-world)))))

;; image-x<max \arrow image-x
;; Purpose: Move the given image-x<max right
(define (move-right-image-x an-img-x<max) (add1 an-img-x<max))

;; image-x>min \arrow image-x
;; Purpose: Move the given image-x>min left
(define (move-left-image-x an-img-x>min) (sub1 an-img-x>min))
                
;; image-y<max \arrow image-y
;; Purpose: To move the given image-y<max down
(define (move-down-image-y an-img-y<max) (add1 an-img-y<max))

;; image-y>min --> image-y
;; Purpose: To move the given image-y>min up
(define (move-up-image-y an-img-y>min)
  (sub1 an-img-y>min))

;; alien dir --> alien
;; Purpose: Move given alien in given direction
(define (move-alien an-alien a-dir)
  (cond [(eq? a-dir 'right)
         (make-alien (move-right-image-x (alien-x an-alien))
                     (alien-y an-alien)(alien-health an-alien))]
        [(eq? a-dir 'left)
         (make-alien (move-left-image-x (alien-x an-alien))
                     (alien-y an-alien)(alien-health an-alien))]
        [else (make-alien (alien-x an-alien)
                          (move-down-image-y (alien-y an-alien))
                          (alien-health an-alien))]))

;; loa dir --> loa
;; Purpose: To move the given loa in the given dir
(define (move-loa a-loa dir)
  (if (empty? a-loa)
      '()
      (cons (move-alien (first a-loa) dir)
            (move-loa (rest a-loa) dir))))

;; alien --> Boolean
;; Purpose: Determine if the given alien is at the right edge
(define (alien-at-right-edge? an-alien)
  (= (alien-x an-alien) MAX-IMG-X))

;; loa --> Boolean
;; Purpose: To determine if any alien is at scene's right edge
(define (any-alien-at-right-edge? a-loa)
  (and (not (empty? a-loa))
       (or (alien-at-right-edge? (first a-loa))
           (any-alien-at-right-edge? (rest a-loa)))))

;; alien --> Boolean
;; Purpose: Determine if he given alien is at the left edge
(define (alien-at-left-edge? an-alien)
  (= (alien-x an-alien) MIN-IMG-X))

;; loa --> Boolean
;; Purpose: To determine if any alien is at scene's left edge
(define (any-alien-at-left-edge? a-loa)
  (and (not (empty? a-loa))
       (or (alien-at-left-edge? (first a-loa))
           (any-alien-at-left-edge? (rest a-loa)))))
    
;; loa --> direction
;; Purpose: Compute the direction of the given alien
;;          when previous direction is down
(define (new-dir-after-down a-loa)
  (if (any-alien-at-left-edge? a-loa)
      'right
      'left))

;; alien --> direction
;; Purpose: Compute the direction of the given alien
;;          when previous direction is left
(define (new-dir-after-left a-loa)
  (if (any-alien-at-left-edge? a-loa)
      'down
      'left))

;; loa --> direction
;; Purpose: Compute the direction of the given loa
;;          when previous direction is right
(define (new-dir-after-right a-loa)
  (if (any-alien-at-right-edge? a-loa)
      'down
      'right))

;; loa dir --> dir
;; Purpose: Return new aliens direction
(define (new-dir-after-tick a-loa old-dir)
  (cond [(eq? old-dir 'down)
         (new-dir-after-down a-loa)]
        [(eq? old-dir 'left)
         (new-dir-after-left a-loa)]
        [else (new-dir-after-right a-loa)]))

;; shot --> shot
;; Purpose: To move the given shot
(define (move-shot a-shot)
  (cond [(eq? a-shot NO-SHOT) a-shot]
        [(= (posn-y a-shot) MIN-IMG-Y) NO-SHOT]
        [else (make-posn (posn-x a-shot) (move-up-image-y (posn-y a-shot)))]))

;; los --> los
;; Purpose: To move the given list of shots
(define (move-los a-los)
  (if (empty? a-los)
      '()
      (cons (move-shot (first a-los))
            (move-los  (rest a-los)))))

;; shot --> Boolean
;; Purpose: To determine if the given shot has hit the given alien
(define (hit? a-shot an-alien)
  (and (posn? a-shot)
       (= (posn-x a-shot) (alien-x an-alien))
       (= (posn-y a-shot) (alien-y an-alien))))  

;; alien los --> Boolean
;; Purpose: To determine if the given alien is hit by any shot in the given los
(define (hit-by-any-shot? an-alien a-los)
  (and (not (empty? a-los))
       (or (hit? (first a-los) an-alien)
           (hit-by-any-shot? an-alien (rest a-los)))))

;                                                                                                                                                          
;                                                                                                                                                          
;                                                                                                                                                          
;                                                                                                                                                          
;   ;;; ;;; ;;;;;   ;;;;      ;;    ;;;;;;; ;;;;;;            ;;    ;;;      ;;;;;  ;;;;;; ;;;  ;;;         ;;; ;;; ;;;;;;    ;;    ;;;     ;;;;;;; ;;; ;;;
;    ;   ;   ;   ;   ;  ;      ;    ;  ;  ;  ;   ;             ;     ;         ;     ;   ;  ;;   ;           ;   ;   ;   ;     ;     ;      ;  ;  ;  ;   ; 
;    ;   ;   ;   ;   ;   ;    ; ;      ;     ; ;              ; ;    ;         ;     ; ;    ; ;  ;           ;   ;   ; ;      ; ;    ;         ;     ;   ; 
;    ;   ;   ;   ;   ;   ;    ; ;      ;     ;;;              ; ;    ;         ;     ;;;    ; ;  ;           ;;;;;   ;;;      ; ;    ;         ;     ;;;;; 
;    ;   ;   ;;;;    ;   ;    ; ;      ;     ; ;              ; ;    ;         ;     ; ;    ;  ; ;  ;;;;;;   ;   ;   ; ;      ; ;    ;         ;     ;   ; 
;    ;   ;   ;       ;   ;    ;;;      ;     ;                ;;;    ;   ;     ;     ;      ;  ; ;           ;   ;   ;        ;;;    ;   ;     ;     ;   ; 
;    ;   ;   ;       ;  ;    ;   ;     ;     ;   ;           ;   ;   ;   ;     ;     ;   ;  ;   ;;           ;   ;   ;   ;   ;   ;   ;   ;     ;     ;   ; 
;     ;;;   ;;;     ;;;;    ;;; ;;;   ;;;   ;;;;;;          ;;; ;;; ;;;;;;   ;;;;;  ;;;;;; ;;;  ;;          ;;; ;;; ;;;;;;  ;;; ;;; ;;;;;;    ;;;   ;;; ;;;
;                                                                                                                                                          
;                                                                                                                                                          
;                                                                                                                                                          
;                                                                                                                                                          

;; loa los --> loa
;; Purpose: To check if the Listof Aliens got hit, if true, lower the alien's health by one
(define (update-health a-shot an-alien )
  (if (hit? a-shot an-alien)
      (make-alien (alien-x an-alien)(alien-y an-alien)(sub1 (alien-health an-alien)))
      (make-alien (alien-x an-alien)(alien-y an-alien)an-alien)))

;; an-alien los -> an-alien
;; Purpose: To update the given alien's health if it was hit by any shot
(define (update-any-alien-health a-los an-alien)
  (cond [(empty? a-los) an-alien]
        [(hit? (first a-los) an-alien) (update-health (first a-los) an-alien)]
        [else (update-any-alien-health (rest a-los) an-alien)]))

;; alien --> boolean
;;Purpose: to determine if the given alien has 0 hp
(define (health-0? an-alien)
  (= 0 (alien-health an-alien)))

;; loa los --> loa
;; Purpose: To remove the aliens from the given loa's health is 0
(define (remove-hit-aliens a-loa a-los)
  (cond [(empty? a-loa) '()]
        [(and (hit-by-any-shot? (first a-loa) a-los)(health-0? (update-any-alien-health a-los (first a-loa))))
         (remove-hit-aliens (rest a-loa) a-los)]
        [(hit-by-any-shot? (first a-loa) a-los) (cons (update-any-alien-health a-los (first a-loa))
                                                      (remove-hit-aliens (rest a-loa) a-los))]
        [else (cons (first a-loa)
                    (remove-hit-aliens (rest a-loa) a-los))]))

;; shot loa --> Boolean
;; Purpose: To determine if the given shot has hit any alien in the given loa
(define (hit-any-alien? a-shot a-loa)
  (and (not (empty? a-loa))
       (or (hit? a-shot (first a-loa))
           (hit-any-alien? a-shot (rest a-loa)))))

;; los loa --> los
;; Purpose: To remove hit and NO-SHOTs from the given loa
(define (remove-shots a-los a-loa)
  (cond [(empty? a-los) a-los]
        [(or (eq? (first a-los) NO-SHOT)
             (hit-any-alien? (first a-los) a-loa))
         (remove-shots (rest a-los) a-loa)]
        [else (cons (first a-los) (remove-shots (rest a-los) a-loa))]))
        
;                                                                          
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

;; a-loa --> Boolean
;; Purpose: Determine if the given alien crashed into the rocket
(define (alien-hit-rocket? a-world)
  (and (= (alien-y (first (world-aliens a-world))) MAX-IMG-Y)
       (= (alien-x (first (world-aliens a-world))) (world-rocket a-world))))
 
;; alien rocket -> boolean
;; Purpose: determine if the loa has 1 alien and if that alien hit the rocket
(define (alien-rocket-crash? a-world)
  (and (= (length (world-aliens a-world)) 1)
       (alien-hit-rocket? a-world)))
 
;; alien --> Boolean
;; Purpose: Determine if the given alien reached earth
(define (alien-reached-earth? an-alien)
  (= (alien-y an-alien) MAX-IMG-Y))

;; loa Boolean --> Boolean
;; Purpose: Determine if there is a posn alien in the given loa
(define (any-aliens-alive? a-loa) (not (empty? a-loa)))

;; loa --> Boolean
;; Purpose: Determine if any alien has reached earth
(define (any-alien-reached-earth? a-loa)
  (and (not (empty? a-loa))
       (or (alien-reached-earth? (first a-loa))
           (any-alien-reached-earth? (rest a-loa)))))
 
;; world --> Boolean
;; Purpose: Detect if the game is over
(define (game-over? a-world)
  (or (any-alien-reached-earth? (world-aliens a-world))
      (not (any-aliens-alive? (world-aliens a-world)))
      (alien-rocket-crash? a-world)))

;                                                                                  
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
;; If the aliens get to the bottom of the world
(define (draw-last-world a-world)
  (cond [(any-alien-reached-earth? (world-aliens a-world))
         (place-image (text "YOU LOSE! :(" 36 'lightred)
                      (/ E-SCENE-W 2)
                      (/ E-SCENE-H 4)
                      (draw-world a-world))]
        ;; If all the aliens are destroyed and gone
        [(not (any-aliens-alive? (world-aliens a-world)))
         (place-image (text "YOU WIN! :)" 36 'lightgreen)
                      (/ E-SCENE-W 2)
                      (/ E-SCENE-H 4)
                      (draw-world a-world))]
        ;; If there is one alien left and the rocket and alien collide, you unlock the secret ending
        [(alien-rocket-crash? (world-aliens a-world))
         (place-image (text "SECRET ENDING! :0" 36 'yellow)
                      (/ E-SCENE-W 2)
                      (/ E-SCENE-H 4)
                      (draw-world a-world))]
        [else (error (format "draw-last-world: Given world has ~s aliens and none have reached earth."
                             (length (world-aliens a-world))))]))
                  
;; Sample Instance of (final) world
(define FWORLD1 (make-world 13 (list (make-alien  0 MAX-IMG-Y ALIEN-HEALTH)) 'right INIT-LOS TTS))
(define FWORLD2 (make-world  7 (list (make-alien 19 MAX-IMG-Y ALIEN-HEALTH)) 'left (list (make-posn 2 4))TTS))
(define FWORLD3 (make-world  7 '() 'left (list (make-posn 19 3))TTS))
(define FWORLD4 (make-world 0 (list (make-alien 0 MAX-IMG-Y ALIEN-HEALTH)) 'up INIT-LOS TTS))

;; Different types of endings for draw-last-world
(define FWORLD1-VAL (place-image
                     (text "YOU LOSE! :(" 36 'lightred)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD1)))
(define FWORLD2-VAL (place-image
                     (text "YOU LOSE! :(" 36 'lightred)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD2)))
(define FWORLD3-VAL (place-image
                     (text "YOU WIN! :)" 36 'lightgreen)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD3)))
(define FWORLD4-VAL (place-image
                     (text "SECRET ENDING! :0" 36 'yellow)
                     (/ E-SCENE-W 2)
                     (/ E-SCENE-H 4)
                     (draw-world FWORLD4)))

;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;   ;;;;    ;;;;;     ;;    ;;; ;;;         ;;;       ;;     ;;; ;  ;;;;;;;         ;;; ;;;   ;;;   ;;;;;   ;;;     ;;;;   
;    ;  ;    ;   ;     ;     ;   ;           ;         ;    ;   ;;  ;  ;  ;          ;   ;   ;   ;   ;   ;   ;       ;  ;  
;    ;   ;   ;   ;    ; ;    ;   ;           ;        ; ;   ;          ;             ;   ;  ;     ;  ;   ;   ;       ;   ; 
;    ;   ;   ;   ;    ; ;    ; ; ;           ;        ; ;    ;;;;      ;             ; ; ;  ;     ;  ;   ;   ;       ;   ; 
;    ;   ;   ;;;;     ; ;    ; ; ;           ;        ; ;        ;     ;             ; ; ;  ;     ;  ;;;;    ;       ;   ; 
;    ;   ;   ;  ;     ;;;    ; ; ;           ;   ;    ;;;        ;     ;             ; ; ;  ;     ;  ;  ;    ;   ;   ;   ; 
;    ;  ;    ;   ;   ;   ;   ; ; ;           ;   ;   ;   ;  ;;   ;     ;             ; ; ;   ;   ;   ;   ;   ;   ;   ;  ;  
;   ;;;;    ;;;   ; ;;; ;;;   ; ;           ;;;;;;  ;;; ;;; ; ;;;     ;;;             ; ;     ;;;   ;;;   ; ;;;;;;  ;;;;   
;                                                                                                                          
;                                                                                                                          
;                                                                                                                          
;                                                                                                                                                                             

;; Tests using sample computations for draw-last-world
(check-expect (draw-last-world FWORLD1) FWORLD1-VAL)
(check-expect (draw-last-world FWORLD2) FWORLD2-VAL)
(check-expect (draw-last-world FWORLD3) FWORLD3-VAL)

;; Tests using sample values for draw-last-world
(check-error (draw-last-world (make-world 10 (list (make-posn 3 3) (make-posn 7 8)) 'right (list (make-posn 2 3))TTS)))

;                                                                                                  
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

; string --> world
; Purpose: To run the game
(define (run a-name)
  (local [(define TICK-RATE 1/2)]
    (big-bang ALIEN-ATTACK
      [on-draw draw-world]
      [name a-name]
      [on-key process-key]
      [on-tick process-tick TICK-RATE]
      [stop-when game-over? draw-last-world])))
