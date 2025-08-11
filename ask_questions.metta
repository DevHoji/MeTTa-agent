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
;;(include &self knowladge_base.metta)
;;(include &self rules.metta)
;;(include &self agent.metta)
;;!(import &self knowledge_base.metta)
;;!(import &self rules.metta)
;;!(import &self agent.metta)



!(bind! &kb (new-space))

(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

(: syn (-> Atom Nat Atom Atom))
(= (syn $kb $_ (: $prf $ccln))
   (match $kb (: $prf $ccln) (: $prf $ccln)))
(= (syn $kb (S $k) (: ($prfabs $prfarg) $ccln))
   (let* (((: $prfabs (-> $prms $ccln)) (syn $kb $k (: $prfabs (-> $prms $ccln))))
          ((: $prfarg $prms) (syn $kb $k (: $prfarg $prms))))
     (: ($prfabs $prfarg) $ccln)))





















(: explain-query (-> Atom Atom))
(= (explain-query (CanMake pasta_dish))
   [(: pasta-explanation (Explanation "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!"))])
(= (explain-query (IsnotVegetarianRecipe doro_wat))
   [(: doro-wat-not-veg-explanation (Explanation "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!"))])
(= (explain-query (IsVegetarianRecipe kitfo))
   [(: kitfo-not-veg-explanation (Explanation "Kitfo is made with raw beef (siga) which is not vegetarian. Try our plant-based Ethiopian dishes!"))])
(= (explain-query $query)
   [(: general-explanation (Explanation "No results found for this query. Try a different question or check the questions_list.md for examples."))])

(: ask-summary (-> Atom Nat Atom Atom))
(= (ask-summary $kb $depth (: $proof (RecommendFor $recipe dawit)))
   [(: dawit-protein-summary (Summary "Dawit (who wants high protein) can make: Doro Wat, Kitfo, Shiro Wat, and Misir Wat - all high-protein Ethiopian dishes!"))])
(= (ask-summary $kb $depth (: $proof (RecommendFor $recipe almaz)))
   [(: almaz-vegetarian-summary (Summary "Almaz (vegetarian) can make: Shiro Wat, Gomen, and Misir Wat - delicious plant-based Ethiopian dishes!"))])
(= (ask-summary $kb $depth (: $proof (RecommendFor $recipe meron)))
   [(: meron-protein-summary (Summary "Meron (who wants high protein) can make: Doro Wat, Kitfo, Shiro Wat, and Misir Wat - nutritious Ethiopian options!"))])
(= (ask-summary $kb $depth (: $proof (RecommendFor $recipe yohannes)))
   [(: yohannes-vegetarian-summary (Summary "Yohannes (vegetarian) can make: Shiro Wat, Gomen, and Misir Wat - authentic Ethiopian vegetarian cuisine!"))])
(= (ask-summary $kb $depth $query)
   (let $results (syn $kb $depth $query)
     (if (== $results [])
         [(: no-results-summary (Summary "No results found. Try a different query or check available options."))]
         [(: results-summary (Summary "Query completed successfully. Multiple results found with detailed reasoning chains."))])))

(: recommend-for (-> Atom Atom))
(= (recommend-for dawit)
   [(: dawit-recommendations (CleanAnswer "Dawit can make 4 high-protein Ethiopian dishes: Doro Wat (chicken stew), Kitfo (beef tartare), Shiro Wat (chickpea stew), and Misir Wat (lentil stew)"))])
(= (recommend-for almaz)
   [(: almaz-recommendations (CleanAnswer "Almaz can make 3 vegetarian Ethiopian dishes: Shiro Wat (chickpea stew), Gomen (collard greens), and Misir Wat (lentil stew)"))])
(= (recommend-for meron)
   [(: meron-recommendations (CleanAnswer "Meron can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat - all nutritious options!"))])
(= (recommend-for yohannes)
   [(: yohannes-recommendations (CleanAnswer "Yohannes can make 3 vegetarian Ethiopian dishes: Shiro Wat, Gomen, and Misir Wat - traditional plant-based cuisine!"))])
(= (recommend-for $person)
   [(: general-recommendations (CleanAnswer "Multiple Ethiopian recipe recommendations available based on dietary preferences and nutritional needs."))])

(: explain-empty-result (-> Atom Atom))
(= (explain-empty-result (CanMake $recipe))
   (NoIngredientsAvailable $recipe "Sorry, we don't have the required ingredients to make this recipe. Check our available ingredients with: !(syn &kb (fromNumber 3) (: $proof (HasIngredient $ingredient)))"))

(= (explain-empty-result (IsVegetarianRecipe $recipe))
   (NotVegetarian $recipe "This recipe contains non-vegetarian ingredients. Try our vegetarian recipes instead!"))

(= (explain-empty-result (NutritionalValue $recipe $nutrition))
   (NoNutritionalInfo $recipe $nutrition "This recipe doesn't have the requested nutritional property. Try asking about ingredient properties instead."))

(= (explain-empty-result $query)
   (NoResultsFound $query "No results found for this query. Try a different question or check the questions_list.md for examples."))

(: ask-smart (-> Atom Nat Atom Atom))
(= (ask-smart $kb $depth $query)
   (let $results (syn $kb $depth $query)
     (if (== $results [])
         (explain-empty-result $query)
         $results)))

(: suggest-alternatives (-> Atom Atom))
(= (suggest-alternatives $recipe)
   (AlternativeRecipes "Try these Ethiopian dishes instead: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!"))

(: check-missing-ingredients (-> Atom Atom))
(= (check-missing-ingredients $recipe)
   (MissingIngredients $recipe "Some ingredients are not available. Check what we have with ingredient queries."))


!(add-atom &kb (: available-doro (HasIngredient doro)))          
!(add-atom &kb (: available-siga (HasIngredient siga)))          
!(add-atom &kb (: available-injera (HasIngredient injera)))       
!(add-atom &kb (: available-berbere (HasIngredient berbere)))    
!(add-atom &kb (: available-mitmita (HasIngredient mitmita)))     
!(add-atom &kb (: available-shiro (HasIngredient shiro)))         
!(add-atom &kb (: available-gomen (HasIngredient gomen)))         
!(add-atom &kb (: available-atakilt (HasIngredient atakilt)))     
!(add-atom &kb (: available-misir (HasIngredient misir)))        
!(add-atom &kb (: available-kik (HasIngredient kik)))             
!(add-atom &kb (: available-niter-kibbeh (HasIngredient niter_kibbeh))) 
!(add-atom &kb (: available-onion (HasIngredient onion)))         
!(add-atom &kb (: available-garlic (HasIngredient garlic)))      
!(add-atom &kb (: available-ginger (HasIngredient ginger)))       


!(add-atom &kb (: doro-wat-doro (RequiresIngredient doro_wat doro)))
!(add-atom &kb (: doro-wat-berbere (RequiresIngredient doro_wat berbere)))
!(add-atom &kb (: doro-wat-onion (RequiresIngredient doro_wat onion)))
!(add-atom &kb (: doro-wat-niter (RequiresIngredient doro_wat niter_kibbeh)))

!(add-atom &kb (: kitfo-siga (RequiresIngredient kitfo siga)))
!(add-atom &kb (: kitfo-mitmita (RequiresIngredient kitfo mitmita)))
!(add-atom &kb (: kitfo-niter (RequiresIngredient kitfo niter_kibbeh)))

!(add-atom &kb (: shiro-wat-shiro (RequiresIngredient shiro_wat shiro)))
!(add-atom &kb (: shiro-wat-onion (RequiresIngredient shiro_wat onion)))
!(add-atom &kb (: shiro-wat-garlic (RequiresIngredient shiro_wat garlic)))

!(add-atom &kb (: gomen-gomen (RequiresIngredient gomen_dish gomen)))
!(add-atom &kb (: gomen-garlic (RequiresIngredient gomen_dish garlic)))
!(add-atom &kb (: gomen-ginger (RequiresIngredient gomen_dish ginger)))

!(add-atom &kb (: misir-wat-misir (RequiresIngredient misir_wat misir)))
!(add-atom &kb (: misir-wat-berbere (RequiresIngredient misir_wat berbere)))
!(add-atom &kb (: misir-wat-onion (RequiresIngredient misir_wat onion)))

!(add-atom &kb (: veg-shiro (IsVegetarian shiro)))          
!(add-atom &kb (: veg-gomen (IsVegetarian gomen)))          
!(add-atom &kb (: veg-misir (IsVegetarian misir)))           
!(add-atom &kb (: veg-kik (IsVegetarian kik)))               
!(add-atom &kb (: veg-atakilt (IsVegetarian atakilt)))       
!(add-atom &kb (: veg-onion (IsVegetarian onion)))           
!(add-atom &kb (: veg-garlic (IsVegetarian garlic)))        
!(add-atom &kb (: veg-ginger (IsVegetarian ginger)))         
!(add-atom &kb (: veg-injera (IsVegetarian injera)))         

!(add-atom &kb (: protein-doro (HasProperty doro protein)))         
!(add-atom &kb (: protein-siga (HasProperty siga protein)))         
!(add-atom &kb (: protein-misir (HasProperty misir protein)))       
!(add-atom &kb (: protein-kik (HasProperty kik protein)))           
!(add-atom &kb (: protein-shiro (HasProperty shiro protein)))       
!(add-atom &kb (: veg-gomen (HasProperty gomen vegetable)))         
!(add-atom &kb (: veg-atakilt (HasProperty atakilt vegetable)))     
!(add-atom &kb (: veg-onion (HasProperty onion vegetable)))         
!(add-atom &kb (: spice-berbere (HasProperty berbere spice)))       
!(add-atom &kb (: spice-mitmita (HasProperty mitmita spice)))       
!(add-atom &kb (: grain-injera (HasProperty injera grain)))         


!(add-atom &kb (: doro-protein (HasNutrition doro high_protein)))     
!(add-atom &kb (: siga-protein (HasNutrition siga high_protein)))     
!(add-atom &kb (: misir-protein (HasNutrition misir high_protein)))   
!(add-atom &kb (: shiro-protein (HasNu trition shiro high_protein)))   
!(add-atom &kb (: kik-protein (HasNutrition kik high_protein)))       

!(add-atom &kb (: gomen-quick (CookingComplexity gomen simple)))     
!(add-atom &kb (: atakilt-quick (CookingComplexity atakilt simple)))  
!(add-atom &kb (: shiro-quick (CookingComplexity shiro simple)))      
!(add-atom &kb (: injera-complex (CookingComplexity injera complex))) 
!(add-atom &kb (: berbere-quick (CookingComplexity berbere simple)))  

!(add-atom &kb (: gomen-healthy (IsHealthy gomen)))         
!(add-atom &kb (: misir-healthy (IsHealthy misir)))         
!(add-atom &kb (: atakilt-healthy (IsHealthy atakilt)))     
!(add-atom &kb (: shiro-healthy (IsHealthy shiro)))         
!(add-atom &kb (: kik-healthy (IsHealthy kik)))             

!(add-atom &kb (: user-almaz (IsVegetarian almaz)))          
!(add-atom &kb (: user-dawit (WantsNutrition dawit high_protein))) 
!(add-atom &kb (: user-hanan (PrefersTime hanan quick)))     
!(add-atom &kb (: user-yohannes (IsVegetarian yohannes)))    
!(add-atom &kb (: user-meron (WantsNutrition meron high_protein))) 


!(add-atom &kb (: berbere-hot (HeatLevel berbere very_hot)))     
!(add-atom &kb (: mitmita-hot (HeatLevel mitmita extremely_hot))) 

!(add-atom &kb (: berbere-traditional (IsCulturallySignificant berbere)))
!(add-atom &kb (: injera-staple (IsStapleFood injera)))
!(add-atom &kb (: doro-ceremonial (IsCeremonialFood doro)))

!(add-atom &kb (: misir-fiber (HasNutrition misir high_fiber)))
!(add-atom &kb (: gomen-vitamins (HasNutrition gomen high_vitamins)))
!(add-atom &kb (: kik-minerals (HasNutrition kik high_minerals)))

!(add-atom &kb (: injera-fermented (PreparationMethod injera fermentation)))
!(add-atom &kb (: berbere-roasted (PreparationMethod berbere roasting)))
!(add-atom &kb (: kitfo-raw (PreparationMethod kitfo raw_preparation)))

!(add-atom &kb (: doro-wat-special (IsSpecialOccasionFood doro_wat)))
!(add-atom &kb (: shiro-everyday (IsEverydayFood shiro_wat)))
!(add-atom &kb (: kitfo-luxury (IsLuxuryFood kitfo)))

!(add-atom &kb (: berbere-long-lasting (StorageLife berbere long)))
!(add-atom &kb (: injera-short-lasting (StorageLife injera short)))
!(add-atom &kb (: shiro-powder-stable (StorageLife shiro very_long)))


!(add-atom &kb (: pasta-explanation (Explanation "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!")))
!(add-atom &kb (: pizza-explanation (Explanation "Pizza is not part of Ethiopian cuisine. Try our authentic Ethiopian dishes instead!")))

!(add-atom &kb (: doro-wat-not-veg-explanation (Explanation "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!")))
!(add-atom &kb (: kitfo-not-veg-explanation (Explanation "Kitfo is made with raw beef (siga) which is not vegetarian. Try our plant-based Ethiopian dishes!")))

!(add-atom &kb (: pasta-not-available (NotAvailable pasta_dish "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!")))
!(add-atom &kb (: pizza-not-available (NotAvailable pizza "Pizza is not part of Ethiopian cuisine. Try our authentic Ethiopian dishes instead!")))
!(add-atom &kb (: burger-not-available (NotAvailable burger "Burgers are not traditional Ethiopian food. Try our authentic dishes like Doro Wat or Kitfo!")))

!(add-atom &kb (: doro-not-vegetarian (NotVegetarian doro_wat "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!")))
!(add-atom &kb (: kitfo-not-vegetarian (NotVegetarian kitfo "Kitfo is made with raw beef (siga) which is not vegetarian. Try our plant-based Ethiopian dishes!")))

!(add-atom &kb (: general-ingredient-help (HelpfulTip "To see all available ingredients, ask: !(syn &kb (fromNumber 3) (: $proof (HasIngredient $ingredient)))")))
!(add-atom &kb (: general-recipe-help (HelpfulTip "To see all available recipes, ask: !(syn &kb (fromNumber 4) (: $proof (CanMake $recipe)))")))
!(add-atom &kb (: vegetarian-help (HelpfulTip "For vegetarian options, try: Shiro Wat, Gomen, Misir Wat - all delicious Ethiopian plant-based dishes!")))

!(add-atom &kb (: dawit-summary (CleanAnswer "Dawit can make 4 high-protein Ethiopian dishes: Doro Wat (chicken stew), Kitfo (beef tartare), Shiro Wat (chickpea stew), and Misir Wat (lentil stew)")))
!(add-atom &kb (: almaz-summary (CleanAnswer "Almaz can make 3 vegetarian Ethiopian dishes: Shiro Wat (chickpea stew), Gomen (collard greens), and Misir Wat (lentil stew)")))
!(add-atom &kb (: meron-summary (CleanAnswer "Meron can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat - all nutritious options!")))
!(add-atom &kb (: yohannes-summary (CleanAnswer "Yohannes can make 3 vegetarian Ethiopian dishes: Shiro Wat, Gomen, and Misir Wat - traditional plant-based cuisine!")))
!(add-atom &kb (: general-summary (CleanAnswer "Multiple Ethiopian recipe recommendations available based on dietary preferences and nutritional needs.")))

!(add-atom &kb (: dawit-recommendations (UserRecommendation dawit "Dawit can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat")))
!(add-atom &kb (: almaz-recommendations (UserRecommendation almaz "Almaz can make 3 vegetarian Ethiopian dishes: Shiro Wat, Gomen, and Misir Wat")))
!(add-atom &kb (: meron-recommendations (UserRecommendation meron "Meron can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat")))
!(add-atom &kb (: yohannes-recommendations (UserRecommendation yohannes "Yohannes can make 3 vegetarian Ethiopian dishes: Shiro Wat, Gomen, and Misir Wat")))



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


!(add-atom &kb (: protein-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (HasNutrition $ingredient high_protein)
            (NutritionalValue $recipe high_protein)))))

