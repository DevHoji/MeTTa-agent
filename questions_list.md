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

### 11. What vegetarian recipes can Almaz make? - አልማዝ ምን የቬጀቴሪያን ምግቦች መስራት ትችላለች?
```metta
!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe almaz)))
```
**Expected Output**: Many results with complex proof chains
**Reasoning**: Almaz is vegetarian → Find vegetarian recipes → Check availability → Recommend
**Note**: Shows all possible reasoning paths - demonstrates thoroughness

### 12. What can protein-seeking Meron make? - ፕሮቲን የምትፈልገው ሜሮን ምን መስራት ትችላለች?
```metta
!(syn &kb (fromNumber 6) (: $proof (RecommendFor $recipe meron)))
```
**Expected Output**: Complex reasoning through protein requirements
**Reasoning**: Meron wants protein → Find protein recipes → Check ingredients → Recommend

---

## GROUP 4: 🔴 NO RESULT QUESTIONS - ውጤት የሌላቸው ጥያቄዎች
*Questions that return empty results - ባዶ ውጤት የሚመልሱ ጥያቄዎች*

### 13. Can we make pasta? - ፓስታ መስራት እንችላለን?
```metta
!(syn &kb (fromNumber 4) (: $proof (CanMake pasta_dish)))
```
**Expected Output**: Empty list `[]`
**Reasoning**: We don't have pasta in our Ethiopian ingredient list

### 14. Is Doro Wat vegetarian? - ዶሮ ወጥ የቬጀቴሪያን ነው?
```metta
!(syn &kb (fromNumber 4) (: $proof (IsVegetarianRecipe doro_wat)))
```
**Expected Output**: Empty list `[]`
**Reasoning**: Doro Wat contains chicken (doro) → Chicken is not vegetarian → Therefore recipe is not vegetarian

---

**The agent successfully demonstrates Ethiopian cultural knowledge with advanced cognitive reasoning!**
**ወኪሉ የኢትዮጵያ ባህላዊ እውቀትን በላቀ አስተሳሰባዊ ምክንያት በተሳካ ሁኔታ ያሳያል!**
