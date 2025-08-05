# Ethiopian Recipe Recommendation Agent - Questions List
# የኢትዮጵያ የምግብ ምክር ወኪል - ጥያቄዎች ዝርዝር

## How to Use - እንዴት መጠቀም
1. Copy any question from below - ከታች ያለውን ጥያቄ ይቅዱ
2. Paste it in `ask_questions.metta` replacing the example question - በ ask_questions.metta ውስጥ ይለጥፉ
3. Run: `metta ask_questions.metta` - ያሂዱ
4. See the proof-based answer with reasoning! - ማስረጃ ያለው መልስ ይመልከቱ

## Output Types - የውጤት አይነቶች
- 🟢 **Simple Output**: Clean, readable results (3-5 lines) - ቀላል ውጤት
- 🟡 **Complex Output**: Many results showing all reasoning paths - ውስብስብ ውጤት  
- 🔴 **No Results**: Empty list `[]` means no valid answers found - ምንም ውጤት የለም
- 🧠 **Cognitive Reasoning**: Agent derives answers through multi-step reasoning - አስተሳሰባዊ ምክንያት

---

## GROUP 1: 🟢 SIMPLE QUESTIONS - ቀላል ጥያቄዎች
*Clean, short answers - ንጹህ እና አጭር መልሶች*

### 1. Can we make Doro Wat? - ዶሮ ወጥ መስራት እንችላለን?
```metta
!(syn &kb (fromNumber 4) (: $proof (CanMake doro_wat)))
```
**Expected Output**: 4 clean proofs showing different ingredients
**Reasoning**: Agent checks if we have doro, berbere, onion, niter kibbeh → We do → Therefore we can make Doro Wat

### 2. Can we make Shiro Wat? - ሽሮ ወጥ መስራት እንችላለን?
```metta
!(syn &kb (fromNumber 4) (: $proof (CanMake shiro_wat)))
```
**Expected Output**: 3 clean proofs through different ingredients
**Reasoning**: Agent checks if we have shiro, onion, garlic → We do → Therefore we can make Shiro Wat

### 3. What Ethiopian dishes can we make? - ምን ኢትዮጵያዊ ምግቦች መስራት እንችላለን?
```metta
!(syn &kb (fromNumber 4) (: $proof (CanMake $recipe)))
```
**Expected Output**: All available Ethiopian recipes with proofs
**Reasoning**: Agent finds all recipes where we have the required ingredients

### 4. What vegetarian ingredients do we have? - ምን የቬጀቴሪያን ንጥረ ነገሮች አሉን?
```metta
!(syn &kb (fromNumber 3) (: $proof (IsVegetarian $ingredient)))
```
**Expected Output**: List of vegetarian Ethiopian ingredients
**Reasoning**: Agent finds all ingredients marked as vegetarian

### 5. What protein-rich ingredients do we have? - ምን ፕሮቲን የበዛባቸው ንጥረ ነገሮች አሉን?
```metta
!(syn &kb (fromNumber 3) (: $proof (HasProperty $ingredient protein)))
```
**Expected Output**: List of protein sources (doro, siga, misir, etc.)
**Reasoning**: Agent finds all ingredients with protein property

---

## GROUP 2: 🧠 COGNITIVE REASONING QUESTIONS - አስተሳሰባዊ ጥያቄዎች
*Agent derives answers through multi-step reasoning - ወኪሉ በብዙ ደረጃ አስተሳሰብ መልስ ያገኛል*

### 6. Does Doro Wat have high protein? - ዶሮ ወጥ ከፍተኛ ፕሮቲን አለው?
```metta
!(syn &kb (fromNumber 5) (: $proof (NutritionalValue doro_wat high_protein)))
```
**Expected Output**: `[(: ((protein-recipe-rule doro-wat-doro) doro-protein) (NutritionalValue doro_wat high_protein))]`
**Cognitive Process**: 
1. Question: "Does Doro Wat have high protein?"
2. No explicit fact stored about recipe nutrition
3. Agent reasons: Doro Wat requires doro → Doro has high protein → Therefore Doro Wat has high protein
4. Proof shows complete reasoning chain!

