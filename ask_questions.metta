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

;; Simple explanation lookup function
(: explain-query (-> Atom Atom))
(= (explain-query (CanMake pasta_dish))
   [(: pasta-explanation (Explanation "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!"))])
(= (explain-query (IsVegetarianRecipe doro_wat))
   [(: doro-wat-not-veg-explanation (Explanation "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!"))])
(= (explain-query (IsVegetarianRecipe kitfo))
   [(: kitfo-not-veg-explanation (Explanation "Kitfo is made with raw beef (siga) which is not vegetarian. Try our plant-based Ethiopian dishes!"))])
(= (explain-query $query)
   [(: general-explanation (Explanation "No results found for this query. Try a different question or check the questions_list.md for examples."))])

;; Enhanced user-friendly response functions
(: explain-empty-result (-> Atom Atom))
(= (explain-empty-result (CanMake $recipe))
   (NoIngredientsAvailable $recipe "Sorry, we don't have the required ingredients to make this recipe. Check our available ingredients with: !(syn &kb (fromNumber 3) (: $proof (HasIngredient $ingredient)))"))

(= (explain-empty-result (IsVegetarianRecipe $recipe))
   (NotVegetarian $recipe "This recipe contains non-vegetarian ingredients. Try our vegetarian recipes instead!"))

(= (explain-empty-result (NutritionalValue $recipe $nutrition))
   (NoNutritionalInfo $recipe $nutrition "This recipe doesn't have the requested nutritional property. Try asking about ingredient properties instead."))

(= (explain-empty-result $query)
   (NoResultsFound $query "No results found for this query. Try a different question or check the questions_list.md for examples."))

;; Enhanced query function with intelligent responses
(: ask-smart (-> Atom Nat Atom Atom))
(= (ask-smart $kb $depth $query)
   (let $results (syn $kb $depth $query)
     (if (== $results [])
         (explain-empty-result $query)
         $results)))

;; Recipe suggestion system
(: suggest-alternatives (-> Atom Atom))
(= (suggest-alternatives $recipe)
   (AlternativeRecipes "Try these Ethiopian dishes instead: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!"))

;; Ingredient availability checker
(: check-missing-ingredients (-> Atom Atom))
(= (check-missing-ingredients $recipe)
   (MissingIngredients $recipe "Some ingredients are not available. Check what we have with ingredient queries."))

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

;; ENHANCED CULTURAL AND NUTRITIONAL KNOWLEDGE - የላቀ ባህላዊ እና የተመጋቢነት እውቀት
;; Advanced ingredient properties for sophisticated reasoning

;; Spice heat levels - የቅመማ ቅመም ሙቀት ደረጃዎች
!(add-atom &kb (: berbere-hot (HeatLevel berbere very_hot)))     ;; Berbere is very hot
!(add-atom &kb (: mitmita-hot (HeatLevel mitmita extremely_hot))) ;; Mitmita is extremely hot

;; Ingredient origins and cultural significance - የንጥረ ነገር ምንጮች እና ባህላዊ ጠቀሜታ
!(add-atom &kb (: berbere-traditional (IsCulturallySignificant berbere)))
!(add-atom &kb (: injera-staple (IsStapleFood injera)))
!(add-atom &kb (: doro-ceremonial (IsCeremonialFood doro)))

;; Nutritional density and health benefits - የተመጋቢነት ጥግግት እና የጤና ጥቅሞች
!(add-atom &kb (: misir-fiber (HasNutrition misir high_fiber)))
!(add-atom &kb (: gomen-vitamins (HasNutrition gomen high_vitamins)))
!(add-atom &kb (: kik-minerals (HasNutrition kik high_minerals)))

;; Cooking techniques and preparation methods - የማብሰያ ዘዴዎች እና የዝግጅት ዘዴዎች
!(add-atom &kb (: injera-fermented (PreparationMethod injera fermentation)))
!(add-atom &kb (: berbere-roasted (PreparationMethod berbere roasting)))
!(add-atom &kb (: kitfo-raw (PreparationMethod kitfo raw_preparation)))

;; Meal timing and cultural context - የምግብ ጊዜ እና ባህላዊ አውድ
!(add-atom &kb (: doro-wat-special (IsSpecialOccasionFood doro_wat)))
!(add-atom &kb (: shiro-everyday (IsEverydayFood shiro_wat)))
!(add-atom &kb (: kitfo-luxury (IsLuxuryFood kitfo)))

;; Storage and preservation properties - የማከማቻ እና የመጠበቂያ ባህሪያት
!(add-atom &kb (: berbere-long-lasting (StorageLife berbere long)))
!(add-atom &kb (: injera-short-lasting (StorageLife injera short)))
!(add-atom &kb (: shiro-powder-stable (StorageLife shiro very_long)))

