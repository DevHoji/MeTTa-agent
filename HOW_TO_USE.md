# Ethiopian Recipe Recommendation Agent - How to Use 🇪🇹

## 🎯 Quick Start

### Step 1: Choose a Question
Open `questions_list.md` and copy any Ethiopian recipe question you want to ask.

### Step 2: Ask the Question
1. Open `ask_questions.metta`
2. Find line 435: `!(syn &kb (fromNumber 4) (: $proof (CanMake doro_wat)))`
3. Replace it with your chosen question
4. Save the file

### Step 3: Get the Answer
Run: `metta ask_questions.metta`

## 📋 Ethiopian Recipe Examples

### Example 1: Basic Ethiopian Recipe Question
**Question**: Can we make Doro Wat (Ethiopian chicken stew)?
**Code**: `!(syn &kb (fromNumber 4) (: $proof (CanMake doro_wat)))`
**Result**: `[(: ((recipe-possible-rule doro-wat-doro) available-doro) (CanMake doro_wat))]`
**Meaning**: "Yes, we can make Doro Wat because we have chicken (doro) and the recipe requires chicken"

### Example 2: Ethiopian Dietary Restriction Question
**Question**: What can Almaz (vegetarian) make?
**Code**: `!(syn &kb (fromNumber 3) (: $proof (UserRecommendation almaz $recommendation)))`
**Result**: `[(: almaz-recommendations (UserRecommendation almaz "Almaz can make 3 vegetarian Ethiopian dishes: Shiro Wat, Gomen, and Misir Wat"))]`
**Meaning**: "Almaz can make Shiro Wat (chickpea stew), Gomen (collard greens), and Misir Wat (lentil stew) - all traditional Ethiopian vegetarian dishes"

### Example 3: Ethiopian Nutritional Analysis
**Question**: What high-protein Ethiopian dishes can Dawit make?
**Code**: `!(syn &kb (fromNumber 3) (: $proof (UserRecommendation dawit $recommendation)))`
**Result**: `[(: dawit-recommendations (UserRecommendation dawit "Dawit can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat"))]`
**Meaning**: "Dawit can make Doro Wat (chicken stew), Kitfo (beef tartare), Shiro Wat (chickpea stew), and Misir Wat (lentil stew) - all high in protein"

### Example 4: Ethiopian Spice Intelligence
**Question**: How spicy is mitmita?
**Code**: `!(syn &kb (fromNumber 5) (: $proof (HeatLevel mitmita $level)))`
**Result**: `[(: mitmita-hot (HeatLevel mitmita extremely_hot))]`
**Meaning**: "Mitmita is extremely hot - it's a traditional Ethiopian spice blend that's even hotter than berbere"

## 🔍 Understanding Ethiopian Recipe Results

### Ethiopian Proof Format:
```
(: PROOF CONCLUSION)
```

### Simple Ethiopian Proof:
```
(: available-doro (HasIngredient doro))
```
**Meaning**: We have doro (chicken) available

### Complex Ethiopian Proof:
```
(: ((recipe-possible-rule doro-wat-doro) available-doro) (CanMake doro_wat))
```
**Meaning**: We can make Doro Wat because the recipe requires chicken and we have chicken

### Multiple Ethiopian Results:
```
[(: almaz-shiro (CanMake shiro_wat)), (: almaz-gomen (CanMake gomen_dish))]
```
**Meaning**: Almaz can make both Shiro Wat and Gomen

## 🇪🇹 Available Ethiopian Questions

See `questions_list.md` for 50+ Ethiopian recipe questions you can ask, including:

- **Ethiopian Recipe Availability**: Can we make Doro Wat? Kitfo? Shiro Wat?
- **Ethiopian Dietary Restrictions**: What vegetarian Ethiopian dishes exist?
- **Ethiopian Nutritional Analysis**: Is Doro Wat high in protein?
- **Ethiopian Cultural Intelligence**: How spicy is berbere? What's culturally significant?
- **Ethiopian User Recommendations**: What can Dawit/Almaz/Meron make?
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
