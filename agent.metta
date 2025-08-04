;; ------------------------
;; Load knowledge & rules
;; ------------------------
!(load-file "knowledge.mett")
!(load-file "rules.mett")

;; ------------------------
;; Backward Chainer
;; ------------------------

(: bc_suggest (-> Atom Nat Atom))

;; Base case
(= (bc_suggest $goal Z)
   (match &kb $goal $goal))

;; Recursive case
(= (bc_suggest $goal (S $k))
   (match &rb (: $_ (-> $pre $goal))
     (let (($p (bc_suggest $pre $k)))
       $goal)))

;; ------------------------
;; Final run and extract result using `match`
;; ------------------------

(match &kb (is_food $x)
  (do
    (bc_suggest (is_food $x) (fromNumber 3))
    $x))
