# Ethiopian Recipe Recommendation Agent - Cognitive Architecture Implementation 🇪🇹

## Overview

This project implements an **Ethiopian Recipe Recommendation Agent** using **symbolic cognitive architecture** principles with **backward chaining** reasoning. The agent demonstrates key concepts from cognitive architectures like ACT-R and Soar, implemented in the MeTTa programming language with deep knowledge of Ethiopian cuisine.

## Cognitive Architecture Type

**Symbolic Cognitive Architecture for Ethiopian Cuisine** - The agent uses:
- Rule-based reasoning with explicit logical rules for Ethiopian recipes
- Declarative knowledge (facts about Ethiopian ingredients, recipes, dietary restrictions)
- Procedural knowledge (rules for making Ethiopian recipe recommendations)
- Goal-directed backward chaining (similar to Soar's problem-space search)
- Proof construction for explainable reasoning (similar to ACT-R's production traces)
- Cultural intelligence about Ethiopian culinary traditions

## Project Structure

### Core Files

1. **`ask_questions.metta`** - Interactive Ethiopian recipe agent interface (main file to use)
2. **`knowledge_base.metta`** - Comprehensive Ethiopian ingredient and recipe knowledge base
3. **`rules.metta`** - Logical rules for Ethiopian recipe recommendation reasoning
4. **`agent.metta`** - Advanced agent implementation with Ethiopian culinary cognitive functions

## Key Features

### 1. Ethiopian Backward Chaining with Proof Construction
```metta
(: syn (-> Atom Nat Atom Atom))
```
- Implements goal-directed reasoning
- Constructs proof trees showing reasoning steps
- Provides explainable AI capabilities

### 2. Multi-layered Knowledge Representation
- **Ingredient Properties**: protein, vegetable, grain classifications
- **Recipe Requirements**: ingredient-to-recipe mappings
- **Dietary Information**: vegetarian/vegan compatibility
- **Nutritional Data**: protein content, cooking times
- **User Preferences**: dietary restrictions, time constraints

### 3. Complex Reasoning Capabilities
- **Dietary Restriction Handling**: Vegetarian/vegan recipe filtering
- **Nutritional Matching**: High-protein, low-carb recommendations
- **Time Preference Reasoning**: Quick vs. complex recipe suggestions
- **Ingredient Substitution**: Protein substitution logic
- **Multi-constraint Satisfaction**: Combining multiple user requirements

### 4. Cognitive Architecture Simulation
- **Production System**: Rule matching and firing
- **Working Memory**: Current ingredient availability
- **Goal-directed Search**: Backward chaining from desired outcomes
- **Explanation Generation**: Reasoning trace construction

## How to Run

### Interactive Agent (Main Interface)
```bash
metta ask_questions.metta
```

1. Open `ask_questions.metta`
2. Replace the example question with any question from `questions_list.md`
3. Run the file to see proof-based answers

## Example Queries and Results

### Query 1: Basic Recipe Discovery
**Question**: "What recipes can we make with available ingredients?"

**Agent Response**: 
- Chicken Stir Fry (with proof: has chicken, broccoli, rice)
- Tofu Scramble (with proof: has tofu, spinach, mushroom)
- Pasta Dish (with proof: has pasta, tomato, onion)

### Query 2: Dietary Restriction Reasoning
**Question**: "What vegetarian recipes can Alice make?"

**Agent Response**: 
- Tofu Scramble (proof chain: Alice is vegetarian → tofu/spinach/mushroom are vegetarian → recipe is vegetarian → recommend)
- Pasta Dish (proof chain: Alice is vegetarian → pasta/tomato/onion are vegetarian → recipe is vegetarian → recommend)

### Query 3: Nutritional Preference Matching
**Question**: "What high-protein recipes can Bob make?"

**Agent Response**:
- Chicken Stir Fry (proof: Bob wants high protein → chicken stir fry has high protein → can make → recommend)
- Tofu Scramble (proof: Bob wants high protein → tofu scramble has high protein → can make → recommend)

## Cognitive Architecture Principles Demonstrated

### 1. Symbolic Reasoning
- Uses explicit rules and logical symbols
- No neural networks or statistical learning
- Pure logic-based inference

### 2. Production System (ACT-R-like)
- Rules match current conditions
- Selected rules fire to update system state
- Cycle continues until goal is reached

### 3. Problem Space Search (Soar-like)
- Goal-directed backward chaining
- Subgoal creation when needed
- State-operator-result cycles

### 4. Knowledge Separation
- **Declarative**: Facts about ingredients, recipes, users
- **Procedural**: Rules for making recommendations
- Clear separation like ACT-R architecture

### 5. Explainable Reasoning
- Every conclusion comes with proof
- Shows complete reasoning chain
- Enables trust and debugging

## Advanced Features

### Multi-step Reasoning Chains
The agent can chain multiple rules together:
1. User has dietary restriction
2. Recipe uses specific ingredients
3. Ingredients match dietary restriction
4. Therefore recipe is suitable
5. We have all ingredients available
6. Therefore recommend recipe

### Confidence Assessment
The agent assesses confidence based on proof complexity:
- **High**: Direct single-rule inference
- **Medium**: Two-rule chain
- **Low**: Complex multi-rule reasoning

### Learning Simulation
Basic learning from user feedback:
- Strengthen rules for liked recommendations
- Weaken rules for disliked recommendations
- Maintain neutral rules

## Technical Implementation

### Backward Chainer Core
```metta
;; Base case: Direct match in knowledge base
(= (syn $kb $_ (: $prf $ccln)) 
   (match $kb (: $prf $ccln) (: $prf $ccln)))

;; Recursive step: Apply rules to derive conclusions
(= (syn $kb (S $k) (: ($prfabs $prfarg) $ccln))
   (let* (((: $prfabs (-> $prms $ccln)) (syn $kb $k (: $prfabs (-> $prms $ccln))))
          ((: $prfarg $prms) (syn $kb $k (: $prfarg $prms))))
     (: ($prfabs $prfarg) $ccln)))
```

### Rule Structure
```metta
;; Example rule: Recipe recommendation based on dietary restrictions
!(add-atom &kb (: vegetarian-recommendation-rule
    (-> (IsVegetarian $person)
        (-> (IsVegetarianRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))
```

## Educational Value

This project demonstrates:
1. **Symbolic AI**: Rule-based reasoning systems
2. **Cognitive Architectures**: ACT-R and Soar principles
3. **Backward Chaining**: Goal-directed inference
4. **Explainable AI**: Proof construction and reasoning traces
5. **Knowledge Representation**: Structured domain knowledge
6. **Multi-constraint Reasoning**: Complex decision making

## Comparison to Training Example

Unlike the simple frog/canary example from training, this agent:
- **Larger Knowledge Base**: 100+ facts vs. 5 facts
- **Multiple File Structure**: Professional organization
- **Complex Reasoning**: Multi-step inference chains
- **Real-world Domain**: Practical recipe recommendations
- **Multiple User Types**: Different preferences and constraints
- **Advanced Features**: Substitution, confidence, learning simulation

## Future Extensions

Potential enhancements:
1. **Hybrid Architecture**: Add neural components for ingredient similarity
2. **Temporal Reasoning**: Seasonal ingredient availability
3. **Probabilistic Logic**: Uncertainty in preferences
4. **Multi-agent System**: Multiple recommendation agents
5. **Learning**: Adaptive rule weights based on feedback

## Conclusion

This Recipe Recommendation Agent successfully demonstrates symbolic cognitive architecture principles using backward chaining in MeTTa. It provides explainable, multi-step reasoning for recipe recommendations while handling complex constraints and user preferences.

The agent showcases the power of symbolic AI for domains requiring transparent, logical reasoning with clear explanation capabilities.
