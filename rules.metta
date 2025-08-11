
;; Initialize rules space
!(bind! &rules (new-space))

;; ========================================
;; BASIC RECIPE RECOMMENDATION RULES
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