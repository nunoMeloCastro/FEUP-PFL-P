-- 3.1
mapFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapFilter f p xs = map f (filter p xs)

--3.2
dec2int :: (Integral a) => [a] -> a
dec2int digits = foldl(\acc x -> 10 * acc + x) 0 digits

-- conversão em poit-free

dec2int'1 :: (Integral a) => [a] -> a
dec2int'1 = foldl(\acc x -> 10 * acc + x) 0

dec2int'2 :: (Integral a) => [a] -> a
dec2int'2 = foldl(\acc x -> (+) (10 * acc) x) 0

dec2int'3 :: (Integral a) => [a] -> a
dec2int'3 = foldl(\acc -> (+) (10 * acc)) 0

dec2int'4 :: (Integral a) => [a] -> a
dec2int'4 = foldl(\acc -> (+) ((10 *) acc)) 0

dec2int'5 :: (Integral a) => [a] -> a
dec2int'5 = foldl(\acc -> ((+) . (10 *)) acc) 0

dec2int'6 :: (Integral a) => [a] -> a
dec2int'6 = foldl((+) . (10 *)) 0

-- 3.7c
myReverse :: [a] -> [a]
myReverse l = foldr (\x acc -> acc ++ [x]) [] l

--3.7d
myReverse' :: [a] -> [a]
myReverse' l = foldl (\acc x -> x:acc) [] l
-- conversão em point-free
myReverse1' :: [a] -> [a]
myReverse1' = foldl (\acc x -> x:acc) []

myReverse2' :: [a] -> [a]
myReverse2' = foldl (\acc x -> (:) x acc) []

myReverse3' :: [a] -> [a]
myReverse3' = foldl (\acc x -> flip (:) acc x) []

myReverse4' :: [a] -> [a]
myReverse4' = foldl (flip (:)) []

--3.11
approx1 :: Int -> Double
approx1 n = sum [4*(fromIntegral(-1)^i) / fromIntegral(2*i + 1) | i <- [ 0 .. (n-1)]]

approx1' :: Int -> Double
approx1' n = sum $ take n (zipWith (/) (cycle [4, -4]) (map (\x -> 2*x + 1) [0 ..]))

approx2' :: Int -> Double
approx2' n = sum $ take n (zipWith (/) (cycle [4, -4]) [1,3 ..])

--2.16
fazer
