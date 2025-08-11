# Ethiopian Recipe Recommendation Agent - Detailed Project Explanation 🇪🇹

## Project Overview

This is an **Ethiopian Recipe Recommendation Agent** that implements a **Symbolic Cognitive Architecture** using **backward chaining** reasoning in MeTTa. The agent can answer complex questions about Ethiopian cuisine by reasoning through multiple steps, even when the answer isn't directly stored in the knowledge base.

## Project Structure

### Core Files:
1. **`knowledge_base.metta`** - Facts about Ethiopian ingredients and recipes (doro, berbere, injera, etc.)
2. **`rules.metta`** - Logical reasoning rules for Ethiopian cuisine
3. **`agent.metta`** - Advanced cognitive functions for Ethiopian recipe analysis
4. **`ask_questions.metta`** - Interactive testing interface with Ethiopian knowledge
5. **`questions_list.md`** - Complete list of Ethiopian recipe questions you can ask

---

## File-by-File Detailed Explanation

### 1. knowledge_base.metta - The Agent's Ethiopian Culinary Memory

This file contains all the **declarative knowledge** (facts) that the agent knows about Ethiopian cuisine:

#### Ethiopian Ingredient Properties (Lines 14-37):
```metta
!(add-atom &kb (: available-doro (HasIngredient doro)))           ;; Chicken - ዶሮ
!(add-atom &kb (: available-berbere (HasIngredient berbere)))     ;; Berbere spice - በርበሬ
!(add-atom &kb (: available-injera (HasIngredient injera)))       ;; Injera - እንጀራ
```

**What this does:**
- Stores facts about what type each ingredient is
- `chicken` and `tofu` are proteins
- `broccoli`, `spinach`, etc. are vegetables
- `rice`, `pasta` are grains

#### Recipe Requirements (Lines 39-70):
```metta
!(add-atom &kb (: stirfry-chicken (RequiresIngredient chicken_stirfry chicken)))
!(add-atom &kb (: stirfry-broccoli (RequiresIngredient chicken_stirfry broccoli)))
```

**What this does:**
- Defines what ingredients each recipe needs
- `chicken_stirfry` needs `chicken`, `broccoli`, `rice`
- `tofu_scramble` needs `tofu`, `spinach`, `mushroom`
- `pasta_dish` needs `pasta`, `tomato`, `onion`

#### Dietary Information (Lines 72-80):
```metta
!(add-atom &kb (: veg-tofu (IsVegetarian tofu)))
!(add-atom &kb (: veg-broccoli-diet (IsVegetarian broccoli)))
```

**What this does:**
- Marks which ingredients are vegetarian-friendly
- Used for dietary restriction reasoning

#### Available Ingredients (Lines 118-126):
```metta
!(add-atom &kb (: available-chicken (HasIngredient chicken)))
!(add-atom &kb (: available-broccoli (HasIngredient broccoli)))
```

**What this does:**
- Tells the agent what ingredients we currently have
- This is what makes recipes possible or impossible

#### User Preferences (Lines 128-130):
```metta
!(add-atom &kb (: user-alice (IsVegetarian alice)))
!(add-atom &kb (: user-bob (WantsNutrition bob high_protein)))
```

**What this does:**
- Stores information about different users
- Alice is vegetarian, Bob wants high protein, Carol prefers quick recipes

---

### 2. rules.metta - The Agent's Reasoning Logic

This file contains **procedural knowledge** (rules) that tell the agent how to reason:

#### Basic Recipe Rule (Lines 15-18):
```metta
!(add-atom &kb (: recipe-possible-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (HasIngredient $ingredient)
            (CanMake $recipe)))))
```

**What this does:**
- **IF** a recipe requires an ingredient **AND** we have that ingredient
- **THEN** we can make the recipe
- This is the fundamental rule for recipe availability

#### Vegetarian Recipe Rule (Lines 41-44):
```metta
!(add-atom &kb (: vegetarian-recipe-rule
    (-> (RequiresIngredient $recipe $ingredient)
        (-> (IsVegetarian $ingredient)
            (IsVegetarianRecipe $recipe)))))
```

**What this does:**
- **IF** a recipe requires an ingredient **AND** that ingredient is vegetarian
- **THEN** the recipe is vegetarian
- Used to classify recipes by dietary restrictions

#### Recommendation Rules (Lines 54-59):
```metta
!(add-atom &kb (: vegetarian-recommendation-rule
    (-> (IsVegetarian $person)
        (-> (IsVegetarianRecipe $recipe)
            (-> (CanMake $recipe)
                (RecommendFor $recipe $person))))))
```