### 7. Is Shiro Wat high in protein? - ሽሮ ወጥ ከፍተኛ ፕሮቲን አለው?
```metta
!(syn &kb (fromNumber 5) (: $proof (NutritionalValue shiro_wat high_protein)))
```
**Expected Output**: Proof through shiro ingredient
**Cognitive Process**: Shiro Wat requires shiro → Shiro has high protein → Therefore Shiro Wat has high protein

### 8. Is Gomen dish healthy? - ጎመን ምግብ ጤናማ ነው?
```metta
!(syn &kb (fromNumber 5) (: $proof (IsHealthyRecipe gomen_dish)))
```
**Expected Output**: Proof through healthy ingredients
**Cognitive Process**: Gomen dish requires gomen → Gomen is healthy → Therefore Gomen dish is healthy

### 9. Which recipes are quick to cook? - የትኞቹ ምግቦች በፍጥነት ይበስላሉ?
```metta
!(syn &kb (fromNumber 5) (: $proof (CookingTime $recipe quick)))
```
**Expected Output**: Multiple recipes with reasoning through simple ingredients
**Cognitive Process**: Recipe requires ingredient → Ingredient is simple to cook → Therefore recipe is quick

### 10. What high-protein recipes can Dawit make? - ዳዊት ምን ከፍተኛ ፕሮቲን ምግቦች መስራት ይችላል?
```metta
!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe dawit)))
```
**Expected Output**: Complex multi-step reasoning chains
**Cognitive Process**: 
1. Dawit wants high protein → Find recipes with high protein 
2. Recipe has high protein if ingredient has high protein 
3. We can make recipe if we have ingredients → Therefore recommend
4. Shows complete 4-step reasoning chain with proof!

---

## GROUP 3: 🟡 COMPLEX QUESTIONS - ውስብስብ ጥያቄዎች  
*Many results showing all reasoning paths - ብዙ ውጤቶች ሁሉንም የአስተሳሰብ መንገዶች ያሳያሉ*

### 11. What high-protein recipes can Dawit make? - ዳዊት ምን ከፍተኛ ፕሮቲን ምግቦች መስራት ይችላል?

**🔴 COMPLEX VERSION** (Very long output with 25+ results):
```metta
!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe dawit)))
```
**Output**: Multiple complex reasoning chains (very long!)

**🟢 CLEAN VERSION** (Short, user-friendly answer):
```metta
!(syn &kb (fromNumber 3) (: $proof (UserRecommendation dawit $recommendation)))
```
**Enhanced Output**: `[(: dawit-recommendations (UserRecommendation dawit "Dawit can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat"))]`

### 12. What vegetarian recipes can Almaz make? - አልማዝ ምን የቬጀቴሪያን ምግቦች መስራት ትችላለች?

**🔴 COMPLEX VERSION** (Very long output with 50+ results):
```metta
!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe almaz)))
```
**Output**: Many results with complex proof chains (very long!)

**🟢 CLEAN VERSION** (Short, user-friendly answer):
```metta
!(syn &kb (fromNumber 3) (: $proof (UserRecommendation almaz $recommendation)))
```
**Enhanced Output**: `[(: almaz-recommendations (UserRecommendation almaz "Almaz can make 3 vegetarian Ethiopian dishes: Shiro Wat, Gomen, and Misir Wat"))]`

### 13. What can protein-seeking Meron make? - ፕሮቲን የምትፈልገው ሜሮን ምን መስራት ትችላለች?

**🔴 COMPLEX VERSION** (Very long output):
```metta
!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe meron)))
```
**Output**: Complex reasoning through protein requirements (very long!)

**🟢 CLEAN VERSION** (Short, user-friendly answer):
```metta
!(syn &kb (fromNumber 3) (: $proof (UserRecommendation meron $recommendation)))
```
**Enhanced Output**: `[(: meron-recommendations (UserRecommendation meron "Meron can make 4 high-protein Ethiopian dishes: Doro Wat, Kitfo, Shiro Wat, and Misir Wat"))]`

---

