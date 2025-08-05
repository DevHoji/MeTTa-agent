;; ========================================
;; RECIPE RECOMMENDATION AGENT - RULES
;; Logical rules for recipe recommendation and dietary reasoning
;; ========================================

;; Initialize rules space
!(bind! &rules (new-space))

;; ========================================
;; BASIC RECIPE RECOMMENDATION RULES
;; ========================================

;; Rule: If a recipe requires an ingredient and we have that ingredient, 
;; then the recipe is possible
!(add-atom &rules (: recipe-possible-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (HasIngredient $ingredient)
            (CanMake $recipe)))))

;; Rule: If we can make a recipe and it matches our cuisine preference,
;; then we should recommend it
!(add-atom &rules (: cuisine-recommendation-rule
    (-> (CanMake $recipe)
        (-> (CuisineType $recipe $cuisine)
            (-> (PrefersCuisine $cuisine)
                (Recommend $recipe))))))

;; Rule: If we can make a recipe and it matches our cooking time preference,
;; then we should recommend it
!(add-atom &rules (: time-recommendation-rule
    (-> (CanMake $recipe)
        (-> (CookingTime $recipe $time)
            (-> (PrefersTime $time)
                (Recommend $recipe))))))

;; ========================================
;; DIETARY RESTRICTION RULES
;; ========================================

;; Rule: If a recipe requires only vegetarian ingredients, it's vegetarian-safe
!(add-atom &rules (: vegetarian-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (IsVegetarian $ingredient)
            (-> (AllIngredientsVegetarian $recipe)
                (IsVegetarianRecipe $recipe))))))

;; Rule: If a recipe requires only vegan ingredients, it's vegan-safe
!(add-atom &rules (: vegan-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (IsVegan $ingredient)
            (-> (AllIngredientsVegan $recipe)
                (IsVeganRecipe $recipe))))))

;; Rule: If someone is vegetarian and a recipe is vegetarian-safe, recommend it
!(add-atom &rules (: vegetarian-recommendation-rule
    (-> (IsVegetarian $person)
        (-> (IsVegetarianRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; Rule: If someone is vegan and a recipe is vegan-safe, recommend it
!(add-atom &rules (: vegan-recommendation-rule
    (-> (IsVegan $person)
        (-> (IsVeganRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; ========================================
;; NUTRITIONAL PREFERENCE RULES
;; ========================================

;; Rule: If someone wants high protein and a recipe provides it, recommend it
!(add-atom &rules (: protein-recommendation-rule
    (-> (WantsNutrition $person high_protein)
        (-> (NutritionalValue $recipe high_protein)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; Rule: If someone wants low carb and a recipe provides it, recommend it
!(add-atom &rules (: lowcarb-recommendation-rule
    (-> (WantsNutrition $person low_carb)
        (-> (NutritionalValue $recipe low_carb)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; Rule: If someone wants high fiber and a recipe provides it, recommend it
!(add-atom &rules (: fiber-recommendation-rule
    (-> (WantsNutrition $person high_fiber)
        (-> (NutritionalValue $recipe high_fiber)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; ========================================
;; INGREDIENT AVAILABILITY RULES
;; ========================================

;; Rule: If we have a protein ingredient, we can make protein-based recipes
!(add-atom &rules (: protein-availability-rule
    (-> (HasProperty $ingredient protein)
        (-> (HasIngredient $ingredient)
            (CanMakeProteinDish $ingredient)))))

;; Rule: If we have vegetables, we can make vegetable-based recipes
!(add-atom &rules (: vegetable-availability-rule
    (-> (HasProperty $ingredient vegetable)
        (-> (HasIngredient $ingredient)
            (CanMakeVegetableDish $ingredient)))))

;; Rule: If we have grains, we can make grain-based recipes
!(add-atom &rules (: grain-availability-rule
    (-> (HasProperty $ingredient grain)
        (-> (HasIngredient $ingredient)
            (CanMakeGrainDish $ingredient)))))

;; ========================================
;; COMPLEX REASONING RULES
;; ========================================

;; Rule: If we can make both protein and vegetable dishes with available ingredients,
;; we can make a balanced meal
!(add-atom &rules (: balanced-meal-rule
    (-> (CanMakeProteinDish $protein)
        (-> (CanMakeVegetableDish $vegetable)
            (-> (CanMakeGrainDish $grain)
                (CanMakeBalancedMeal $protein $vegetable $grain))))))

;; Rule: If we can make a balanced meal, it's highly recommended
!(add-atom &rules (: balanced-meal-recommendation-rule
    (-> (CanMakeBalancedMeal $protein $vegetable $grain)
        (HighlyRecommend balanced_meal))))

;; ========================================
;; SUBSTITUTION RULES
;; ========================================

;; Rule: If we don't have a specific protein but have another protein,
;; we can substitute in many recipes
!(add-atom &rules (: protein-substitution-rule
    (-> (RequiresIngredient $recipe $missing_protein)
        (-> (HasProperty $missing_protein protein)
            (-> (HasProperty $available_protein protein)
                (-> (HasIngredient $available_protein)
                    (CanSubstitute $recipe $missing_protein $available_protein)))))))

;; Rule: If we can substitute ingredients, we can still make the recipe
!(add-atom &rules (: substitution-enables-recipe-rule
    (-> (CanSubstitute $recipe $missing $available)
        (-> (HasAllOtherIngredients $recipe $missing)
            (CanMakeWithSubstitution $recipe $missing $available)))))

;; ========================================
;; SEASONAL AND FRESHNESS RULES
;; ========================================

;; Rule: If ingredients are fresh and in season, prioritize recipes using them
!(add-atom &rules (: fresh-ingredient-priority-rule
    (-> (IsFresh $ingredient)
        (-> (RequiresIngredient $recipe $ingredient)
            (-> (CanMake $recipe)
                (PriorityRecommend $recipe))))))

;; Rule: If multiple recipes are possible, prefer the one with fresher ingredients
!(add-atom &rules (: freshness-preference-rule
    (-> (CanMake $recipe1)
        (-> (CanMake $recipe2)
            (-> (HasFresherIngredients $recipe1 $recipe2)
                (PreferRecipe $recipe1 $recipe2))))))

;; ========================================
;; SKILL LEVEL RULES
;; ========================================

;; Rule: If someone is a beginner cook, recommend quick and easy recipes
!(add-atom &rules (: beginner-recommendation-rule
    (-> (SkillLevel $person beginner)
        (-> (CookingTime $recipe quick)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; Rule: If someone is an advanced cook, they can handle complex recipes
!(add-atom &rules (: advanced-cook-rule
    (-> (SkillLevel $person advanced)
        (-> (ComplexityLevel $recipe complex)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))

;; ========================================
;; MEAL PLANNING RULES
;; ========================================

;; Rule: If planning multiple meals, ensure variety in cuisine types
!(add-atom &rules (: variety-planning-rule
    (-> (PlanningMeals $person multiple)
        (-> (CuisineType $recipe1 $cuisine1)
            (-> (CuisineType $recipe2 $cuisine2)
                (-> (Different $cuisine1 $cuisine2)
                    (EnsureVariety $recipe1 $recipe2)))))))

;; Rule: If planning weekly meals, balance nutritional content
!(add-atom &rules (: weekly-balance-rule
    (-> (PlanningPeriod weekly)
        (-> (NutritionalValue $recipe1 high_protein)
            (-> (NutritionalValue $recipe2 high_fiber)
                (-> (NutritionalValue $recipe3 low_carb)
                    (WeeklyBalanced $recipe1 $recipe2 $recipe3)))))))