**What this does:**
- **IF** person is vegetarian **AND** recipe is vegetarian **AND** we can make it
- **THEN** recommend the recipe for that person
- This chains multiple conditions together

---

### 3. working_agent.metta - The Complete Agent

This is the main file that combines everything:

#### Backward Chainer Core (Lines 17-25):
```metta
(: syn (-> Atom Nat Atom Atom))

;; Base case: Direct match in knowledge base
(= (syn $kb $_ (: $prf $ccln)) 
   (match $kb (: $prf $ccln) (: $prf $ccln)))

;; Recursive step: Apply rules to derive conclusions
(= (syn $kb (S $k) (: ($prfabs $prfarg) $ccln))
   (let* (((: $prfabs (-> $prms $ccln)) (syn $kb $k (: $prfabs (-> $prms $ccln))))
          ((: $prfarg $prms) (syn $kb $k (: $prfarg $prms))))
     (: ($prfabs $prfarg) $ccln)))
```

**What this does:**
- **Base case**: If the answer is directly in the knowledge base, return it
- **Recursive case**: If not, find a rule that can derive the answer, then recursively solve the prerequisites
- **$prf**: Constructs the proof showing how the conclusion was reached
- **$ccln**: The conclusion we're trying to prove

---

## How the Backward Chaining Works

### Example: "Can Alice make tofu scramble?"

**Query**: `!(syn &kb (fromNumber 5) (: $proof (RecommendFor tofu_scramble alice)))`

**Step-by-step reasoning:**

1. **Goal**: `(RecommendFor tofu_scramble alice)`

2. **Find Rule**: `vegetarian-recommendation-rule`
   - Needs: `(IsVegetarian alice)` AND `(IsVegetarianRecipe tofu_scramble)` AND `(CanMake tofu_scramble)`

3. **Subgoal 1**: `(IsVegetarian alice)`
   - **Direct fact**: `user-alice` ✓

4. **Subgoal 2**: `(IsVegetarianRecipe tofu_scramble)`
   - **Find Rule**: `vegetarian-recipe-rule`
   - Needs: `(RequiresIngredient tofu_scramble $ingredient)` AND `(IsVegetarian $ingredient)`
   - **Check**: tofu, spinach, mushroom are all vegetarian ✓

5. **Subgoal 3**: `(CanMake tofu_scramble)`
   - **Find Rule**: `recipe-possible-rule`
   - Needs: `(RequiresIngredient tofu_scramble $ingredient)` AND `(HasIngredient $ingredient)`
   - **Check**: We have tofu, spinach, mushroom ✓

6. **Result**: All conditions met → Recommend tofu scramble for Alice ✓

**Proof Structure**: Shows the complete reasoning chain with all rules and facts used.

---

## How to Test the Agent

### 1. Simple Test:
```bash
metta working_agent.metta
```
This loads the agent (no output, just loads silently).

### 2. Ask Questions:
1. Open `ask_questions.metta`
2. Copy a question from `questions_list.md`
3. Paste it in the "YOUR QUESTION GOES HERE" section
4. Run: `metta ask_questions.metta`
5. See the proof-based answer!

### Example Test:
1. Copy: `!(syn &kb (fromNumber 4) (: $proof (CanMake chicken_stirfry)))`
2. Paste in `ask_questions.metta`
3. Run: `metta ask_questions.metta`
4. Result: `(: ((recipe-possible-rule stirfry-chicken) available-chicken) (CanMake chicken_stirfry))`

**This means**: "We can make chicken stir fry because the recipe-possible-rule applied with the facts that chicken stir fry requires chicken and we have chicken available."

---

## Why This Demonstrates Cognitive Architecture

### 1. Symbolic Reasoning:
- Uses explicit rules and logical symbols
- No neural networks or statistical learning
- Pure logic-based inference

### 2. Declarative vs Procedural Knowledge:
- **Declarative**: Facts in knowledge_base.metta (what we know)
- **Procedural**: Rules in rules.metta (how to reason)
- Like ACT-R's memory separation

### 3. Goal-Directed Problem Solving:
- Starts with a goal (question)
- Works backward to find supporting evidence
- Like Soar's problem-space search

### 4. Proof Construction:
- Every answer comes with complete reasoning trace
- Shows exactly how conclusion was reached
- Enables explainable AI

### 5. Multi-Step Reasoning:
- Chains multiple rules together
- Handles complex constraints
- Simulates human-like reasoning

This agent successfully demonstrates symbolic cognitive architecture principles while solving practical recipe recommendation problems!