## GROUP 4: 🔴 NO RESULT QUESTIONS - ውጤት የሌላቸው ጥያቄዎች
*Questions that return empty results - ባዶ ውጤት የሚመልሱ ጥያቄዎች*

### 13. Can we make pasta? - ፓስታ መስራት እንችላለን?
```metta
!(syn &kb (fromNumber 4) (: $proof (CanMake pasta_dish)))
!(syn &kb (fromNumber 3) (: $proof (NotAvailable pasta_dish $explanation)))
```
**Expected Output**: Empty list `[]`
**Reasoning**: We don't have pasta in our Ethiopian ingredient list
**🚀 NEW: Get helpful explanation instead of empty result:**
```metta
!(syn &kb (fromNumber 3) (: $proof (NotAvailable pasta_dish $explanation)))
```
**Enhanced Output**: `[(: pasta-not-available (NotAvailable pasta_dish "We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!"))]`

### 14. Is Doro Wat vegetarian? - ዶሮ ወጥ የቬጀቴሪያን ነው?
```metta
!(syn &kb (fromNumber 4) (: $proof (IsVegetarianRecipe doro_wat)))
!(syn &kb (fromNumber 3) (: $proof (NotVegetarian doro_wat $explanation)))
```
**Expected Output**: Empty list `[]`
**Reasoning**: Doro Wat contains chicken (doro) → Chicken is not vegetarian → Therefore recipe is not vegetarian
**🚀 NEW: Get helpful explanation instead of empty result:**
```metta
!(syn &kb (fromNumber 3) (: $proof (NotVegetarian doro_wat $explanation)))
```
**Enhanced Output**: `[(: doro-not-vegetarian (NotVegetarian doro_wat "Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!"))]`

---

## GROUP 5: 🚀 SUPER ADVANCED FEATURES - ከፍተኛ የላቀ ባህሪያት
*Sophisticated AI reasoning with cultural intelligence - ውስብስብ AI አስተሳሰብ*

### 15. What recipes are beginner-friendly? - ለጀማሪዎች ምን ምግቦች ተስማሚ ናቸው?
```metta
!(syn &kb (fromNumber 5) (: $proof (IsBeginner-Friendly $recipe)))
```
**Expected Output**: `[(: ((beginner-friendly-rule ((easy-recipe-rule shiro-wat-shiro) shiro-quick)) ((healthy-recipe-rule shiro-wat-shiro) shiro-healthy)) (IsBeginner-Friendly shiro_wat))]`
**Advanced Reasoning**: Recipe is easy AND healthy → Therefore beginner-friendly
**🚀 Why Amazing**: Combines multiple criteria for intelligent recommendations!

### 16. What are the spice heat levels? - የቅመማ ቅመም ሙቀት ደረጃዎች ምንድን ናቸው?
```metta
!(syn &kb (fromNumber 5) (: $proof (HeatLevel $spice $level)))
```
**Expected Output**: `[(: berbere-hot (HeatLevel berbere very_hot)), (: mitmita-hot (HeatLevel mitmita extremely_hot))]`
**Cultural Intelligence**: Shows detailed spice knowledge with heat ratings
**🚀 Why Amazing**: Provides practical cooking guidance with cultural authenticity!

### 17. What recipes are good for busy people? - ለተጠመዱ ሰዎች ምን ምግቦች ጥሩ ናቸው?
```metta
!(syn &kb (fromNumber 5) (: $proof (IsBusyPersonFriendly $recipe)))
```
**Expected Output**: Quick AND healthy recipes with complex reasoning
**Advanced Reasoning**: Recipe is quick to cook AND healthy → Therefore busy-person-friendly
**🚀 Why Amazing**: Lifestyle-aware recommendations!

### 18. What ingredients have high nutritional density? - ምን ንጥረ ነገሮች ከፍተኛ የተመጋቢነት ጥግግት አላቸው?
```metta
!(syn &kb (fromNumber 3) (: $proof (HasNutrition $ingredient high_fiber)))
```
**Expected Output**: `[(: misir-fiber (HasNutrition misir high_fiber))]`
**Nutritional Intelligence**: Detailed nutritional analysis beyond basic protein
**🚀 Why Amazing**: Comprehensive health guidance!

