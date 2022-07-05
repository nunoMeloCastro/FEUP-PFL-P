import Data.List
--4.1
factores :: Int -> [Int]
factores x = factoresAux x 0

factoresAux :: Int -> Int -> [Int]
factoresAux x cnt
  | x == 1 = []
  | mod x (primos!!cnt) == 0 = [(primos!!cnt)] ++ factoresAux (div x (primos!!cnt)) cnt
  | otherwise = factoresAux x (cnt + 1)

primos :: [Int]
primos = crivo [2..]

crivo :: [Int] -> [Int]
crivo (p:xs) = p : crivo [x | x<-xs, x`mod`p/=0]

--4.2
calcPi1, calcPi2 :: Int -> Double
calcPi1 x = sum $ take x $ zipWith (/) (cycle[4,-4]) [1, 3..]
calcPi2 x = (+) 3 $ sum $ take x $ zipWith (/) (cycle[4,-4]) (zipWith (*) [2, 4..] (zipWith (*) [3, 5..] [4, 6..]))

--4.3
intercalar :: a -> [a] -> [[a]]
intercalar x l = intercalarAux x l 0

intercalarAux :: a -> [a] -> Int -> [[a]]
intercalarAux x l z
  | z == (length l) = [insertAt x z l]
  | otherwise = [insertAt x z l] ++ intercalarAux x l (z + 1)

insertAt :: a -> Int -> [a] -> [a]
insertAt x 0 l = x:l
insertAt x i (y:ys) = y : insertAt x (i - 1) ys

--4.4
perms :: Eq a => [a] -> [[a]]
perms l = deleteEquals (permsAux l 1 ++ permsAux (reverse l) 1)

permsAux :: [a] -> Int -> [[a]]
permsAux l x
  | x == (length l) = intercalar (select l x) (myDelete l x)
  | otherwise = intercalar (select l x) (myDelete l x) ++ intercalar (select l (x + 1)) (myDelete l (x + 1))

myDelete :: [a] -> Int -> [a]
myDelete l x = take ((-) x 1) l ++ drop x l

select :: [a] -> Int -> a
select l x = head (drop ((-) x 1) l)

deleteEquals :: Eq a => [[a]] -> [[a]]
deleteEquals [] = []
deleteEquals l
  | elem (head l) (tail l) == False = [head l] ++ deleteEquals (tail l)
  | otherwise = deleteEquals (tail l)

--4.6
--pascal :: [[Int]]
--pascal = [x | x y <-

--binom :: Integer -> Integer -> Integer
--binom n k
--  | k < (n - k) = div (product [x.. n]) (product [1.. k])
--  | k >= (n - k) = div (product [((+) k 1).. n]) (product [1.. ((-) n k)])
--    where x = ((+) ((-) n k) 1)

--4.7
myArv = (No 3(No 1 Vazia (No 2 Vazia Vazia )) (No 5 (No 4 Vazia Vazia) (No 10 Vazia Vazia)))
data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No a l r) = a + (sumArv l) + (sumArv r)

--4.8
listar :: Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar dir ++ [x] ++ listar esq

--4.9
nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel n (No x esq dir)
  | n == 0 = [x]
  | otherwise = nivel (n - 1) esq ++ nivel (n - 1) dir

--4.10
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No x esq dir) = (No (f x) (mapArv f esq) (mapArv f dir))

--4.11
construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
  | x==y = No y esq dir -- já ocorre; não insere
  | x<y = No y (inserir x esq) dir -- insere à esquerda
  | x>y = No y esq (inserir x dir) -- insere à direita

-- Construção por particão binária
-- Pré-condição: a lista de valores deve estar por ordem crescente
construir' :: [a] -> Arv a
construir' [] = Vazia
construir' xs = No x (construir' xs') (construir' xs'')
  where n = length xs `div` 2 -- ponto médio
        xs' = take n xs -- partir a lista
        x:xs'' = drop n xs

altura :: (Num b, Ord b) => Arv a -> b
altura Vazia = 0
altura (No _ l r) = 1 + max (altura l) (altura r)

comparaAlturasN :: (Integral a, Show a) => a -> IO ()
comparaAlturasN n = do
  putStrLn $ "n = " ++ (show n) ++ ":"
  putStrLn $ "Por inserção simples: " ++ (show $ altura $ construir [1 .. n])
  putStrLn $ "Por partição binária: " ++ (show $ altura $ construir' [1 .. n])
  putStrLn $ "Minorante teórico da altura: " ++ (show $ ((+1) . floor . logBase 2 . fromIntegral) n)

comparaAlturas :: IO ()
comparaAlturas = do
  comparaAlturasN 10
  comparaAlturasN 100
  comparaAlturasN 1000

--4.12 a
maisDir :: Arv a -> a
maisDir (No x _ Vazia) = x
maisDir (No _ _ dir) = maisDir dir

--4.12 b
remover :: Ord a => a -> Arv a -> Arv a
remover x Vazia = Vazia -- não ocorre
remover x (No y Vazia dir) -- um descendente
  | x==y = dir
remover x (No y esq Vazia) -- um descendente
  | x==y = esq
remover x (No y esq dir) -- dois descendentes
  | x<y = No y (remover x esq) dir
  | x>y = No y esq (remover x dir)
  | x==y = let z = maisDir esq
    in No z dir (remover z esq)
