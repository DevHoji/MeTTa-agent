;; ========================================
;; RECIPE RECOMMENDATION AGENT - KNOWLEDGE BASE
;; Comprehensive knowledge about ingredients, recipes, and cooking
;; ========================================

;; Initialize knowledge base space
!(bind! &kb (new-space))

;; ========================================
;; INGREDIENT FACTS
;; ========================================

;; Proteins
!(add-atom &kb (: protein-chicken (HasProperty chicken protein)))
!(add-atom &kb (: protein-beef (HasProperty beef protein)))
!(add-atom &kb (: protein-fish (HasProperty fish protein)))
!(add-atom &kb (: protein-eggs (HasProperty eggs protein)))
!(add-atom &kb (: protein-tofu (HasProperty tofu protein)))
!(add-atom &kb (: protein-beans (HasProperty beans protein)))
!(add-atom &kb (: protein-lentils (HasProperty lentils protein)))

;; Vegetables
!(add-atom &kb (: veg-tomato (HasProperty tomato vegetable)))
!(add-atom &kb (: veg-onion (HasProperty onion vegetable)))
!(add-atom &kb (: veg-garlic (HasProperty garlic vegetable)))
!(add-atom &kb (: veg-carrot (HasProperty carrot vegetable)))
!(add-atom &kb (: veg-broccoli (HasProperty broccoli vegetable)))
!(add-atom &kb (: veg-spinach (HasProperty spinach vegetable)))
!(add-atom &kb (: veg-bell-pepper (HasProperty bell_pepper vegetable)))
!(add-atom &kb (: veg-mushroom (HasProperty mushroom vegetable)))

;; Grains and Starches
!(add-atom &kb (: grain-rice (HasProperty rice grain)))
!(add-atom &kb (: grain-pasta (HasProperty pasta grain)))
!(add-atom &kb (: grain-bread (HasProperty bread grain)))
!(add-atom &kb (: grain-potato (HasProperty potato starch)))
!(add-atom &kb (: grain-quinoa (HasProperty quinoa grain)))

;; Dairy
!(add-atom &kb (: dairy-cheese (HasProperty cheese dairy)))
!(add-atom &kb (: dairy-milk (HasProperty milk dairy)))
!(add-atom &kb (: dairy-butter (HasProperty butter dairy)))
!(add-atom &kb (: dairy-yogurt (HasProperty yogurt dairy)))

;; Spices and Seasonings
!(add-atom &kb (: spice-salt (HasProperty salt seasoning)))
!(add-atom &kb (: spice-pepper (HasProperty pepper seasoning)))
!(add-atom &kb (: spice-basil (HasProperty basil herb)))
!(add-atom &kb (: spice-oregano (HasProperty oregano herb)))
!(add-atom &kb (: spice-thyme (HasProperty thyme herb)))
!(add-atom &kb (: spice-cumin (HasProperty cumin spice)))
!(add-atom &kb (: spice-paprika (HasProperty paprika spice)))

;; ========================================
;; RECIPE INGREDIENT RELATIONSHIPS
;; ========================================

;; Pasta Carbonara
!(add-atom &kb (: carbonara-pasta (RequiresIngredient pasta_carbonara pasta)))
!(add-atom &kb (: carbonara-eggs (RequiresIngredient pasta_carbonara eggs)))
!(add-atom &kb (: carbonara-cheese (RequiresIngredient pasta_carbonara cheese)))
!(add-atom &kb (: carbonara-pepper (RequiresIngredient pasta_carbonara pepper)))

;; Chicken Stir Fry
!(add-atom &kb (: stirfry-chicken (RequiresIngredient chicken_stirfry chicken)))
!(add-atom &kb (: stirfry-broccoli (RequiresIngredient chicken_stirfry broccoli)))
!(add-atom &kb (: stirfry-carrot (RequiresIngredient chicken_stirfry carrot)))
!(add-atom &kb (: stirfry-garlic (RequiresIngredient chicken_stirfry garlic)))
!(add-atom &kb (: stirfry-rice (RequiresIngredient chicken_stirfry rice)))

;; Vegetable Soup
!(add-atom &kb (: soup-tomato (RequiresIngredient vegetable_soup tomato)))
!(add-atom &kb (: soup-onion (RequiresIngredient vegetable_soup onion)))
!(add-atom &kb (: soup-carrot (RequiresIngredient vegetable_soup carrot)))
!(add-atom &kb (: soup-potato (RequiresIngredient vegetable_soup potato)))
!(add-atom &kb (: soup-herbs (RequiresIngredient vegetable_soup thyme)))

;; Fish Tacos
!(add-atom &kb (: tacos-fish (RequiresIngredient fish_tacos fish)))
!(add-atom &kb (: tacos-tomato (RequiresIngredient fish_tacos tomato)))
!(add-atom &kb (: tacos-onion (RequiresIngredient fish_tacos onion)))
!(add-atom &kb (: tacos-pepper (RequiresIngredient fish_tacos bell_pepper)))

;; Beef Curry
!(add-atom &kb (: curry-beef (RequiresIngredient beef_curry beef)))
!(add-atom &kb (: curry-onion (RequiresIngredient beef_curry onion)))
!(add-atom &kb (: curry-tomato (RequiresIngredient beef_curry tomato)))
!(add-atom &kb (: curry-cumin (RequiresIngredient beef_curry cumin)))
!(add-atom &kb (: curry-rice (RequiresIngredient beef_curry rice)))

