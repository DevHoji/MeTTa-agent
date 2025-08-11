;; ========================================
;; RECIPE RECOMMENDATION AGENT - KNOWLEDGE BASE
;; Comprehensive knowledge about ingredients, recipes, and cooking
;; ========================================

;; Initialize knowledge base space
!(bind! &kb (new-space))

;; ========================================
;; INGREDIENT FACTS
;; ========================================

     


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

!(add-atom &kb (: misir-wat-berbere (CookingComplexity misir_wat simple)))     
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