-- Title: 3-Topping Pizzas
-- Company: McKinsey
-- Difficulty: Hard
-- Access: Free
-- Pattern: combinations via self-join
-- Summary: Generate unique 3-item topping combinations using ordered self-joins and return all valid distinct combos.
-- Notes: Enforce ordering (t1 < t2 < t3) to avoid permutations; use DISTINCT to remove duplicates.
-- Dialect: PostgreSQL

SELECT 
  CONCAT(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) AS pizza,
  p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost AS total_cost
FROM pizza_toppings AS p1
INNER JOIN pizza_toppings AS p2
  ON p1.topping_name < p2.topping_name 
INNER JOIN pizza_toppings AS p3
  ON p2.topping_name < p3.topping_name 
ORDER BY total_cost DESC, pizza;