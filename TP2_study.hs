import Data.Char

--2.1
sum100 :: Integral a => a
sum100 = sum [x^2 | x <- [1.. 100]]

--2.2 a
aprox :: Int -> Double
aprox a = sum [4 * fromIntegral((-1) ^ i) / fromIntegral(2 * i + 1) | i <- [0.. a-1]]
aprox2 :: Int -> Double
aprox2 a = sqrt(sum [12 * fromIntegral((-1) ^ i) / fromIntegral((^)(i + 1) 2) | i <- [0.. a-1]])

--2.3
dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum [x * y | (x, y) <- zip a b]

--2.4
divprop :: Integer -> [Integer]
divprop a = [x | x <- [1 .. a - 1], a`mod`x == 0]

--2.5
perfeitos :: Integer -> [Integer]
perfeitos a = [x | x <- [1.. a], sum (divprop x) == x]

--2.6
pitagoricos :: Integer -> [(Integer ,Integer ,Integer)]
pitagoricos a = [(x, y, z) | x <- [1.. a], y <- [1.. a], z <- [1.. a], x^2 + y^2 == z^2]

--2.7
primo :: Integer -> Bool
primo a = length (divprop a) == 1

--2.8
binom :: Integer -> Integer -> Integer
binom n k
  | k < (n - k) = div (product [x.. n]) (product [1.. k])
  | k >= (n - k) = div (product [((+) k 1).. n]) (product [1.. ((-) n k)])
    where x = ((+) ((-) n k) 1)

pascal :: Integer -> [[Integer]]
pascal a = [[binom x y] | x <- [0 .. a], y <- [0 .. a]]

--2.9
desloc :: Int -> Char -> Char
desloc a b
  | b >= 'A' && b <= 'Z' || b >= 'a' && b <= 'z' = chr (ord b + a)
  | otherwise = b

cifrar :: Int -> String -> String
cifrar a b = [desloc a x | x <- b]

--2.10 a
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (a:ab)
  | a == True = myAnd ab
  | a == False = False

--2.10 b
myOr :: [Bool] -> Bool
myOr [] = False
myOr (a:ab)
  | a == False = myOr ab
  | a == True = True

  --2.10 c
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (a:ab) = a ++ myConcat ab

--2.10 d
myReplicate :: Int -> a -> [a]
myReplicate a b
  | a == 0 = []
  | a > 0 = [b] ++ myReplicate (a - 1) (b)

--2.10 e
(§§) :: [a] -> Int -> a
(§§) (a:ab) b
  | b == 0 = a
  | b > 0 = (§§) ab (b - 1)

--2.10 f
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:yz)
  | y == x = True
  | otherwise = myElem x yz

--2.11 a
myConcat2 :: [[a]] -> [a]
myConcat2 a = [x | xy <- a, x <- xy]

--2.11 b
myReplicate2 :: Int -> a -> [a]
myReplicate2 a b = [b | a <- [1 .. a]]

--2.11 c
(§§§) :: [a] -> Int -> a
(§§§) a b = head (drop b a)

--2.12
maius :: String -> Bool
maius [] = False
maius (a:ab)
  | a >= 'A' && a <= 'Z' = True
  | otherwise = maius ab

minus :: String -> Bool
minus [] = False
minus (a:ab)
  | a >= 'a' && a <= 'z' = True
  | otherwise = minus ab

nums :: String -> Bool
nums [] = False
nums (a:ab)
  | a >= '0' && a <= '9' = True
  | otherwise = nums ab

forte :: String -> Bool
forte a = and [length a >= 8, maius a, minus a, nums a]

--2.13
mindivaux :: Int -> [Int]
mindivaux a = [x | x <- [1 .. round(sqrt(fromIntegral a))], a`mod`x == 0]

mindiv :: Int -> Int
mindiv a
  | length (mindivaux a) == 1 = 1
  | otherwise = (!!) (mindivaux a) 1

primo2 :: Int -> Bool
primo2 a
  | mindiv a == 1 = True
  | otherwise = False

