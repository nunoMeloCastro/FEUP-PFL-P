import Data.Char

--3.1
mapFilter :: (a -> a) -> (a -> Bool) -> [a] -> [a]
mapFilter f p xs = map f (filter p xs)

--3.2
dec2int :: [Int] -> Int
dec2int xs = foldl (\x y -> 10 * x + y) 0 xs


--3.3
zipWithRec :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWithRec _ [] [] = []
zipWithRec _ [] _ = []
zipWithRec _ _ [] = []
zipWithRec f (x:xs) (y:ys) = [f x y] ++ zipWithRec f xs ys

--3.4
isort :: Ord a => [a] -> [a]
isort (x:xs) = foldr (\x xs -> myInsert x xs) [] (x:xs)

myInsert :: Ord a => a -> [a] -> [a]
myInsert a [] = [a]
myInsert a (b:bc)
  | a >= b = [b] ++ myInsert a bc
  | otherwise = [a] ++ [b] ++ bc

--3.5 a
myMaximum :: Ord a => [a] -> a
myMaximum (x:xs) = foldl1 max (x:xs)

myMaximum2 :: Ord a => [a] -> a
myMaximum2 (x:xs) = foldr1 max (x:xs)

myMinimum :: Ord a => [a] -> a
myMinimum (x:xs) = foldl1 min (x:xs)

myMinimum2 :: Ord a => [a] -> a
myMinimum2 (x:xs) = foldr1 min (x:xs)

--3.5 b
myFoldl1 :: (a -> a -> a) -> [a] -> Maybe a
myFoldl1 _ [] = Nothing
myFoldl1 f (x:xs) = Just (foldl f x xs)

myFoldr1 :: (a -> a -> a) -> [a] -> Maybe a
myFoldr1 _ [] = Nothing
myFoldr1 f xs = Just (foldr f (last xs) (reverse(tail(reverse xs))))

--3.6
mdc :: Integer -> Integer -> (Integer, Integer)
mdc a b = until (\(x, y) -> y == 0) (\(x, y) -> (y, x `mod` y)) (a, b)

--3.7 a
(+++) :: [a] -> [a] -> [a]
(+++) xs ys = foldr (:) ys xs

--3.7 b
myConcat :: [[a]] -> [a]
myConcat (x:xs) = foldr (++) x xs

--3.7 c
myReverse :: [a] -> [a]
myReverse xs = foldr (\x xs -> xs ++ [x]) [] xs

--3.7 d
myReverse2 :: [a] -> [a]
myReverse2 xs = foldl (\xs x-> x:xs) [] xs

--3.7 e
myElem :: Eq a => a -> [a] -> Bool
myElem x l = any (x ==) l

--3.8
--palavras :: String -> [String]
--palavras "" = []
--palavras (x:xs)
--  | x == " " = [] ++ [palavras xs]
--  | otherwise = x ++ palavras xs

--3.9
myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl f x [] = [x]
myScanl f x l = [x] ++ myScanlAux f x l

myScanlAux :: (a -> b -> a) -> a -> [b] -> [a]
myScanlAux f x [] = []
myScanlAux f x (y:ys) = [aux] ++ myScanlAux f aux (ys)
  where aux = foldl f x [y]
