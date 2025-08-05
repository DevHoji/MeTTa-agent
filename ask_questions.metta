;; ========================================
;; ETHIOPIAN RECIPE RECOMMENDATION AGENT - MAIN INTERFACE
;; የኢትዮጵያ የምግብ ምክር ወኪል - Ethiopian Food Recommendation Agent
;;
;; This file demonstrates proper project structure:
;; - Each component is clearly separated and labeled
;; - Components are organized as if imported from separate files
;; - Shows professional multi-file project organization
;; - Features authentic Ethiopian cuisine and ingredients
;; ========================================

;; Initialize knowledge base space
!(bind! &kb (new-space))

;; ========================================
;; CORE FUNCTIONS (equivalent to importing agent.metta)
;; ========================================

;; Cast function for depth control
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; Backward chainer with proof construction
(: syn (-> Atom Nat Atom Atom))
(= (syn $kb $_ (: $prf $ccln))
   (match $kb (: $prf $ccln) (: $prf $ccln)))
(= (syn $kb (S $k) (: ($prfabs $prfarg) $ccln))
   (let* (((: $prfabs (-> $prms $ccln)) (syn $kb $k (: $prfabs (-> $prms $ccln))))
          ((: $prfarg $prms) (syn $kb $k (: $prfarg $prms))))
     (: ($prfabs $prfarg) $ccln)))

;; Note: Some complex queries may produce many results
;; For cleaner output, use simpler queries or check questions_list.md for guidance

;; ========================================
;; KNOWLEDGE BASE (equivalent to importing knowledge_base.metta)
;; Ethiopian Ingredients and Recipes - የኢትዮጵያ ምግቦች
;; ========================================

;; Available Ethiopian ingredients - ያሉ ንጥረ ነገሮች
!(add-atom &kb (: available-doro (HasIngredient doro)))           ;; Chicken - ዶሮ
!(add-atom &kb (: available-siga (HasIngredient siga)))           ;; Beef - ሥጋ
!(add-atom &kb (: available-injera (HasIngredient injera)))       ;; Injera - እንጀራ
!(add-atom &kb (: available-berbere (HasIngredient berbere)))     ;; Berbere spice - በርበሬ
!(add-atom &kb (: available-mitmita (HasIngredient mitmita)))     ;; Mitmita spice - ሚጥሚጣ
!(add-atom &kb (: available-shiro (HasIngredient shiro)))         ;; Shiro powder - ሽሮ
!(add-atom &kb (: available-gomen (HasIngredient gomen)))         ;; Collard greens - ጎመን
!(add-atom &kb (: available-atakilt (HasIngredient atakilt)))     ;; Vegetables - አታክልት
!(add-atom &kb (: available-misir (HasIngredient misir)))         ;; Lentils - ምስር
!(add-atom &kb (: available-kik (HasIngredient kik)))             ;; Split peas - ክክ
!(add-atom &kb (: available-niter-kibbeh (HasIngredient niter_kibbeh))) ;; Spiced butter - ንጥር ቅቤ
!(add-atom &kb (: available-onion (HasIngredient onion)))         ;; Onion - ሽንኩርት
!(add-atom &kb (: available-garlic (HasIngredient garlic)))       ;; Garlic - ነጭ ሽንኩርት
!(add-atom &kb (: available-ginger (HasIngredient ginger)))       ;; Ginger - ዝንጅብል

;; Ethiopian Recipe requirements - የምግብ አዘገጃጀት መስፈርቶች
;; Doro Wat (Chicken Stew) - ዶሮ ወጥ
!(add-atom &kb (: doro-wat-doro (RequiresIngredient doro_wat doro)))
!(add-atom &kb (: doro-wat-berbere (RequiresIngredient doro_wat berbere)))
!(add-atom &kb (: doro-wat-onion (RequiresIngredient doro_wat onion)))
!(add-atom &kb (: doro-wat-niter (RequiresIngredient doro_wat niter_kibbeh)))

;; Kitfo (Ethiopian Steak Tartare) - ክትፎ
!(add-atom &kb (: kitfo-siga (RequiresIngredient kitfo siga)))
!(add-atom &kb (: kitfo-mitmita (RequiresIngredient kitfo mitmita)))
!(add-atom &kb (: kitfo-niter (RequiresIngredient kitfo niter_kibbeh)))

;; Shiro Wat (Chickpea Stew) - ሽሮ ወጥ
!(add-atom &kb (: shiro-wat-shiro (RequiresIngredient shiro_wat shiro)))
!(add-atom &kb (: shiro-wat-onion (RequiresIngredient shiro_wat onion)))
!(add-atom &kb (: shiro-wat-garlic (RequiresIngredient shiro_wat garlic)))

