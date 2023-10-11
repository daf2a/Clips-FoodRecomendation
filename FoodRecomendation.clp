; Create templates
(deftemplate Recipe
   (slot name)
   (slot cuisine)
   (slot difficulty)
   (slot ingredients)
   (slot instructions)
   (slot budget)
)

(deftemplate User
   (slot name)
   (slot cuisine-preference)
   (slot difficulty-preference)
   (slot ingredient-preference)
   (slot budget)
)

; Create Rules

(defrule GetUserPreferences
    (not (User (name ?name)))
    =>
    ; inputs for user
    (printout t "insert your name !")
    (bind ?name (read))
    (printout t "Welcome, " ?name ". Let's find you a recipe!" crlf)
    (printout t "What cuisine do you prefer? ")
    (bind ?cuisine-pref (read))
    (printout t "How difficult should the recipe be? (Easy, Intermediate, Difficult) ")
    (bind ?difficulty-pref (read))
    (printout t "Do you have any specific ingredient preferences? ")
    (bind ?ingredient-pref (read))
    (printout t "What budget do you have? (Low, Moderate, High) ")
    (bind ?budget (read))
    ; create new user fact
    (assert (User 
        (name ?name)
        (difficulty-preference ?difficulty-pref)
        (cuisine-preference ?cuisine-pref)
        (ingredient-preference ?ingredient-pref)
        (budget ?budget)
    ))
)

(defrule FilterByDifficulty
    (User
        (name ?name)
        (difficulty-preference ?difficulty-pref)
        (cuisine-preference ?cuisine-pref)
    )
    (Recipe
        (name ?recipe)
        (difficulty ?difficulty)
    )
    (test (eq ?difficulty-pref ?difficulty))
    =>
    (printout t "Based on your difficulty preferences (" ?difficulty-pref "), we recommend:" crlf)
    (printout t "Recipe: " ?recipe crlf)
    (printout t "" crlf)
)

(defrule FilterByBudget
    (User
        (name ?name)
        (budget ?budget)
    )
    (Recipe
        (name ?recipe)
        (budget ?budget)
    )
    (test (eq ?budget ?budget))
    =>
    (printout t "Based on your budget (" ?budget "), we recommend:" crlf)
    (printout t "Recipe: " ?recipe crlf)
    (printout t "" crlf)
)

(defrule FilterByType
    (User
        (name ?name)
        (cuisine-preference ?cuisine-pref)
    )
    (Recipe
        (name ?recipe)
        (cuisine ?cuisine)
        (ingredients ?ingredients)
        (instructions ?instructions)
    )
    (test (eq ?cuisine-pref ?cuisine))
    =>
    (printout t "Based on your cuisine type preference (" ?cuisine-pref "), we recommend:" crlf)
    (printout t "Recipe: " ?recipe crlf)
    (printout t "Cuisine type: " ?cuisine crlf)
    (printout t "Ingredients: " ?ingredients crlf)
    (printout t "Instructions: " ?instructions crlf)
    (printout t "" crlf)
)

(defrule RecommendRecipe
    (User 
        (name ?name)
        (cuisine-preference ?cuisine-pref)
        (difficulty-preference ?difficulty-pref)
        (ingredient-preference ?ingredient-pref)
        (budget ?budget)
    )
    (Recipe 
        (name ?recipe)
        (cuisine ?cuisine)
        (difficulty ?difficulty)
        (ingredients ?ingredients)
        (budget ?budget)
    )
    (test (eq ?cuisine ?cuisine-pref))
    (test (eq ?difficulty ?difficulty-pref))
    (test (str-compare ?ingredients ?ingredient-pref))
    (test (eq ?budget ?budget))
    =>
    (printout t "The best fit for your preferences is " ?recipe crlf)
    (printout t "Ingredients: " ?ingredients crlf)
    (printout t "Enjoy your meal!" crlf)
    ;(retract (User (name ?name)))
    ;(retract (Recipe (name ?recipe)))
)

(defrule ExitRecommendation
   (User (name ?name))
   =>
   (printout t "Thank you for using the personalized recipe recommender, " ?name "!" crlf)
   ;(retract (User (name ?name)))
   ;(exit)
)

; set initial facts

(deffacts SampleRecipes
    (Recipe 
        (name "Spaghetti Carbonara") 
        (cuisine Italian) 
        (difficulty Easy)
        (ingredients "spaghetti, eggs, bacon, Parmesan cheese") 
        (instructions "1. Cook spaghetti. 2. Fry bacon. 3. Mix eggs and cheese. 4. Toss with pasta.")
        (budget High)
    )

    (Recipe 
        (name "Chicken Tikka Masala") 
        (cuisine Indian) 
        (difficulty Intermediate)
        (ingredients "chicken, yogurt, tomato sauce, spices") 
        (instructions "1. Marinate chicken. 2. Cook chicken. 3. Simmer in sauce.")
        (budget Moderate)
    )

    (Recipe 
        (name "Caesar Salad") 
        (cuisine American) 
        (difficulty Easy)
        (ingredients "romaine lettuce, croutons, Caesar dressing") 
        (instructions "1. Toss lettuce with dressing. 2. Add croutons.")
        (budget Low)
    )

    (Recipe
        (name "Chicken Alfredo Pasta")
        (cuisine Italian)
        (difficulty Intermediate)
        (ingredients "chicken breast, fettuccine, heavy cream, Parmesan cheese")
        (instructions "1. Cook pasta. 2. Saute chicken. 3. Mix cream and cheese. 4. Combine with pasta.")
        (budget Moderate)
    )

    (Recipe
        (name "Vegetable Stir-Fry")
        (cuisine Asian)
        (difficulty Easy)
        (ingredients "mixed vegetables, tofu, soy sauce, ginger, garlic")
        (instructions "1. Sauté vegetables. 2. Add tofu. 3. Mix with sauce. 4. Serve over rice.")
        (budget Low)
    )

    (Recipe
        (name "Grilled Salmon with Lemon Butter Sauce")
        (cuisine Seafood)
        (difficulty Intermediate)
        (ingredients "salmon fillet, lemon, butter, dill, salt, pepper")
        (instructions "1. Grill salmon. 2. Make lemon butter sauce. 3. Drizzle over salmon.")
        (budget High)
    )

    (Recipe
        (name "Black Bean Tacos")
        (cuisine Mexican)
        (difficulty Easy)
        (ingredients "black beans, tortillas, salsa, avocado, lettuce, cheese")
        (instructions "1. Heat beans. 2. Assemble tacos with toppings. 3. Enjoy!")
        (budget Low)
    )

    (Recipe
        (name "Mushroom Risotto")
        (cuisine Italian)
        (difficulty Intermediate)
        (ingredients "Arborio rice, mushrooms, onion, white wine, vegetable broth")
        (instructions "1. Sauté onion and mushrooms. 2. Add rice and wine. 3. Gradually add broth until creamy.")
        (budget Moderate)
    )
)