;; Tofu Scramble (Vegan)
!(add-atom &kb (: scramble-tofu (RequiresIngredient tofu_scramble tofu)))
!(add-atom &kb (: scramble-spinach (RequiresIngredient tofu_scramble spinach)))
!(add-atom &kb (: scramble-mushroom (RequiresIngredient tofu_scramble mushroom)))
!(add-atom &kb (: scramble-garlic (RequiresIngredient tofu_scramble garlic)))

;; Lentil Salad
!(add-atom &kb (: salad-lentils (RequiresIngredient lentil_salad lentils)))
!(add-atom &kb (: salad-tomato (RequiresIngredient lentil_salad tomato)))
!(add-atom &kb (: salad-onion (RequiresIngredient lentil_salad onion)))
!(add-atom &kb (: salad-herbs (RequiresIngredient lentil_salad basil)))

;; ========================================
;; DIETARY RESTRICTIONS
;; ========================================

;; Vegetarian-friendly ingredients
!(add-atom &kb (: veg-friendly-tofu (IsVegetarian tofu)))
!(add-atom &kb (: veg-friendly-beans (IsVegetarian beans)))
!(add-atom &kb (: veg-friendly-lentils (IsVegetarian lentils)))
!(add-atom &kb (: veg-friendly-eggs (IsVegetarian eggs)))
!(add-atom &kb (: veg-friendly-cheese (IsVegetarian cheese)))
!(add-atom &kb (: veg-friendly-vegetables (IsVegetarian tomato)))
!(add-atom &kb (: veg-friendly-vegetables2 (IsVegetarian onion)))
!(add-atom &kb (: veg-friendly-vegetables3 (IsVegetarian carrot)))
!(add-atom &kb (: veg-friendly-vegetables4 (IsVegetarian broccoli)))
!(add-atom &kb (: veg-friendly-vegetables5 (IsVegetarian spinach)))
!(add-atom &kb (: veg-friendly-grains (IsVegetarian rice)))
!(add-atom &kb (: veg-friendly-grains2 (IsVegetarian pasta)))

;; Vegan-friendly ingredients (no dairy, no eggs)
!(add-atom &kb (: vegan-friendly-tofu (IsVegan tofu)))
!(add-atom &kb (: vegan-friendly-beans (IsVegan beans)))
!(add-atom &kb (: vegan-friendly-lentils (IsVegan lentils)))
!(add-atom &kb (: vegan-friendly-vegetables (IsVegan tomato)))
!(add-atom &kb (: vegan-friendly-vegetables2 (IsVegan onion)))
!(add-atom &kb (: vegan-friendly-vegetables3 (IsVegan carrot)))
!(add-atom &kb (: vegan-friendly-vegetables4 (IsVegan broccoli)))
!(add-atom &kb (: vegan-friendly-vegetables5 (IsVegan spinach)))
!(add-atom &kb (: vegan-friendly-grains (IsVegan rice)))
!(add-atom &kb (: vegan-friendly-grains2 (IsVegan pasta)))

;; ========================================
;; COOKING METHODS AND TIMES
;; ========================================

!(add-atom &kb (: quick-pasta (CookingTime pasta_carbonara quick)))
!(add-atom &kb (: quick-stirfry (CookingTime chicken_stirfry quick)))
!(add-atom &kb (: medium-soup (CookingTime vegetable_soup medium)))
!(add-atom &kb (: quick-tacos (CookingTime fish_tacos quick)))
!(add-atom &kb (: medium-curry (CookingTime beef_curry medium)))
!(add-atom &kb (: quick-scramble (CookingTime tofu_scramble quick)))
!(add-atom &kb (: quick-salad (CookingTime lentil_salad quick)))

;; ========================================
;; CUISINE TYPES
;; ========================================

!(add-atom &kb (: italian-pasta (CuisineType pasta_carbonara italian)))
!(add-atom &kb (: asian-stirfry (CuisineType chicken_stirfry asian)))
!(add-atom &kb (: comfort-soup (CuisineType vegetable_soup comfort)))
!(add-atom &kb (: mexican-tacos (CuisineType fish_tacos mexican)))
!(add-atom &kb (: indian-curry (CuisineType beef_curry indian)))
!(add-atom &kb (: healthy-scramble (CuisineType tofu_scramble healthy)))
!(add-atom &kb (: mediterranean-salad (CuisineType lentil_salad mediterranean)))

;; ========================================
;; NUTRITIONAL INFORMATION
;; ========================================

!(add-atom &kb (: high-protein-chicken (NutritionalValue chicken_stirfry high_protein)))
!(add-atom &kb (: high-protein-beef (NutritionalValue beef_curry high_protein)))
!(add-atom &kb (: high-protein-fish (NutritionalValue fish_tacos high_protein)))
!(add-atom &kb (: high-protein-tofu (NutritionalValue tofu_scramble high_protein)))
!(add-atom &kb (: high-protein-lentils (NutritionalValue lentil_salad high_protein)))

!(add-atom &kb (: low-carb-stirfry (NutritionalValue chicken_stirfry low_carb)))
!(add-atom &kb (: low-carb-tacos (NutritionalValue fish_tacos low_carb)))
!(add-atom &kb (: low-carb-scramble (NutritionalValue tofu_scramble low_carb)))

!(add-atom &kb (: high-fiber-soup (NutritionalValue vegetable_soup high_fiber)))
!(add-atom &kb (: high-fiber-lentils (NutritionalValue lentil_salad high_fiber)))
