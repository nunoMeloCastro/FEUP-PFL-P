--1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c
  | (a + b) < c = False
  | (a + c) < b = False
  | (b + c) < a = False
  | otherwise = True

--1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt( s * (s - a) * (s - b) * (s - c))
  where s = (/) (a + b + c) 2

--1.3
--metades [1,2,3,4,5,6,7,8] == ([1,2,3,4], [5,6,7,8])
metades :: [a] -> ([a], [a])
metades a = (take x a, drop x a)
  where x = div (length a) 2

--1.4 a
myLast :: [a] -> a
myLast a = head (reverse a)

myLast2 :: [a] -> a
myLast2 a = head (drop ((-) (length a) 1) a)

--1.4 b
myInit :: [a] -> [a]
myInit a = reverse (tail (reverse a))

myInit2 :: [a] -> [a]
myInit2 a = take ((-) (length a) 1) a

--1.5 a
binom :: Integer -> Integer -> Integer
binom n k = div (product [1.. n]) ((*) (product [1.. k]) (product [1.. ((-) n k)]))

--1.5 b
binom2 :: Integer -> Integer -> Integer
binom2 n k
  | k < (n - k) = div (product [x.. n]) (product [1.. k])
  | k >= (n - k) = div (product [((+) k 1).. n]) (product [1.. ((-) n k)])
    where x = ((+) ((-) n k) 1)

--1.6

raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = (x1, x2)
  where x1 = (/) ((-) (-b) (sqrt((-) (b^2) ((*) 4((*) a c))))) ((*) 2 a)
        x2 = (/) ((+) (-b) (sqrt((-) (b^2) ((*) 4((*) a c))))) ((*) 2 a)

--1.7
--a) [Char]
--b) (Char, Char, Char)
--c) [(Bool, Char)]
--d) ([Bool], [Char])
--e) [[a] -> [a]]
--f) [Bool -> Bool]

--1.8
--segundo :: [a] -> a

--trocar :: (a, b) -> (b, a)

--par :: a -> b -> (a, b)

--dobro :: Num a => a -> a

--metade :: Fractional => a -> a

--minuscula :: Char -> Bool

--intervalo :: Ord a => a -> a -> a -> Bool

--palindromo :: Eq a => a -> Bool

--twice :: (a -> a) -> a -> a

--1.9
classifica :: Int -> String
classifica a
  | a >= 19 = "muito bom com distincao"
  | a >= 16 = "muito bom"
  | a >= 13 = "bom"
  | a >= 10 = "suficiente"
  | otherwise = "reprovado"

  --1.10
imc :: Float -> Float -> String
imc a b
  | x >= 30 = "obesidade"
  | x >= 25 = "excesso de peso"
  | x >= 18.5 = "peso normal"
  | otherwise = "baixo peso"
    where x = (/) a (b^2)

--1.11
--max, min :: Ord a => a -> a -> a
--max x y = if x>=y then x else y
--min x y = if x<=y then x else y

max3, min3 :: Ord a => a -> a -> a -> a
max3 x y z = if x>=y then a else b
  where a = if x>=z then x else z
        b = if y>=z then y else z

min3 x y z = if x<=y then a else b
  where a = if x<=z then x else z
        b = if y<=z then y else z

max3', min3' :: Ord a => a -> a -> a -> a
max3' x y z = max (max x y) z
min3' x y z = min (min x y) z

--1.12
xor :: Bool -> Bool -> Bool
xor a b
  | a == True, b == True = False
  | a == False, b == False = False
  | otherwise = True

--1.13
safetail :: [a] -> [a]
safetail a
  | length a == 0 = []
  | otherwise = tail a

--1.14 a
curta :: [a] -> Bool
curta a = length a < 3

--1.14 b
curta2 :: [a] -> Bool
curta2 [ ] = True
curta2 [_] = True
curta2 [_, _] = True
curta2 _ = False

--1.15 a
mediana :: Ord a => a -> a -> a -> a
mediana x y z = if (max (max x y) z) == x then max y z else (max (min y z) x)

--1.15 b
mediana2 :: Integral a => a -> a -> a -> a
mediana2 x y z = x + y + z - max3' x y z - min3' x y z

--1.16
