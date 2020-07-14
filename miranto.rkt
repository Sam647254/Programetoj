#lang typed/racket
(: literoj (HashTable Char Index))
(define literoj
  (hash #\p #xE800
        #\b #xE801
        #\m #xE802
        #\f #xE803
        #\v #xE804
        #\t #xE805
        #\d #xE806
        #\n #xE807
        #\s #xE808
        #\z #xE809
        #\c #xE80A
        #\l #xE80B
        #\r #xE80C
        #\ŝ #xE80D
        #\ĵ #xE80E
        #\ĉ #xE80F
        #\ĝ #xE810
        #\j #xE811
        #\k #xE812
        #\g #xE813
        #\ĥ #xE814
        #\h #xE815
        #\a #xE816
        #\e #xE817
        #\i #xE818
        #\o #xE819
        #\u #xE81A
        #\` #xE81B
        #\ŭ #xE81C
        #\. #xE81D
        #\, #xE81E
        #\! #xE81F
        #\? #xE820
        #\: #xE821
        #\; #xE822
        #\@ #xE823
        #\w #xE824))

(: latina->miranto (-> String String))
(define (latina->miranto eniro)
  (let* ([signoj (string->list (string-downcase eniro))]
          [mirantaj-signoj
           (map (λ ([s : Char]) (hash-ref literoj s (λ () (char->integer s)))) signoj)]
          [miranta-signoĉeno (map (λ (s) (integer->char s)) mirantaj-signoj)])
    (list->string miranta-signoĉeno)))

(define argv (current-command-line-arguments))
(define eniro (vector-ref argv 0))
(define eliro (vector-ref argv 1))
(define teksto (with-input-from-file eniro port->string))
(with-output-to-file eliro (λ () (printf (latina->miranto teksto))) #:exists 'replace)