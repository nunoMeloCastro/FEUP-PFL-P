-- 4.1
primos :: [Integer]
primos = crivo [2..]
crivo :: [Integer] -> [Integer]
crivo (p:xs) = p : crivo [x | x<-xs, mod x p/=0]

--factores :: Int -> [Int]
--factores n =

-- 4.2
calcPi1 :: Int -> Double
calcPi1 n = sum $ take n $ zipWith (/) (cycle [4,-4]) [1, 3 ..]

-- versão pouco eficiente
calcPi1' :: (Integral a, Floating b) => a -> b
calcPi1' n = sum [4 * fromIntegral((-1)^i)/fromIntegral(2*i+1) | i <- [0 .. n - 1]]

-- 4.2
calcPi2 :: Int -> Double
calcPi2 n = 3 + (sum $ take n $ zipWith (/) (cycle [4,-4]) (zipWith (*) [2, 4..] (zipWith (*) [3, 5..] [4, 6..])))

-- 4.3
--intercalar :: a → [a] → [[a]]

-- 4.4
--perms :: [a] → [[a]]

-- 4.5
--cifraChave :: String → String → String

-- 4.6
--pascal :: [[Int]]

--4.7
myArv = (No 3(No 2 (No 1 Vazia Vazia ) Vazia) (No 4 Vazia Vazia))
data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x l r) = x + (sumArv l) + (sumArv r)

-- 4.8

listar :: Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar esq ++ [x] ++ listar dir



-- 4.9
nivel :: Int → Arv a → [a]
nivel n arv =

-- 4.11
-- Construção por inserção simples
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
