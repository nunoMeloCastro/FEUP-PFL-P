data Map k v = Empty | Node (k,v) (Map k v) (Map k v) deriving Show

empty :: Map k v
empty = Empty

insert :: Ord k => k -> v -> Map k v -> Map k v
insert k v Empty = Node (k, v) Empty empty
insert k v Empty (Node (k1, v1) l r)
  | k < k1 = Node (k1, v1) (insert k v l) r
  | k > k1 = Node (k1, v1) l (insert k v r)
  | otherwise = Node (k, v) l r

lookup :: Ord k => k -> Map k v -> Maybe v
lookup _ Empty = Nothing
lookup k (Node (k1, v1) l r)
  | k < k1 = lookup k l
  | k > k1 = lookup k r
  | otherwise = lookup
