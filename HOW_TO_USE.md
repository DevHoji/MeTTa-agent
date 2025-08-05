# Recipe Recommendation Agent - How to Use

## 🎯 Quick Start

### Step 1: Choose a Question
Open `questions_list.md` and copy any question you want to ask.

### Step 2: Ask the Question
1. Open `ask_questions.metta`
2. Find line 120: `!(syn &kb (fromNumber 4) (: $proof (CanMake chicken_stirfry)))`
3. Replace it with your chosen question
4. Save the file

### Step 3: Get the Answer
Run: `metta ask_questions.metta`

## 📋 Example Usage

### Example 1: Basic Recipe Question
**Question**: Can we make chicken stir fry?
**Code**: `!(syn &kb (fromNumber 4) (: $proof (CanMake chicken_stirfry)))`
**Result**: `[(: ((recipe-possible-rule stirfry-chicken) available-chicken) (CanMake chicken_stirfry))]`
**Meaning**: "Yes, we can make chicken stir fry because we have chicken and the recipe requires chicken"

### Example 2: Dietary Restriction Question
**Question**: What can Alice (vegetarian) make?
**Code**: `!(syn &kb (fromNumber 5) (: $proof (RecommendFor $recipe alice)))`
**Result**: Multiple complex proofs showing vegetarian recipes
**Meaning**: "Alice can make tofu scramble and pasta dish because they use only vegetarian ingredients"

### Example 3: Nutritional Question
**Question**: What high-protein recipes can Bob make?
**Code**: `!(syn &kb (fromNumber 5) (: $proof (RecommendFor $recipe bob)))`
**Result**: Proofs showing high-protein recipes Bob can make
**Meaning**: "Bob can make chicken stir fry and tofu scramble because they're high in protein"

## 🔍 Understanding Results

### Result Format:
```
(: PROOF CONCLUSION)
```

### Simple Proof:
```
(: rule-name (Conclusion))
```
**Meaning**: Used one rule to reach the conclusion

### Complex Proof:
```
(: ((rule1 fact1) rule2) (Conclusion))
```
**Meaning**: Used rule1 with fact1, then rule2 to reach the conclusion

### Multiple Results:
```
[(: proof1 conclusion1), (: proof2 conclusion2)]
```
**Meaning**: Found multiple ways to reach conclusions

## 📚 Available Questions

See `questions_list.md` for 50+ questions you can ask, including:

- **Recipe Availability**: What recipes can we make?
- **Dietary Restrictions**: What vegetarian recipes exist?
- **Nutritional Preferences**: What high-protein recipes are available?
- **Time Preferences**: What quick recipes can we make?
- **Ingredient Reasoning**: What protein dishes are possible?
- **Complex Multi-Step**: What recipes require specific ingredients?

## 🧠 How the Agent Reasons

The agent uses **backward chaining**:
1. **Starts** with your question (goal)
2. **Finds** rules that could prove the goal
3. **Recursively** proves the rule's prerequisites
4. **Constructs** a complete proof chain
5. **Returns** the proof showing how it reached the conclusion

## ✅ Project Files

- **`ask_questions.metta`** - Main interface (use this file)
- **`questions_list.md`** - All available questions
- **`knowledge_base.metta`** - Facts about ingredients and recipes
- **`rules.metta`** - Logical reasoning rules
- **`agent.metta`** - Advanced cognitive functions
- **`project_explanation.md`** - Detailed technical explanation

## 🎉 Ready to Use!

Your Recipe Recommendation Agent demonstrates advanced cognitive architecture principles and is ready to answer complex questions with complete proof-based reasoning!