;; EXPLANATION FACTS - User-friendly explanations for empty results
;; የማብራሪያ እውነታዎች - ለባዶ ውጤቶች ተጠቃሚ ተስማሚ ማብራሪያዎች

;; Explanations for unavailable recipes - instead of empty []
!(add-atom &kb (: pasta-explanation (Explanation "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!")))
!(add-atom &kb (: pizza-explanation (Explanation "Pizza is not part of Ethiopian cuisine. Try our authentic Ethiopian dishes instead!")))

;; Explanations for non-vegetarian recipes - instead of empty []
!(add-atom &kb (: doro-wat-not-veg-explanation (Explanation "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!")))
!(add-atom &kb (: kitfo-not-veg-explanation (Explanation "Kitfo is made with raw beef (siga) which is not vegetarian. Try our plant-based Ethiopian dishes!")))

;; Enhanced explanation system: Add negative facts that provide helpful explanations
!(add-atom &kb (: pasta-not-available (NotAvailable pasta_dish "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!")))
!(add-atom &kb (: pizza-not-available (NotAvailable pizza "Pizza is not part of Ethiopian cuisine. Try our authentic Ethiopian dishes instead!")))
!(add-atom &kb (: burger-not-available (NotAvailable burger "Burgers are not traditional Ethiopian food. Try our authentic dishes like Doro Wat or Kitfo!")))

!(add-atom &kb (: doro-not-vegetarian (NotVegetarian doro_wat "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!")))
!(add-atom &kb (: kitfo-not-vegetarian (NotVegetarian kitfo "Kitfo is made with raw beef (siga) which is not vegetarian. Try our plant-based Ethiopian dishes!")))

;; General helpful explanations
!(add-atom &kb (: general-ingredient-help (HelpfulTip "To see all available ingredients, ask: !(syn &kb (fromNumber 3) (: $proof (HasIngredient $ingredient)))")))
!(add-atom &kb (: general-recipe-help (HelpfulTip "To see all available recipes, ask: !(syn &kb (fromNumber 4) (: $proof (CanMake $recipe)))")))
!(add-atom &kb (: vegetarian-help (HelpfulTip "For vegetarian options, try: Shiro Wat, Gomen, Misir Wat - all delicious Ethiopian plant-based dishes!")))

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

;; ADVANCED ENHANCEMENT RULES - Making the agent more intelligent
;; የላቀ ማሻሻያ ህጎች

;; Rule: Recipe difficulty assessment based on ingredient complexity
!(add-atom &kb (: difficulty-assessment-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (CookingComplexity $ingredient complex)
            (IsDifficult $recipe)))))

;; Rule: Recipe is easy if all ingredients are simple
!(add-atom &kb (: easy-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (CookingComplexity $ingredient simple)
            (IsEasy $recipe)))))

;; Rule: Nutritional completeness - recipes with multiple nutrition types
!(add-atom &kb (: complete-nutrition-rule
    (-> (NutritionalValue $recipe high_protein)
        (-> (IsHealthyRecipe $recipe)
            (IsNutritionallyComplete $recipe)))))

;; Rule: Cultural authenticity - traditional Ethiopian dishes
!(add-atom &kb (: authenticity-rule
    (-> (IsEthiopianDish $recipe)
        (-> (ServedWith $recipe injera)
            (IsAuthentic $recipe)))))

;; Rule: Beginner-friendly recommendations
!(add-atom &kb (: beginner-friendly-rule
    (-> (IsEasy $recipe)
        (-> (IsHealthyRecipe $recipe)
            (IsBeginner-Friendly $recipe)))))

;; Rule: Advanced cook recommendations
!(add-atom &kb (: advanced-cook-rule
    (-> (IsDifficult $recipe)
        (-> (IsAuthentic $recipe)
            (IsAdvanced $recipe)))))

;; Rule: Meal planning - complete meal suggestions
!(add-atom &kb (: complete-meal-rule
    (-> (IsNutritionallyComplete $recipe)
        (-> (ServedWith $recipe injera)
            (IsCompleteMeal $recipe)))))

;; Rule: Seasonal appropriateness (spicy for cold weather)
!(add-atom &kb (: seasonal-rule
    (-> (IsSpicy $recipe)
        (-> (IsHealthyRecipe $recipe)
            (IsWinterAppropriate $recipe)))))

;; Rule: Quick meal recommendations for busy people
!(add-atom &kb (: quick-meal-rule
    (-> (CookingTime $recipe quick)
        (-> (IsHealthyRecipe $recipe)
            (IsBusyPersonFriendly $recipe)))))

;; ========================================
;; USER INTERFACE - YOUR QUESTION GOES HERE
;; Copy any question from questions_list.md and paste it below
;; ========================================

!(syn &kb (fromNumber 4) (: $proof (CanMake doro_wat)))