### 19. What foods are culturally significant? - ምን ምግቦች በባህል ረገድ ጠቃሚ ናቸው?
```metta
!(syn &kb (fromNumber 3) (: $proof (IsCulturallySignificant $ingredient)))
```
**Expected Output**: `[(: berbere-traditional (IsCulturallySignificant berbere))]`
**Cultural Intelligence**: Understands cultural importance beyond just recipes
**🚀 Why Amazing**: Preserves and teaches Ethiopian cultural knowledge!

### 20. What foods are appropriate for special occasions? - ለልዩ አጋጣሚዎች ምን ምግቦች ተስማሚ ናቸው?
```metta
!(syn &kb (fromNumber 3) (: $proof (IsSpecialOccasionFood $recipe)))
```
**Expected Output**: `[(: doro-wat-special (IsSpecialOccasionFood doro_wat))]`
**Social Intelligence**: Understands social contexts and appropriate foods
**🚀 Why Amazing**: Helps with meal planning for celebrations!

### 21. What ingredients have long storage life? - ምን ንጥረ ነገሮች ረጅም የማከማቻ ዕድሜ አላቸው?
```metta
!(syn &kb (fromNumber 3) (: $proof (StorageLife $ingredient long)))
```
**Expected Output**: Storage information for meal planning
**Practical Intelligence**: Helps with grocery shopping and meal prep
**🚀 Why Amazing**: Practical household management advice!

---

## 🎯 ENHANCED USER EXPERIENCE FEATURES - የተሻሻለ ተጠቃሚ ተሞክሮ

### 🚀 Smart Explanations Instead of Empty Results - ከባዶ ውጤቶች ይልቅ ብልህ ማብራሪያዎች
**BEFORE**: Queries returned empty `[]` - not helpful!
**NOW**: Get helpful explanations with suggestions!

**Example 1 - Unavailable Recipe:**
- **Old way**: `!(syn &kb (fromNumber 4) (: $proof (CanMake pasta_dish)))` → `[]`
- **New way**: `!(syn &kb (fromNumber 3) (: $proof (NotAvailable pasta_dish $explanation)))`
- **Result**: `"We don't have pasta in our Ethiopian ingredient list. Try our traditional dishes: Doro Wat, Shiro Wat, Gomen, Misir Wat, or Kitfo!"`

**Example 2 - Non-Vegetarian Query:**
- **Old way**: `!(syn &kb (fromNumber 4) (: $proof (IsVegetarianRecipe doro_wat)))` → `[]`
- **New way**: `!(syn &kb (fromNumber 3) (: $proof (NotVegetarian doro_wat $explanation)))`
- **Result**: `"Doro Wat contains chicken (doro) which is not vegetarian. Try our vegetarian dishes: Shiro Wat, Gomen, or Misir Wat!"`

### 🧠 Intelligent Alternative Suggestions - ብልህ አማራጭ ጥቆማዎች
The agent now provides:
- **Recipe alternatives** when requested dish isn't available
- **Vegetarian alternatives** when querying non-vegetarian dishes
- **Traditional Ethiopian suggestions** instead of foreign cuisines
- **Helpful tips** for finding more information

### 🇪🇹 Cultural Context Awareness - የባህል አውድ ግንዛቤ
The agent understands:
- **Special occasion foods** vs everyday meals
- **Spice heat levels** for cooking guidance
- **Cultural significance** of ingredients
- **Traditional serving methods** and customs

### 📚 Built-in Help System - የተገነባ እርዳታ ስርዓት
Get helpful tips:
```metta
!(syn &kb (fromNumber 3) (: $proof (HelpfulTip $tip)))
```
**Result**: Practical guidance for using the agent effectively!

---

**🚀 The agent now demonstrates SUPER ADVANCED Ethiopian cultural intelligence with sophisticated reasoning!**
**ወኪሉ አሁን ከፍተኛ የላቀ የኢትዮጵያ ባህላዊ ብልህነትን ከውስብስብ አስተሳሰብ ጋር ያሳያል!**