--2.14
myIns :: Eq a => [a] -> a -> [a]
myIns a b = a ++ [b]

myNubAux :: Eq a => [a] -> [a] -> [a]
myNubAux [] b = []
myNubAux (a:ab) b
  | (elem a b) == False = [a] ++ myNubAux ab (myIns b a)
  | otherwise = myNubAux ab b

myNub :: Eq a => [a] -> [a]
myNub a = myNubAux a []

--2.15
myIntersperse :: a -> [a] -> [a]
myIntersperse c [] = []
myIntersperse c (a:ab)
  | length ab == 0 = [a]
  | otherwise = [a] ++ [c] ++ myIntersperse c ab

--2.16
algarismosAux :: Int -> [Int]
algarismosAux 0 = []
algarismosAux a = [a `mod` 10] ++ algarismosAux (div a 10)

algarismos :: Int -> [Int]
algarismos a = reverse (algarismosAux(a))

--2.17
toBitsAux :: Int -> [Int]
toBitsAux 0 = []
toBitsAux a = [a `mod` 2] ++ toBitsAux (div a 2)

toBits :: Int -> [Int]
toBits a = reverse (toBitsAux(a))

--2.18
fromBitsAux :: [Int] -> Int -> Int
fromBitsAux (a:ab) b
  | b == 0 = 1
  | otherwise = a * 2 ^ b + fromBitsAux ab (b - 1)

fromBits :: [Int] -> Int
fromBits a = fromBitsAux a (length a - 1)

--2.19
mdc :: Integer -> Integer -> Integer
mdc a b
  | b == 0 = a
  | otherwise = mdc b (a `mod` b)

--2.20 a
myInsert :: Ord a => a -> [a] -> [a]
myInsert a [] = [a]
myInsert a (b:bc)
  | a >= b = [b] ++ myInsert a bc
  | otherwise = [a] ++ [b] ++ bc

--2.20 b
isortAux :: Ord a => [a] -> [a] -> [a]
isortAux [] b = b
isortAux (a:ab) b
  | length ab == 0 = myInsert a b
  | otherwise = isortAux ab (myInsert a b)

isort :: Ord a => [a] -> [a]
isort [] = []
isort a = isortAux a []

--2.21 a
minimumAux :: Ord a => [a] -> a -> a
minimumAux [] c = c
minimumAux (a:ab) c
  | a >= c = minimumAux ab c
  | a < c = minimumAux ab a

myMinimum :: Ord a => [a] -> a
myMinimum (a:ab) = minimumAux ab a

--2.21 b
deleteAux :: Eq a => a -> [a] -> [a] -> [a]
deleteAux _ [] d = d
deleteAux a (b:bc) d
  | (a == b) == True = d ++ bc
  | otherwise = deleteAux a bc (myIns d b)

delete :: Eq a => a -> [a] -> [a]
delete a b = deleteAux a b []

--2.21 c
ssortAux :: Ord a => [a] -> [a]  -> [a]
ssortAux [] b = b
ssortAux a b
  | length a == 0 = []
  | otherwise = ssortAux (delete (myMinimum a) a) (myInsert (myMinimum a) b)

ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort a = ssortAux a []

--2.22 a
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge (a:ab) [] = (a:ab)
merge [] (c:cd) = (c:cd)
merge (a:ab) (c:cd)
  | a <= c = ssort([a] ++ merge ab (c:cd))
  | a > c = ssort([c] ++ merge (a:ab) cd)

--2.22 b
metades :: [a] -> [[a]]
metades a = [take x a, drop x a]
  where x = round ((/) (fromIntegral (length a)) (fromIntegral 2))

msortAux :: Ord a => [a] -> [a] -> [a]
msortAux a b
  | myOr [length a == 1, length b == 1] == True = merge a b
  | otherwise = merge (msort a) (msort b)


msort :: Ord a => [a] -> [a]
msort [] = []
msort a = msortAux (head (metades a)) (last (metades a))