;; Gomen (Collard Greens) - ጎመን
!(add-atom &kb (: gomen-gomen (RequiresIngredient gomen_dish gomen)))
!(add-atom &kb (: gomen-garlic (RequiresIngredient gomen_dish garlic)))
!(add-atom &kb (: gomen-ginger (RequiresIngredient gomen_dish ginger)))

;; Misir Wat (Lentil Stew) - ምስር ወጥ
!(add-atom &kb (: misir-wat-misir (RequiresIngredient misir_wat misir)))
!(add-atom &kb (: misir-wat-berbere (RequiresIngredient misir_wat berbere)))
!(add-atom &kb (: misir-wat-onion (RequiresIngredient misir_wat onion)))

;; Ethiopian Dietary information - የአመጋገብ መረጃ
!(add-atom &kb (: veg-shiro (IsVegetarian shiro)))           ;; Shiro is vegetarian
!(add-atom &kb (: veg-gomen (IsVegetarian gomen)))           ;; Collard greens are vegetarian
!(add-atom &kb (: veg-misir (IsVegetarian misir)))           ;; Lentils are vegetarian
!(add-atom &kb (: veg-kik (IsVegetarian kik)))               ;; Split peas are vegetarian
!(add-atom &kb (: veg-atakilt (IsVegetarian atakilt)))       ;; Vegetables are vegetarian
!(add-atom &kb (: veg-onion (IsVegetarian onion)))           ;; Onions are vegetarian
!(add-atom &kb (: veg-garlic (IsVegetarian garlic)))         ;; Garlic is vegetarian
!(add-atom &kb (: veg-ginger (IsVegetarian ginger)))         ;; Ginger is vegetarian
!(add-atom &kb (: veg-injera (IsVegetarian injera)))         ;; Injera is vegetarian

;; Ethiopian Ingredient properties - የንጥረ ነገር ባህሪያት
!(add-atom &kb (: protein-doro (HasProperty doro protein)))         ;; Chicken has protein
!(add-atom &kb (: protein-siga (HasProperty siga protein)))         ;; Beef has protein
!(add-atom &kb (: protein-misir (HasProperty misir protein)))       ;; Lentils have protein
!(add-atom &kb (: protein-kik (HasProperty kik protein)))           ;; Split peas have protein
!(add-atom &kb (: protein-shiro (HasProperty shiro protein)))       ;; Shiro has protein
!(add-atom &kb (: veg-gomen (HasProperty gomen vegetable)))         ;; Collard greens are vegetables
!(add-atom &kb (: veg-atakilt (HasProperty atakilt vegetable)))     ;; Mixed vegetables
!(add-atom &kb (: veg-onion (HasProperty onion vegetable)))         ;; Onions are vegetables
!(add-atom &kb (: spice-berbere (HasProperty berbere spice)))       ;; Berbere is a spice
!(add-atom &kb (: spice-mitmita (HasProperty mitmita spice)))       ;; Mitmita is a spice
!(add-atom &kb (: grain-injera (HasProperty injera grain)))         ;; Injera is grain-based

;; Ethiopian Nutritional properties of ingredients (NOT recipes - agent must reason)
;; የንጥረ ነገር የተመጋቢነት ባህሪያት
!(add-atom &kb (: doro-protein (HasNutrition doro high_protein)))     ;; Chicken has high protein
!(add-atom &kb (: siga-protein (HasNutrition siga high_protein)))     ;; Beef has high protein
!(add-atom &kb (: misir-protein (HasNutrition misir high_protein)))   ;; Lentils have high protein
!(add-atom &kb (: shiro-protein (HasNutrition shiro high_protein)))   ;; Shiro has high protein
!(add-atom &kb (: kik-protein (HasNutrition kik high_protein)))       ;; Split peas have high protein

;; Ethiopian Cooking complexity of ingredients (NOT recipes - agent must reason)
;; የማብሰያ ውስብስብነት
!(add-atom &kb (: gomen-quick (CookingComplexity gomen simple)))      ;; Collard greens are simple
!(add-atom &kb (: atakilt-quick (CookingComplexity atakilt simple)))  ;; Vegetables are simple
!(add-atom &kb (: shiro-quick (CookingComplexity shiro simple)))      ;; Shiro is simple to prepare
!(add-atom &kb (: injera-complex (CookingComplexity injera complex))) ;; Injera is complex to make
!(add-atom &kb (: berbere-quick (CookingComplexity berbere simple)))  ;; Spices are simple to use

