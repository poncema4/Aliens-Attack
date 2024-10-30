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
(define MIN-IMG-X 0)
(define MAX-IMG-X (sub1 MAX-CHARS-HORIZONTAL))
(define MIN-IMG-Y 0)
(define MAX-IMG-Y (sub1 MAX-CHARS-VERTICAL))
(define NO-SHOT 'no-shot)
(define MY-NAME "Marco")

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
(define SHOT2 (make-posn AN-IMG-X (/ (sub1 MAX-CHARS-VERTICAL) 2)))

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

;; An ally is a structure: (make-ally rocket string)
;; with this player's rocket and name
(define-struct ally (rocket name score))
(define INIT-SCORE 0)

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
(define WORLD3 (make-world (list (make-ally 7 "iworld1" INIT-SCORE)
                                 (make-ally 9 "iworld2" INIT-SCORE))
                           (list (make-posn 3 3))
                           'right
                           (list (make-posn 1 2))INIT-TTS))
(define WORLD4 (make-world (list (make-ally 8 "iworld3" INIT-SCORE)
                                 (make-ally 5 "iworld2" INIT-SCORE))
                           (list (make-posn 8 2))
                           'right
                           (list (make-posn 8 4))INIT-TTS))
(define UNINIT-WORLD 'uninitialized)

;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;   ;;; ;;;;;;  ;;;  ;;;;; ;;;  ;;; ;;;;;;  ;;;;;    ;;; ;  ;;;;;;            ;;;;    ;;;  ;;;  ;;;  ;;; ;  ;;;;;;;   ;;   ;;;  ;;; ;;;;;;;
;    ;   ;  ;;   ;     ;    ;    ;   ;   ;   ;   ;  ;   ;;   ;   ;           ;   ;   ;   ;  ;;   ;  ;   ;;  ;  ;  ;    ;    ;;   ;  ;  ;  ;
;    ;   ;  ; ;  ;     ;    ;    ;   ; ;     ;   ;  ;        ; ;            ;       ;     ; ; ;  ;  ;          ;      ; ;   ; ;  ;     ;   
;    ;   ;  ; ;  ;     ;     ;  ;    ;;;     ;   ;   ;;;;    ;;;            ;       ;     ; ; ;  ;   ;;;;      ;      ; ;   ; ;  ;     ;   
;    ;   ;  ;  ; ;     ;     ;  ;    ; ;     ;;;;        ;   ; ;            ;       ;     ; ;  ; ;       ;     ;      ; ;   ;  ; ;     ;   
;    ;   ;  ;  ; ;     ;     ;  ;    ;       ;  ;        ;   ;              ;       ;     ; ;  ; ;       ;     ;      ;;;   ;  ; ;     ;   
;    ;   ;  ;   ;;     ;      ;;     ;   ;   ;   ;  ;;   ;   ;   ;           ;   ;   ;   ;  ;   ;;  ;;   ;     ;     ;   ;  ;   ;;     ;   
;     ;;;  ;;;  ;;   ;;;;;    ;;    ;;;;;;  ;;;   ; ; ;;;   ;;;;;;            ;;;     ;;;  ;;;  ;;  ; ;;;     ;;;   ;;; ;;;;;;  ;;    ;;;  
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          
;                                                                                                                                          

;; A universe is a structure: (make-univ (listof iworld) world)
(define-struct univ (iws game))

;; Sample instances of universe
(define INIT-UNIV  (make-univ '() UNINIT-WORLD))
(define OTHR-UNIV  (make-univ (list iworld1 iworld2) WORLD3))
(define OTHR-UNIV2 (make-univ (list iworld3 iworld2) WORLD4))

;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          
;   ;;; ;;;   ;;    ;;;;;    ;;; ;  ;;; ;;;   ;;    ;;;     ;;;      ;;;;; ;;;  ;;;   ;;;; 
;    ;; ;;     ;     ;   ;  ;   ;;   ;   ;     ;     ;       ;         ;    ;;   ;   ;   ; 
;    ;; ;;    ; ;    ;   ;  ;        ;   ;    ; ;    ;       ;         ;    ; ;  ;  ;      
;    ; ; ;    ; ;    ;   ;   ;;;;    ;;;;;    ; ;    ;       ;         ;    ; ;  ;  ;      
;    ; ; ;    ; ;    ;;;;        ;   ;   ;    ; ;    ;       ;         ;    ;  ; ;  ;   ;;;
;    ;   ;    ;;;    ;  ;        ;   ;   ;    ;;;    ;   ;   ;   ;     ;    ;  ; ;  ;    ; 
;    ;   ;   ;   ;   ;   ;  ;;   ;   ;   ;   ;   ;   ;   ;   ;   ;     ;    ;   ;;   ;   ; 
;   ;;; ;;; ;;; ;;; ;;;   ; ; ;;;   ;;; ;;; ;;; ;;; ;;;;;;  ;;;;;;   ;;;;; ;;;  ;;    ;;;  
;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          

;; ally --> mr
;; Purpose: Marshal the given ally
(define (marshal-ally an-ally)
  (list (ally-rocket an-ally) (ally-name an-ally) (ally-score an-ally)))

;; Sample expressions for marshal-ally 
(define M-ALLY1 (list (ally-rocket INIT-ALLY)  (ally-name INIT-ALLY) (ally-score INIT-ALLY)))
(define M-ALLY2 (list (ally-rocket INIT-ALLY2) (ally-name INIT-ALLY2) (ally-score INIT-ALLY2)))

;; Tests using sample computations for marshal-ally 
(check-expect (marshal-ally  INIT-ALLY)  M-ALLY1)
(check-expect (marshal-ally  INIT-ALLY2) M-ALLY2)

;; Tests using sample values for marshal-ally 
(check-expect (marshal-ally (make-ally 12 "Ponce" INIT-SCORE))
              (list 12 "Ponce" INIT-SCORE))

;; alien --> ma
;; Purpose: Marshal the given alien
(define (marshal-alien an-alien)
  (list (posn-x an-alien) (posn-y an-alien)))

;; Sample expressions for marshal-alien
(define MINIT-ALIEN2 (list (posn-x INIT-ALIEN2) (posn-y INIT-ALIEN2)))

;; Tests using sample computations for marshal-alien 
(check-expect (marshal-alien INIT-ALIEN2) MINIT-ALIEN2)

;; Tests using sample values for unmarshal-alien 
(check-expect (marshal-alien (make-posn 5 5)) (list 5 5))                                                                                         

;; shot --> ms
;; Purpose: Marshal the given shot
(define (marshal-shot a-shot)
  (if (eq? a-shot NO-SHOT)
      NO-SHOT
      (list (posn-x a-shot) (posn-y a-shot))))

;; Sample expressions for marshal-shot
(define M-NO-SHOT NO-SHOT)
(define M-SHOT2   (list (posn-x SHOT2) (posn-y SHOT2)))

;; Tests using sample computations for marshal-shot
(check-expect (marshal-shot NO-SHOT) M-NO-SHOT)
(check-expect (marshal-shot SHOT2) M-SHOT2)

;; Tests using sample values for marshal-shot
(check-expect (marshal-shot (make-posn 2 2)) (list 2 2))

;; world --> mw
;; Purpose: Marshal the given world
;; ASSUMPTION: The given world is a structure
(define (marshal-world a-world)
  (list (map marshal-ally  (world-allies a-world))
        (map marshal-alien (world-aliens a-world))
        (world-dir a-world)
        (map marshal-shot (world-shots a-world))
        (world-ticks2shoot a-world)))

;; Sample expressions for marshal-world
(define MWORLD3 (list (map marshal-ally  (world-allies WORLD3))
                      (map marshal-alien (world-aliens WORLD3))
                      (world-dir WORLD3)
                      (map marshal-shot  (world-shots WORLD3))
                      (world-ticks2shoot WORLD3)))

(define MWORLD4 (list (map marshal-ally  (world-allies WORLD4))
                      (map marshal-alien (world-aliens WORLD4))
                      (world-dir WORLD4)
                      (map marshal-shot  (world-shots WORLD4))
                      (world-ticks2shoot WORLD4)))

;; Tests using sample computations for marshal-world
(check-expect (marshal-world WORLD3) MWORLD3)
(check-expect (marshal-world WORLD4) MWORLD4)

;; Tests using sample values for marshal-world
(check-expect (marshal-world (make-world (list (make-ally 5 "Marco" INIT-SCORE)
                                               (make-ally 8 "Ponce" INIT-SCORE))
                                         (list (make-posn  2 17))
                                         "left"
                                         '()INIT-TTS))
              (list (list (list 5 "Marco" INIT-SCORE)
                          (list 8 "Ponce" INIT-SCORE))
                    (list (list  2 17))
                    "left"
                    '()INIT-TTS))

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
     
;; univ --> bundle 
;; Purpose: Create a new universe after a clock tick
(define (process-tick a-univ)
  (local [;; dir --> (alien --> alien)
          ;; Purpose: Return a function to move an alien in the given direction
          (define (move-alien-maker a-dir)
            (λ (an-alien)
              (local [;; image-y<max --> image-y
                      ;; Purpose: To move the given image-y<max down
                      (define (move-down-image-y an-img-y<max) (add1 an-img-y<max))
                    
                      ;; image-x>min \arrow image-x
                      ;; Purpose: Move the given image-x>min left
                      (define (move-left-image-x an-img-x>min) (sub1 an-img-x>min))
                    
                      ;; image-x<max \arrow image-x
                      ;; Purpose: Move the given image-x<max right
                      (define (move-right-image-x an-img-x<max) (add1 an-img-x<max))]
                (cond [(eq? a-dir 'right)
                       (make-posn (move-right-image-x (posn-x an-alien))
                                  (posn-y an-alien))]
                      [(eq? a-dir 'left)
                       (make-posn (move-left-image-x (posn-x an-alien))
                                  (posn-y an-alien))]
                      [else (make-posn (posn-x an-alien)
                                       (move-down-image-y (posn-y an-alien)))]))))
          
          ;; loa dir --> loa
          ;; Purpose: To move the given loa in the given dir
          (define (move-loa a-loa dir)
            (map (move-alien-maker dir) a-loa))

          ;; los --> los
          ;; Purpose: To move the given list of shots
          (define (move-los a-los)
            (map (lambda (a-shot)
                   (cond [(eq? a-shot NO-SHOT) a-shot]
                         [(= (posn-y a-shot) MIN-IMG-Y) NO-SHOT]
                         [else (make-posn
                                (posn-x a-shot)
                                (sub1 (posn-y a-shot)))])) ;; inline move-up-image
                 a-los))

          ;; loa dir --> dir
          ;; Purpose: Return new aliens direction
          (define (new-dir-after-tick a-loa old-dir)
            (local [;; loa --> Boolean
                    ;; Purpose: To determine if any alien is at scene's right edge
                    (define (any-alien-at-right-edge? a-loa)
                      (ormap (lambda (an-alien) (= (posn-x an-alien) MAX-IMG-X)) a-loa))
                    
                    ;; loa --> Boolean
                    ;; Purpose: To determine if any alien is at scene's left edge
                    (define (any-alien-at-left-edge? a-loa)
                      (ormap (lambda (an-alien) (= (posn-x an-alien) MIN-IMG-X)) a-loa))]
              (cond [(eq? old-dir 'down)
                     (if (any-alien-at-left-edge? a-loa) 'right 'left)]
                    [(eq? old-dir 'left)
                     (if (any-alien-at-left-edge? a-loa) 'down 'left)]
                    [else (if (any-alien-at-right-edge? a-loa) 'down 'right)])))
                                                                                                                                                        
;                                                                                                                                                  
;                                                                                                                                                  
;   ;;; ;;; ;;;;;   ;;;;      ;;    ;;;;;;; ;;;;;;          ;;;     ;;;;;;    ;;    ;;;;    ;;;;;;  ;;;;;   ;;;;;     ;;;     ;;    ;;;;;   ;;;;   
;    ;   ;   ;   ;   ;  ;      ;    ;  ;  ;  ;   ;           ;       ;   ;     ;     ;  ;    ;   ;   ;   ;   ;   ;   ;   ;     ;     ;   ;   ;  ;  
;    ;   ;   ;   ;   ;   ;    ; ;      ;     ; ;             ;       ; ;      ; ;    ;   ;   ; ;     ;   ;   ;   ;  ;     ;   ; ;    ;   ;   ;   ; 
;    ;   ;   ;   ;   ;   ;    ; ;      ;     ;;;             ;       ;;;      ; ;    ;   ;   ;;;     ;   ;   ;;;;   ;     ;   ; ;    ;   ;   ;   ; 
;    ;   ;   ;;;;    ;   ;    ; ;      ;     ; ;             ;       ; ;      ; ;    ;   ;   ; ;     ;;;;    ;   ;  ;     ;   ; ;    ;;;;    ;   ; 
;    ;   ;   ;       ;   ;    ;;;      ;     ;               ;   ;   ;        ;;;    ;   ;   ;       ;  ;    ;   ;  ;     ;   ;;;    ;  ;    ;   ; 
;    ;   ;   ;       ;  ;    ;   ;     ;     ;   ;           ;   ;   ;   ;   ;   ;   ;  ;    ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;  ;  
;     ;;;   ;;;     ;;;;    ;;; ;;;   ;;;   ;;;;;;          ;;;;;;  ;;;;;;  ;;; ;;; ;;;;    ;;;;;;  ;;;   ; ;;;;;     ;;;   ;;; ;;; ;;;   ; ;;;;   
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

           (define (if-hit-any? a-los a-loa)
             (ormap (λ (an-alien)
              (ormap (lambda (a-shot) (hit? a-los an-alien)) a-los))
                    a-loa))

          (define (update-lb a-loa a-lor)
              (map (λ (an-ally) (make-ally (ally-rocket an-ally) (ally-name an-ally) (- 18 (length a-loa))))a-lor))
            
          ;; loa los --> loa
          ;; Purpose: To remove the aliens from the given loa hit by any shot in the given los
          (define (remove-hit-aliens a-loa a-los)
            (filter (lambda (an-alien)
                      (not (ormap (lambda (a-shot) (hit? a-shot an-alien)) a-los)))
                    a-loa))

          ;; los loa --> los
          ;; Purpose: To remove hit and NO-SHOTs from the given loa
          (define (remove-shots a-los a-loa)
            (filter (lambda (a-shot)
                      (not (or (eq? a-shot NO-SHOT)
                               (ormap (lambda (an-alien) (hit? a-shot an-alien))
                                      a-loa))))
                    a-los))

;                                                                                                                                                  
;                                                                                                                                                  
;                                                                                                                                                  
;  ;;;  ;;; ;;;;;;  ;;; ;;;         ;;; ;;;   ;;;   ;;;;;   ;;;     ;;;;            ;;;;;   ;;;;;;  ;;;;;           ;;;;;;;  ;;;;;    ;;;;  ;;; ;;;
;   ;;   ;   ;   ;   ;   ;           ;   ;   ;   ;   ;   ;   ;       ;  ;            ;   ;   ;   ;   ;   ;          ;  ;  ;    ;     ;   ;   ;   ; 
;   ; ;  ;   ; ;     ;   ;           ;   ;  ;     ;  ;   ;   ;       ;   ;           ;   ;   ; ;     ;   ;             ;       ;    ;        ;  ;  
;   ; ;  ;   ;;;     ; ; ;           ; ; ;  ;     ;  ;   ;   ;       ;   ;           ;   ;   ;;;     ;   ;             ;       ;    ;        ; ;   
;   ;  ; ;   ; ;     ; ; ;           ; ; ;  ;     ;  ;;;;    ;       ;   ;           ;;;;    ; ;     ;;;;              ;       ;    ;        ;;;   
;   ;  ; ;   ;       ; ; ;           ; ; ;  ;     ;  ;  ;    ;   ;   ;   ;           ;       ;       ;  ;              ;       ;    ;        ;  ;  
;   ;   ;;   ;   ;   ; ; ;           ; ; ;   ;   ;   ;   ;   ;   ;   ;  ;            ;       ;   ;   ;   ;             ;       ;     ;   ;   ;   ; 
;  ;;;  ;;  ;;;;;;    ; ;             ; ;     ;;;   ;;;   ; ;;;;;;  ;;;;            ;;;     ;;;;;;  ;;;   ;           ;;;    ;;;;;    ;;;   ;;;  ;;
;                                                                                                                                                  
;                                                                                                                                                  
;                                                                                                                                                  
;                                                                                                                                                  

          ;; world --> world
          ;; Purpose: Create a new world after a clock tick
          ;; ASSUMPTION: The world is a structure
          (define (process-tick a-world)
            (make-world (update-lb
                         (world-aliens a-world)
                         (world-allies a-world))
                        (remove-hit-aliens (move-loa (world-aliens a-world) (world-dir a-world))
                                           (move-los (world-shots a-world)))
                        (new-dir-after-tick (move-loa (world-aliens a-world)
                                                      (world-dir a-world))
                                            (world-dir a-world))
                        (remove-shots (move-los (world-shots a-world))
                                      (move-loa (world-aliens a-world)
                                                (world-dir a-world)))
                        (if (= (world-ticks2shoot a-world) 0)
                         INIT-TTS
                        (sub1 (world-ticks2shoot a-world)))))]
    (if (equal? a-univ INIT-UNIV)
        (make-bundle a-univ '() '())
        (local [(define new-game (process-tick (univ-game a-univ)))]
          (make-bundle
           (make-univ (univ-iws a-univ) new-game)
           (map (λ (iw) (make-mail iw (cons 'world (marshal-world new-game))))
                (univ-iws a-univ))
           '())))))

;; Tests using sample values for process-tick   
(check-expect (process-tick
               (make-univ (list iworld1 iworld3)
                          (make-world (list (make-ally 9 "iworld1" INIT-SCORE)
                                            (make-ally 2 "iworld3" INIT-SCORE))
                                      (list (make-posn 2 5))
                                      'left
                                      (list (make-posn 3 6) NO-SHOT)INIT-TTS)))
              (make-bundle
               (make-univ (list iworld1 iworld3)
                          (make-world (list (make-ally 9 "iworld1" INIT-SCORE)
                                            (make-ally 2 "iworld3" INIT-SCORE))
                                      (list (make-posn 1 5))
                                      'left
                                      (list (make-posn 3 5))(sub1 INIT-TTS)))
               (list (make-mail iworld1
                                (list 'world
                                      (list (list 9 "iworld1" INIT-SCORE)
                                            (list 2 "iworld3" INIT-SCORE))
                                      (list (list 1 5))
                                      'left
                                      (list (list 3 5))(sub1 INIT-TTS)))
                     (make-mail iworld3
                                (list 'world
                                      (list (list 9 "iworld1" INIT-SCORE)
                                            (list 2 "iworld3" INIT-SCORE))
                                      (list (list 1 5))
                                      'left
                                      (list (list 3 5))(sub1 INIT-TTS))))
               '()))
                     
(check-expect (process-tick
               (make-univ (list iworld3)
                          (make-world (list (make-ally 6 "iworld3" INIT-SCORE))
                                      (list (make-posn (- MAX-CHARS-HORIZONTAL 2) 10))
                                      'right
                                      (list SHOT2)INIT-TTS)))
              (make-bundle
               (make-univ
                (list iworld3)
                (make-world (list (make-ally 6 "iworld3" INIT-SCORE))
                            (list (make-posn (sub1 MAX-CHARS-HORIZONTAL) 10))
                            'down
                            (list (make-posn (posn-x SHOT2)
                                             (sub1 (posn-y SHOT2))))(sub1 INIT-TTS)))
               (list (make-mail
                      iworld3
                      (list 'world
                            (list (list 6 "iworld3" INIT-SCORE))
                            (list (list (sub1 MAX-CHARS-HORIZONTAL) 10))
                            'down
                            (list (list (posn-x SHOT2)
                                        (sub1 (posn-y SHOT2))))(sub1 INIT-TTS))))
               '()))

(check-expect (process-tick
               (make-univ
                (list iworld2)
                (make-world (list (make-ally 14 "iworld2" INIT-SCORE))
                            (list (make-posn MAX-IMG-X 2))
                            'down
                            (list (make-posn 15 6))INIT-TTS)))
              (make-bundle
               (make-univ
                (list iworld2)
                (make-world
                 (list (make-ally 14 "iworld2" INIT-SCORE))
                 (list (make-posn MAX-IMG-X 3))
                 'left
                 (list (make-posn 15 5))(sub1 INIT-TTS)))
               (list (make-mail
                      iworld2
                      (list 'world
                            (list (list 14 "iworld2" INIT-SCORE))
                            (list (list MAX-IMG-X 3))
                            'left
                            (list (list 15 5))(sub1 INIT-TTS))))
               '()))

(check-expect (process-tick
               (make-univ
                (list iworld1)
                (make-world (list (make-ally 3 "iworld1" INIT-SCORE))
                            (list (make-posn MIN-IMG-X 2))
                            'down
                            (list (make-posn 2 MIN-IMG-Y))INIT-TTS)))
              (make-bundle
               (make-univ
                (list iworld1)
                (make-world
                 (list (make-ally  3 "iworld1" INIT-SCORE))
                 (list (make-posn MIN-IMG-X 3))
                 'right
                 '()(sub1 INIT-TTS)))
               (list (make-mail
                      iworld1
                      (list
                       'world
                       (list (list  3 "iworld1" INIT-SCORE))
                       (list (list MIN-IMG-X 3))
                       'right
                       '()(sub1 INIT-TTS))))
               '()))

;; Sample instances of tsm
(define MV-LEFT (list 'move "left"))
(define MV-RGHT (list 'move "right"))
(define SHOOT   (list 'shoot))

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

;; univ iworld tsm --> bundle throws error
;; Purpose: Process the message to create new universe
;; ASSUMPTION: The given univ is not INIT-UNIV
(define (process-message a-univ an-iw a-tsm)
  (local [(define tag (first a-tsm))
          (define name (iworld-name an-iw))
          (define game (univ-game a-univ))
          ;; key --> bundle
          ;; Purpose: Process a key event to return next world
          (define (process-key a-key)
            (local [;; shot rocket --> shot
                    ;; Purpose: To create a new shot
                    (define (process-shooting a-rocket)
                      (make-posn a-rocket MAX-IMG-Y))

                    (define (make-rocket-mover cmp val f)
                      (λ (rckt)
                        (if (cmp rckt val) (f rckt) rckt)))
            
                    ;; rocket --> rocket
                    ;; Purpose: Move the given rocket left
                    (define move-rckt-left (make-rocket-mover > 0 sub1))

                    ;; rocket --> rocket
                    ;; Purpose: Move the given rocket right
                    (define move-rckt-right (make-rocket-mover <
                                                               (sub1 MAX-CHARS-HORIZONTAL)
                                                               add1))

                    ;; (rocket --> rocket) --> (string lor --> lor)
                    ;; Purpose: Make an ally-moving function
                    (define (make-ally-mover move-rckt)
                      (λ (a-name a-lor)
                        (map (λ (an-ally)
                               (if (string=? a-name (ally-name an-ally))
                                   (make-ally (move-rckt (ally-rocket an-ally))
                                              (ally-name an-ally)
                                              (ally-score an-ally))
                                   an-ally))
                             a-lor)))
          
                    ;; string lor --> lor
                    ;; Purpose: Move ally with given name right
                    (define move-ally-right (make-ally-mover move-rckt-right))

                    ;; string lor --> lor
                    ;; Purpose: Move ally with given name left
                    (define move-ally-left (make-ally-mover move-rckt-left))
                    
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
                    
                    ;; string lor --> ally
                    ;; Purpose: Extract ally with given name
                    ;; ASSUMPTIONS: All allies have a unique name
                    ;; There is an ally with given name
                    (define (get-ally a-name a-lor)
                      (first (filter (λ (an-ally) (string=? a-name (ally-name an-ally))) a-lor)))

                    (define nw (make-world
                                (cond [(or (key=? a-key "right")(key=? a-key "d"))
                                       (move-ally-right name (world-allies game))]
                                      [(or (key=? a-key "left") (key=? a-key "a"))
                                       (move-ally-left name (world-allies game))]
                                      [else (world-allies game)])
                                (world-aliens game)
                                (world-dir game)
                                (if (and (or (key=? a-key " ")(key=? a-key "w"))
                                          (eq? 0 (world-ticks2shoot game)))
                                          (cons (process-shooting
                                                 (ally-rocket (get-ally name
                                                                        (world-allies game))))
                                                (world-shots game))
                                          (world-shots game))
                                (world-ticks2shoot game)))]
              (make-bundle (make-univ (univ-iws a-univ) nw)
                           (map (λ (iw)
                                  (make-mail iw (cons 'world (marshal-world nw))))
                                (univ-iws a-univ))
                           '())))]
    (if (or (eq? tag 'shoot) (eq? tag 'move))
        (process-key (if (eq? tag 'shoot)
                         " "
                         (second a-tsm)))
        (error (format "Unknown to-server message type ~s"
                       a-tsm)))))

;; Tests using sample values for process-message
(check-expect
 (process-message OTHR-UNIV iworld2 MV-LEFT)
 (make-bundle
  (make-univ
   (list iworld1 iworld2)
   (make-world
    (list (make-ally 7 "iworld1" INIT-SCORE) (make-ally 8 "iworld2" INIT-SCORE))
    (list (make-posn 3 3))
    'right
    (list (make-posn 1 2))INIT-TTS))
  (list
   (make-mail
    iworld1
    (list
     'world
     (list (list 7 "iworld1" INIT-SCORE) (list 8 "iworld2" INIT-SCORE))
     (list (list 3 3))
     'right
     (list (list 1 2))INIT-TTS))
   (make-mail
    iworld2
    (list
     'world
     (list (list 7 "iworld1" INIT-SCORE) (list 8 "iworld2" INIT-SCORE))
     (list (list 3 3))
     'right
     (list (list 1 2))INIT-TTS)))
  '()))

(check-expect
 (process-message OTHR-UNIV iworld1 MV-RGHT)
 (make-bundle
  (make-univ
   (list iworld1 iworld2)
   (make-world
    (list (make-ally 8 "iworld1" INIT-SCORE) (make-ally 9 "iworld2" INIT-SCORE))
    (list (make-posn 3 3))
    'right
    (list (make-posn 1 2))INIT-TTS))
  (list
   (make-mail
    iworld1
    (list
     'world
     (list (list 8 "iworld1" INIT-SCORE) (list 9 "iworld2" INIT-SCORE))
     (list (list 3 3))
     'right
     (list (list 1 2))INIT-TTS))
   (make-mail
    iworld2
    (list
     'world
     (list (list 8 "iworld1" INIT-SCORE) (list 9 "iworld2" INIT-SCORE))
     (list (list 3 3))
     'right
     (list (list 1 2))INIT-TTS)))
  '()))
              
(check-error (process-message OTHR-UNIV iworld2 (list 'move-left 'left))
             (format "Unknown to-server message type ~s"
                     (list 'move-left 'left)))

;                                                                                          
;                                                                                          
;                                                                                          
;     ;;    ;;;;    ;;;;              ;;            ;;; ;;;   ;;;   ;;;;;   ;;;     ;;;;   
;      ;     ;  ;    ;  ;              ;             ;   ;   ;   ;   ;   ;   ;       ;  ;  
;     ; ;    ;   ;   ;   ;            ; ;            ;   ;  ;     ;  ;   ;   ;       ;   ; 
;     ; ;    ;   ;   ;   ;            ; ;            ; ; ;  ;     ;  ;   ;   ;       ;   ; 
;     ; ;    ;   ;   ;   ;            ; ;            ; ; ;  ;     ;  ;;;;    ;       ;   ; 
;     ;;;    ;   ;   ;   ;            ;;;            ; ; ;  ;     ;  ;  ;    ;   ;   ;   ; 
;    ;   ;   ;  ;    ;  ;            ;   ;           ; ; ;   ;   ;   ;   ;   ;   ;   ;  ;  
;   ;;; ;;; ;;;;    ;;;;            ;;; ;;;           ; ;     ;;;   ;;;   ; ;;;;;;  ;;;;   
;                                                                                          
;                                                                                          
;                                                                                          
;                                                                                          

;; universe iworld --> bundle
;; Purpose: Add new world to the universe
(define (add-player a-univ an-iw)
  (if (member? (iworld-name an-iw) (map iworld-name (univ-iws a-univ)))
      (make-bundle a-univ '() (list an-iw))
      (local [(define new-iws (cons an-iw (univ-iws a-univ)))
              (define game (univ-game a-univ))
              (define new-game (if (equal? game UNINIT-WORLD)
                                   (make-world
                                    (list (make-ally INIT-ROCKET (iworld-name an-iw)INIT-SCORE))
                                    (world-aliens INIT-WORLD)
                                    (world-dir    INIT-WORLD)
                                    (world-shots  INIT-WORLD)
                                    (world-ticks2shoot INIT-WORLD))
                                   (make-world
                                    (cons (make-ally INIT-ROCKET (iworld-name an-iw)INIT-SCORE)
                                          (world-allies game))
                                    (world-aliens game)
                                    (world-dir game)
                                    (world-shots game)
                                    (world-ticks2shoot game))))]
        (make-bundle
         (make-univ new-iws new-game)
         (map
          (λ (iw)
            (make-mail iw
                       (cons 'world (marshal-world new-game))))
          new-iws)
         '()))))

;; Sample expressions for add-player
(define RPT-ADD (make-bundle OTHR-UNIV '() (list iworld1)))
(define EMP-ADD (local [(define new-iws (cons iworld2 (univ-iws INIT-UNIV)))
                        (define game (univ-game INIT-UNIV))
                        (define new-game (if (equal? game UNINIT-WORLD)
                                             (make-world
                                              (list (make-ally INIT-ROCKET (iworld-name iworld2) INIT-SCORE))
                                              INIT-LOA
                                              INIT-DIR
                                              INIT-LOS
                                              INIT-TTS)
                                             (make-world
                                              (cons (make-ally INIT-ROCKET (iworld-name iworld2) INIT-SCORE)
                                                    (world-allies game))
                                              (world-aliens game)
                                              (world-dir game)
                                              (world-shots game))))]
                  (make-bundle
                   (make-univ new-iws new-game)
                   (map
                    (λ (iw)
                      (make-mail iw
                                 (cons 'world (marshal-world new-game))))
                    new-iws)
                   '())))

(define NEW-ADD (local [(define new-iws (cons iworld3 (univ-iws OTHR-UNIV)))
                        (define game (univ-game OTHR-UNIV))
                        (define new-game (if (equal? game UNINIT-WORLD)
                                             (make-world
                                              (list (make-ally INIT-ROCKET (iworld-name iworld3)))
                                              INIT-LOA
                                              INIT-DIR
                                              INIT-LOS
                                              INIT-TTS)
                                             (make-world
                                              (cons (make-ally INIT-ROCKET (iworld-name iworld3) INIT-SCORE)
                                                    (world-allies game))
                                              (world-aliens game)
                                              (world-dir game)
                                              (world-shots game)
                                              (world-ticks2shoot game))))]
                  (make-bundle
                   (make-univ new-iws new-game)
                   (map
                    (λ (iw)
                      (make-mail iw
                                 (cons 'world (marshal-world new-game))))
                    new-iws)
                   '())))

;; Tests using sample computations for add-player
(check-expect (add-player OTHR-UNIV iworld1) RPT-ADD)
(check-expect (add-player INIT-UNIV iworld2) EMP-ADD)
(check-expect (add-player OTHR-UNIV iworld3) NEW-ADD)

;; Tests using sample values for add-player
(check-expect (add-player (make-univ (list iworld2 iworld3)
                                     (make-world
                                      (list (make-ally 7 "iworld2" INIT-SCORE) (make-ally 9 "iworld3" INIT-SCORE))
                                      (list (make-posn 3 3))
                                      'right
                                      (list (make-posn 3 3))INIT-TTS))
                          iworld1)
              (make-bundle   (make-univ
                              (list iworld1 iworld2 iworld3)
                              (make-world
                               (list (make-ally 10 "iworld1" INIT-SCORE)
                                     (make-ally 7 "iworld2" INIT-SCORE)
                                     (make-ally 9 "iworld3" INIT-SCORE))
                               (list (make-posn 3 3))
                               'right
                               (list (make-posn 3 3))INIT-TTS))
                             (map
                              (λ (iw)
                                (make-mail iw (cons
                                               'world
                                               (marshal-world
                                                (make-world
                                                 (list (make-ally 10 "iworld1" INIT-SCORE)
                                                       (make-ally 7 "iworld2" INIT-SCORE)
                                                       (make-ally 9 "iworld3" INIT-SCORE))
                                                 (list (make-posn 3 3))
                                                 'right
                                                 (list (make-posn 3 3))INIT-TTS)))))
                              (list iworld1 iworld2 iworld3))
                             '()))

;                                                                                                                                                          
;                                                                                                                                                          

;                                                                                                          
;                                                                                                          
;                                                                                                          
;     ;;;  ;;;  ;;;         ;;;;     ;;;;;   ;;; ;    ;;;;    ;;;  ;;;  ;;;;;;  ;;; ;;;;;;    ;;;;  ;;;;;;;
;    ;   ;  ;;   ;           ;  ;      ;    ;   ;;   ;   ;   ;   ;  ;;   ;  ;;   ;   ;   ;   ;   ;  ;  ;  ;
;   ;     ; ; ;  ;           ;   ;     ;    ;       ;       ;     ; ; ;  ;  ; ;  ;   ; ;    ;          ;   
;   ;     ; ; ;  ;           ;   ;     ;     ;;;;   ;       ;     ; ; ;  ;  ; ;  ;   ;;;    ;          ;   
;   ;     ; ;  ; ;           ;   ;     ;         ;  ;       ;     ; ;  ; ;  ;  ; ;   ; ;    ;          ;   
;   ;     ; ;  ; ;           ;   ;     ;         ;  ;       ;     ; ;  ; ;  ;  ; ;   ;      ;          ;   
;    ;   ;  ;   ;;           ;  ;      ;    ;;   ;   ;   ;   ;   ;  ;   ;;  ;   ;;   ;   ;   ;   ;     ;   
;     ;;;  ;;;  ;;          ;;;;     ;;;;;  ; ;;;     ;;;     ;;;  ;;;  ;; ;;;  ;;  ;;;;;;    ;;;     ;;;  
;                                                                                                          
;                                                                                                          
;                                                                                                          
;                                                                                                          
                                                                                                                                                                                                                                                           
;; univ iworld --> bundle
;; Purpose: Remove given iw from universe and game
;; ASSUMPTION: Given univ is not INIT-UNIV
(define (rm-player a-univ an-iw)
  (local [(define iws  (univ-iws a-univ))
          (define game (univ-game a-univ))
          (define new-iws (filter (λ (iw)
                                    (not (string=? (iworld-name an-iw)
                                                   (iworld-name iw))))
                                  iws))
          (define new-game (make-world
                            (filter (λ (a) (not (string=? (iworld-name an-iw)
                                                          (ally-name a))))
                                    (world-allies game))
                            (world-aliens game)
                            (world-dir game)
                            (world-shots game)
                            (world-ticks2shoot game)))]
    (make-bundle (make-univ new-iws new-game)
                 (map (λ (iw) (make-mail iw (cons 'world (marshal-world new-game))))
                      new-iws)
                 '())))

;; Sample expressions for rm-player
(define RM-IW1 (local [(define iws  (univ-iws OTHR-UNIV))
                       (define game (univ-game OTHR-UNIV))
                       (define new-iws (filter (λ (iw)
                                                 (not (string=? (iworld-name iworld1)
                                                                (iworld-name iw))))
                                               iws))
                       (define new-game (make-world
                                         (filter (λ (a) (not (string=? (iworld-name iworld1)
                                                                       (ally-name a))))
                                                 (world-allies game))
                                         (world-aliens game)
                                         (world-dir game)
                                         (world-shots game)INIT-TTS))]
                 (make-bundle (make-univ new-iws new-game)
                              (map (λ (iw) (make-mail iw (cons 'world (marshal-world new-game))))
                                   new-iws)
                              '())))

(define RM-IW2 (local [(define iws  (univ-iws OTHR-UNIV2))
                       (define game (univ-game OTHR-UNIV2))
                       (define new-iws (filter (λ (iw)
                                                 (not (string=? (iworld-name iworld2)
                                                                (iworld-name iw))))
                                               iws))
                       (define new-game (make-world
                                         (filter (λ (a) (not (string=? (iworld-name iworld2)
                                                                       (ally-name a))))
                                                 (world-allies game))
                                         (world-aliens game)
                                         (world-dir game)
                                         (world-shots game)
                                         (world-ticks2shoot game)))]
                 (make-bundle (make-univ new-iws new-game)
                              (map (λ (iw) (make-mail iw (cons 'world (marshal-world new-game))))
                                   new-iws)
                              '())))

;; Tests using sample computations for rm-player
(check-expect (rm-player OTHR-UNIV  iworld1) RM-IW1)
(check-expect (rm-player OTHR-UNIV2 iworld2) RM-IW2)

;; Tests using sample computations for rm-player
(check-expect (rm-player (make-univ
                          (list iworld3)
                          (make-world (list (make-ally 8 "iworld3" INIT-SCORE))
                                      '()
                                      'down
                                      '()INIT-TTS))
                         iworld3)
              (make-bundle
               (make-univ
                '()
                (make-world '()
                            '()
                            'down
                            '()INIT-TTS))
               '()
               '()))

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

;; Z --> univ
;; Purpose: To run the server
(define (run-server a-z)
  (local [(define TICK-RATE 1/2)]
    (universe
     INIT-UNIV
     (on-tick process-tick TICK-RATE)
     (on-msg process-message)
     (on-new add-player)
     (on-disconnect rm-player))))

(run-server " ")
