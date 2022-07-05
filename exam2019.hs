h _ base [] = base
h op base (x:xs) = h op (op base x) xs