;; Ethiopian Health properties of ingredients - የጤና ባህሪያት
!(add-atom &kb (: gomen-healthy (IsHealthy gomen)))         ;; Collard greens are healthy
!(add-atom &kb (: misir-healthy (IsHealthy misir)))         ;; Lentils are healthy
!(add-atom &kb (: atakilt-healthy (IsHealthy atakilt)))     ;; Vegetables are healthy
!(add-atom &kb (: shiro-healthy (IsHealthy shiro)))         ;; Shiro is healthy
!(add-atom &kb (: kik-healthy (IsHealthy kik)))             ;; Split peas are healthy

;; Ethiopian User preferences - የተጠቃሚ ምርጫዎች
!(add-atom &kb (: user-almaz (IsVegetarian almaz)))          ;; Almaz is vegetarian - አልማዝ
!(add-atom &kb (: user-dawit (WantsNutrition dawit high_protein))) ;; Dawit wants protein - ዳዊት
!(add-atom &kb (: user-hanan (PrefersTime hanan quick)))     ;; Hanan prefers quick meals - ሐና
!(add-atom &kb (: user-yohannes (IsVegetarian yohannes)))    ;; Yohannes is vegetarian - ዮሐንስ
!(add-atom &kb (: user-meron (WantsNutrition meron high_protein))) ;; Meron wants protein - ሜሮን

;; ========================================
;; RULES (equivalent to importing rules.metta)
;; ========================================

!(add-atom &kb (: recipe-possible-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (HasIngredient $ingredient)
            (CanMake $recipe)))))

!(add-atom &kb (: vegetarian-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (IsVegetarian $ingredient)
            (IsVegetarianRecipe $recipe)))))

!(add-atom &kb (: vegetarian-recommendation-rule
    (-> (IsVegetarian $person)
        (-> (IsVegetarianRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

!(add-atom &kb (: protein-recommendation-rule
    (-> (WantsNutrition $person high_protein)
        (-> (NutritionalValue $recipe high_protein)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

!(add-atom &kb (: time-recommendation-rule
    (-> (PrefersTime $person quick)
        (-> (CookingTime $recipe quick)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

!(add-atom &kb (: protein-availability-rule
    (-> (HasProperty $ingredient protein)
        (-> (HasIngredient $ingredient)
            (CanMakeProteinDish $ingredient)))))

!(add-atom &kb (: vegetable-availability-rule
    (-> (HasProperty $ingredient vegetable)
        (-> (HasIngredient $ingredient)
            (CanMakeVegetableDish $ingredient)))))

!(add-atom &kb (: grain-availability-rule
    (-> (HasProperty $ingredient grain)
        (-> (HasIngredient $ingredient)
            (CanMakeGrainDish $ingredient)))))

;; ETHIOPIAN REASONING RULES - Derive recipe properties from ingredient properties
;; የኢትዮጵያ አስተሳሰብ ህጎች - These rules allow the agent to reason about recipes without explicit storage

;; Rule: If a recipe's main ingredient has high protein, the recipe has high protein
!(add-atom &kb (: protein-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (HasNutrition $ingredient high_protein)
            (NutritionalValue $recipe high_protein)))))

;; Rule: If all recipe ingredients are simple to cook, the recipe is quick
!(add-atom &kb (: quick-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (CookingComplexity $ingredient simple)
            (CookingTime $recipe quick)))))

;; Rule: If a recipe uses only healthy ingredients, it's healthy
!(add-atom &kb (: healthy-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (IsHealthy $ingredient)
            (IsHealthyRecipe $recipe)))))

;; Rule: If someone wants nutrition and recipe provides it, recommend
!(add-atom &kb (: nutrition-match-rule
    (-> (WantsNutrition $person $nutrition)
        (-> (NutritionalValue $recipe $nutrition)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; Ethiopian-specific reasoning rules
;; Rule: If a recipe uses berbere or mitmita, it's spicy
!(add-atom &kb (: spicy-recipe-rule
    (-> (RequiresIngredient $recipe $spice)
        (-> (HasProperty $spice spice)
            (IsSpicy $recipe)))))

;; Rule: If someone is vegetarian and recipe is vegetarian, recommend
!(add-atom &kb (: vegetarian-match-rule
    (-> (IsVegetarian $person)
        (-> (IsVegetarianRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; Rule: Traditional Ethiopian meals are served with injera
!(add-atom &kb (: injera-serving-rule
    (-> (IsEthiopianDish $recipe)
        (ServedWith $recipe injera))))

;; Rule: Wat dishes are traditional Ethiopian stews
!(add-atom &kb (: wat-classification-rule
    (-> (ContainsName $recipe wat)
        (IsEthiopianDish $recipe))))

;; ========================================
;; USER INTERFACE - YOUR QUESTION GOES HERE
;; Copy any question from questions_list.md and paste it below
;; ========================================

!(syn &kb (fromNumber 5) (: $proof (IsHealthyRecipe gomen_dish)))
