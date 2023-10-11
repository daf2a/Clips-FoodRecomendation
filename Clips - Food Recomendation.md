# Clips - Food Recomendation

### Anggota Kelompok

| NRP | Name |
| --- | --- |
| 5025211252 | Nur Azizah |
| 5025211232 | Ulima Kaltsum Rizky Hibatullah |
| 5025211015 | Muhammad Daffa Ashdaqfillah |

### How To Run  
1. Copy Source Code ke file yang ingin dijalankan di VS Code
2. Aktifkan Ekstension Clips
3. Clear - Load Current File - Reset - Run
4. Masukkan data yang diperlukan

### Template

Ada 2 template atau model yang terlibat

- User
- Recipe

```jsx
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
```

### Sample Recipes

```jsx
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
        (difficulty Moderate)
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
        (difficulty Moderate)
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
        (difficulty Moderate)
        (ingredients "Arborio rice, mushrooms, onion, white wine, vegetable broth")
        (instructions "1. Sauté onion and mushrooms. 2. Add rice and wine. 3. Gradually add broth until creamy.")
        (budget Moderate)
    )
)
```

### RULES

1. GetUserPreferences -> untuk menerima input user
apa syarat untuk menerima user input ?
syarat nya adalah -> tidak ada fakta user di dalam kumpulan fakta
IF there is no user THEN get input
    
    ```jsx
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
    ```
    
    Saya memasukkan preference user seperti berikut untuk uji coba rules:
    
    ```jsx
    (User (name agus) (cuisine-preference Seafood) (difficulty-preference Intermediate) (ingredient-preference eggs) (budget High))
    ```
    
2. RecommendRecipe
rules RecommendRecipe akan digunakan untuk menentukan resep yang cocok untuk user berdasarkan inputnya
IF the user preferences match with recipes THEN recommend the recipe
    
    ```jsx
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
    ```
    
    Ketika saya memasukkan preference user seperti berikut :
    
    ```jsx
    (User (name agus) (cuisine-preference Seafood) (difficulty-preference Intermediate) (ingredient-preference eggs) (budget High))
    ```
    
    Rules RecommendRecipe menampilkan seperti ini :
    
    ![Untitled](Clips%20-%20Food%20Recomendation/Untitled.png)
    
3. ExitRecommendation
    
    rules ExitRecommendation akan digunakan hanya untuk menampilkan pesan penutup
    
    ```jsx
    (defrule ExitRecommendation
       (User (name ?name))
       =>
       (printout t "Thank you for using the personalized recipe recommender, " ?name "!" crlf)
       ;(retract (User (name ?name)))
       ;(exit)
    )
    ```
    
    Rules ExitRecommendation menampilkan seperti ini :
    
    ![Untitled](Clips%20-%20Food%20Recomendation/Untitled%201.png)
    
4. FilterByDifficulty
    
    Rules FilterByDifficulty digunakan untuk memfilter resep berdasarkan preferensi kesulitan pengguna. Jika kesulitan resep sesuai dengan preferensi kesulitan pengguna, maka resep tersebut direkomendasikan.
    
    ```jsx
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
        (printout t "Berdasarkan preferensi kesulitan Anda (" ?difficulty-pref "), kami merekomendasikan:" crlf)
        (printout t "Resep: " ?recipe crlf)
        (printout t "" crlf)
    )
    
    ```
    
    Ketika saya memasukkan preference user seperti berikut :
    
    ```jsx
    (User (name agus) (cuisine-preference Seafood) (difficulty-preference Intermediate) (ingredient-preference eggs) (budget High))
    ```
    
    Rules FilterByDifficulty menampilkan seperti ini :
    
    ![Untitled](Clips%20-%20Food%20Recomendation/Untitled%202.png)
    
5. FilterByBudget
    
    Rules FilterByBudget ini digunakan untuk memfilter resep berdasarkan anggaran pengguna. Jika anggaran resep sesuai dengan anggaran pengguna, maka resep tersebut direkomendasikan
    
    ```jsx
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
    ```
    
    Ketika saya memasukkan preference user seperti berikut :
    
    ```jsx
    (User (name agus) (cuisine-preference Seafood) (difficulty-preference Intermediate) (ingredient-preference eggs) (budget High))
    ```
    
    Rules FilterByBudget menampilkan seperti ini :
    
    ![Untitled](Clips%20-%20Food%20Recomendation/Untitled%203.png)
    
6. FilterByType
    
    Rules FilterByType ini digunakan untuk memfilter resep berdasarkan preferensi jenis masakan pengguna. Jika jenis masakan resep sesuai dengan preferensi jenis masakan pengguna, maka resep tersebut direkomendasikan.
    
    ```jsx
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
        (printout t "Based on your cuisine type preference (" ?cuisine-pref "), here some recomendation:" crlf)
        (printout t "Recipe: " ?recipe crlf)
        (printout t "Cuisine type: " ?cuisine crlf)
        (printout t "Ingredients: " ?ingredients crlf)
        (printout t "Instructions: " ?instructions crlf)
        (printout t "" crlf)
    )
    ```
    
    Ketika saya memasukkan preference user seperti berikut :
    
    ```jsx
    (User (name agus) (cuisine-preference Seafood) (difficulty-preference Intermediate) (ingredient-preference eggs) (budget High))
    ```
    
    Rules FilterByType menampilkan seperti ini :
    
    ![Untitled](Clips%20-%20Food%20Recomendation/Untitled%204.png)