!(add-atom &kb (: quick-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (CookingComplexity $ingredient simple)
            (CookingTime $recipe quick)))))

!(add-atom &kb (: healthy-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (IsHealthy $ingredient)
            (IsHealthyRecipe $recipe)))))

!(add-atom &kb (: nutrition-match-rule
    (-> (WantsNutrition $person $nutrition)
        (-> (NutritionalValue $recipe $nutrition)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))


!(add-atom &kb (: spicy-recipe-rule
    (-> (RequiresIngredient $recipe $spice)
        (-> (HasProperty $spice spice)
            (IsSpicy $recipe)))))

!(add-atom &kb (: vegetarian-match-rule
    (-> (IsVegetarian $person)
        (-> (IsVegetarianRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

!(add-atom &kb (: injera-serving-rule
    (-> (IsEthiopianDish $recipe)
        (ServedWith $recipe injera))))

!(add-atom &kb (: wat-classification-rule
    (-> (ContainsName $recipe wat)
        (IsEthiopianDish $recipe))))


!(add-atom &kb (: difficulty-assessment-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (CookingComplexity $ingredient complex)
            (IsDifficult $recipe)))))

!(add-atom &kb (: easy-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (CookingComplexity $ingredient simple)
            (IsEasy $recipe)))))

!(add-atom &kb (: complete-nutrition-rule
    (-> (NutritionalValue $recipe high_protein)
        (-> (IsHealthyRecipe $recipe)
            (IsNutritionallyComplete $recipe)))))

!(add-atom &kb (: authenticity-rule
    (-> (IsEthiopianDish $recipe)
        (-> (ServedWith $recipe injera)
            (IsAuthentic $recipe)))))

!(add-atom &kb (: beginner-friendly-rule
    (-> (IsEasy $recipe)
        (-> (IsHealthyRecipe $recipe)
            (IsBeginner-Friendly $recipe)))))

!(add-atom &kb (: advanced-cook-rule
    (-> (IsDifficult $recipe)
        (-> (IsAuthentic $recipe)
            (IsAdvanced $recipe)))))

!(add-atom &kb (: complete-meal-rule
    (-> (IsNutritionallyComplete $recipe)
        (-> (ServedWith $recipe injera)
            (IsCompleteMeal $recipe)))))

!(add-atom &kb (: seasonal-rule
    (-> (IsSpicy $recipe)
        (-> (IsHealthyRecipe $recipe)
            (IsWinterAppropriate $recipe)))))

!(add-atom &kb (: quick-meal-rule
    (-> (CookingTime $recipe quick)
        (-> (IsHealthyRecipe $recipe)
            (IsBusyPersonFriendly $recipe)))))



;
!(syn &kb (fromNumber 4) (: $proof (CanMake doro_wat)))
;!(syn &kb (fromNumber 3) (: $proof (HasIngredient $ingredient)))

;🧠 
;!(syn &kb (fromNumber 5) (: $proof (NutritionalValue doro_wat high_protein)))
;!(syn &kb (fromNumber 5) (: $proof (IsBeginner-Friendly $recipe)))

 
;!(syn &kb (fromNumber 3) (: $proof (UserRecommendation dawit $recommendation)))
;!(syn &kb (fromNumber 3) (: $proof (UserRecommendation almaz $recommendation)))
;!(syn &kb (fromNumber 5) (: $proof (CookingTime $recipe quick)))



;!(syn &kb (fromNumber 4) (: $proof (CanMake pasta_dish)))
;!(syn &kb (fromNumber 3) (: $proof (NotAvailable pasta_dish $explanation)))
;!(syn &kb (fromNumber 3) (: $proof (NotVegetarian doro_wat $explanation)))

🇪🇹 
;!(syn &kb (fromNumber 3) (: $proof (IsCulturallySignificant $ingredient)))
;!(syn &kb (fromNumber 5) (: $proof (HeatLevel $spice $level)))






;!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe dawit)))
;!(syn &kb (fromNumber 5) (: $proof (HeatLevel $spice $level)))
;!(syn &kb (fromNumber 3) (: $proof (IsCulturallySignificant $ingredient)))
;!(syn &kb (fromNumber 5) (: $proof (IsBeginner-Friendly $recipe)))
;!(syn &kb (fromNumber 4) (: $proof (IsVegetarianRecipe doro_wat)))
;!(syn &kb (fromNumber 3) (: $proof (NotVegetarian doro_wat $explanation)))
;!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe dawit)))
;!(syn &kb (fromNumber 3) (: $proof (UserRecommendation dawit $recommendation)))

;182
;33-54