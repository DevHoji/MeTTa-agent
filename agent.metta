;; ========================================
;; RECIPE RECOMMENDATION AGENT - CORE REASONING ENGINE
;; Backward chaining agent with proof construction
;; ========================================

(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))



(: syn (-> Atom Nat Atom Atom))
(= (syn $kb $_ (: $prf $ccln))
   (match $kb (: $prf $ccln) (: $prf $ccln)))
(= (syn $kb (S $k) (: ($prfabs $prfarg) $ccln))
   (let* (((: $prfabs (-> $prms $ccln)) (syn $kb $k (: $prfabs (-> $prms $ccln))))
          ((: $prfarg $prms) (syn $kb $k (: $prfarg $prms))))
     (: ($prfabs $prfarg) $ccln)))


(: findPossibleRecipes (-> Atom Nat Atom))
(= (findPossibleRecipes $ingredients $depth)
   (syn &kb $depth (: $proof (CanMake $recipe))))

(: findDietaryRecipes (-> Atom Atom Nat Atom))
(= (findDietaryRecipes $person $restriction $depth)
   (syn &kb $depth (: $proof (RecommendFor $recipe $person))))

(: findNutritionalRecipes (-> Atom Atom Nat Atom))
(= (findNutritionalRecipes $person $nutrition $depth)
   (syn &kb $depth (: $proof (RecommendFor $recipe $person))))

(: findBalancedMeals (-> Nat Atom))
(= (findBalancedMeals $depth)
   (syn &kb $depth (: $proof (HighlyRecommend balanced_meal))))


(: processRecipeQuery (-> Atom Atom Nat Atom))
(= (processRecipeQuery $query_type $parameters $depth)
   (match $query_type
     (what_can_i_make (findPossibleRecipes $parameters $depth))
     (dietary_recommendation (findDietaryRecipes $parameters dietary $depth))
     (nutritional_recommendation (findNutritionalRecipes $parameters nutrition $depth))
     (balanced_meal (findBalancedMeals $depth))))


(: explainReasoning (-> Atom Atom))
(= (explainReasoning (: $proof $conclusion))
   (match $proof
     ($rule_name (ReasoningStep $rule_name led_to $conclusion))
     (($rule1 $rule2) (ReasoningChain $rule1 then $rule2 led_to $conclusion))
     (($rule1 ($rule2 $rule3)) (ComplexReasoning $rule1 combined_with $rule2 and $rule3 led_to $conclusion))))


(: cognitiveStep (-> Atom Atom Nat Atom))
(= (cognitiveStep $current_goal $working_memory $depth)
   (let* (($matched_rule (syn &rules $depth (: $rule_proof (-> $premise $current_goal))))
          ($premise_result (syn &kb $depth (: $premise_proof $premise)))
          ($conclusion (: ($rule_proof $premise_proof) $current_goal)))
     $conclusion))

(: updateWorkingMemory (-> Atom Atom Atom))
(= (updateWorkingMemory $old_memory $new_info $updated_memory)
   (let $combined (combine $old_memory $new_info)
     $combined))


(: complexReasoning (-> Atom Nat Atom))
(= (complexReasoning $final_goal $depth)
   (let* (($step1 (syn &kb $depth (: $proof1 $intermediate_goal1)))
          ($step2 (syn &kb $depth (: $proof2 $intermediate_goal2)))
          ($final_step (syn &kb $depth (: $final_proof (-> $intermediate_goal1 (-> $intermediate_goal2 $final_goal))))))
     (: ($final_proof ($proof1 $proof2)) $final_goal)))


(: assessConfidence (-> Atom Atom))
(= (assessConfidence (: $proof $conclusion))
   (match $proof
     ($single_rule (Confidence high $conclusion))
     (($rule1 $rule2) (Confidence medium $conclusion))
     (($rule1 ($rule2 $rule3)) (Confidence low $conclusion))))


(: learnFromSuccess (-> Atom Atom Atom))
(= (learnFromSuccess $successful_recipe $user_feedback $learned_preference)
   (match $user_feedback
     (liked (StrengthenRule $successful_recipe))
     (disliked (WeakenRule $successful_recipe))
     (neutral (MaintainRule $successful_recipe))))


(: combineConstraints (-> Atom Atom Atom))
(= (combineConstraints $constraint1 $constraint2)
   (CombinedConstraint $constraint1 and $constraint2))

(: prioritizeRecommendations (-> Atom Atom))
(= (prioritizeRecommendations $recommendations)
   (match $recommendations
     ((HighlyRecommend $recipe) (Priority high $recipe))
     ((Recommend $recipe) (Priority medium $recipe))
     ((CanMake $recipe) (Priority low $recipe))))


(: recipeAgent (-> Atom Atom Nat Atom))
(= (recipeAgent $query $context $depth)
   (let* (($reasoning_result (syn &kb $depth (: $proof $query)))
          ($explanation (explainReasoning $reasoning_result))
          ($confidence (assessConfidence $reasoning_result)))
     (AgentResponse $reasoning_result $explanation $confidence)))


(: showReasoning (-> Atom Atom))
(= (showReasoning (: $proof $conclusion))
   (ReasoningTrace 
     (Goal $conclusion)
     (ProofStructure $proof)
     (RulesUsed (extractRules $proof))))

(: extractRules (-> Atom Atom))
(= (extractRules $proof)
   (match $proof
     ($rule_name (UsedRule $rule_name))
     (($rule1 $rule2) (UsedRules $rule1 $rule2))
     (($rule1 ($rule2 $rule3)) (UsedRules $rule1 $rule2 $rule3))))
     
!(syn &kb (fromNumber 5) (: $proof (NutritionalValue doro_wat high_protein)))
