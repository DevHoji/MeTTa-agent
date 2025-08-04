!(bind! &rb (new-space))

;; Logical rules
!(add-atom &rb (-> (likes_user spicy) (has_taste $x spicy)))
!(add-atom &rb (-> (likes_user rice) (has_base $x rice)))
!(add-atom &rb (-> (likes_user healthy) (is_healthy $x)))

;; Final food check
!(add-atom &rb (-> (has_taste $x spicy)
                   (suggests_user $x)))
!(add-atom &rb (-> (has_base $x rice)
                   (suggests_user $x)))
!(add-atom &rb (-> (is_healthy $x)
                   (suggests_user $x)))
!(add-atom &rb (-> (suggests_user $x)
                   (is_food $x)))
