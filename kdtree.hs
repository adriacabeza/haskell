
class Point p where 
-- donat un número que indica la coordenada i un element de tipus p retorna el valor de la coordenada 
    sel :: Int -> p -> Double

-- donat un element de tipus p retorna la seva dimensió
    dim:: p -> Int


-- donat dos elements e1 i e2 de tipus p que representen punts
-- i una llista de coordenades seleccionades retorna el número
-- fill de e2 que li toca a e1
    child:: p-> p-> [Int]->Int

-- donats dos elements e1 i e2 de tipus p ens retorna un Double que 
-- és la distància entre e1 i e2
    dist:: p->  p -> Double

--rep una llista de double i retorna un element de tipus p
    list2Point:: [Double]-> p 

    --compara dos coordenades de dos punts i si la segona és mes gran que la primera dóna 1 i sinó 0
    comp:: p -> p -> Int -> Int


--feu que sigui instance d'aquesta classe, cosa que us obligarà
-- a definir les quatre funcions anteriors.
-- posteriorment haurem de fer que sigui de la classe Eq i de la
-- -- classe Show.
data Point3d = Point3d [Double]
    deriving (Eq)

instance Point Point3d where

    sel coord (Point3d p1) = p1 !! coord
    
    dim _ = 3

    comp n1 n2 x
        | (sel (x-1) n1) >= (sel (x-1) n2)  =0
        | otherwise =1

    child e1 e2 l = binarytoNum  $ map (comp e1 e2) l
            
    dist (Point3d e1) (Point3d e2) = sqrt(sum (map (^2) (zipWith (-) e1 e2) ))
    
    list2Point l = Point3d l

instance Show Point3d where
    show (Point3d x) =   "(" ++ init((concatMap (\x -> (show x) ++ ",") x)) ++ ")"

   

  --funció auxiliar
binarytoNum:: [Int] -> Int
binarytoNum [x] = x 
binarytoNum (x:xs) = x * 2^((length xs)) + binarytoNum xs



data Kd2nTree a = Node a [Int] (Kd2nTree a) | Empty

-- exampleSet :: Kd2nTree Point3d 
-- exampleSet = build [(Point3d [3.0,1.0,2.1],[1,3]),(Point3d [3.5,2.8,3.1],[1,2]),(Point3d [3.5,0.0,2.1],[3]),(Point3d [3.0,1.7,3.1],[1,2,3]), (Point3d [3.0,5.1,0.0],[2]),(Point3d [1.5,8.0,1.5],[1]),(Point3d [3.3,2.8,2.5],[3]),(Point3d [4.0,5.1,3.8],[2]), (Point3d [3.1,3.8,4.8],[1,3]),(Point3d [1.8,1.1,2.0],[1,2])]

--pensar pq l'enunciat diu que la igualtat estructural no val ja que dos conjunts són iguals si contenen els mateixos punts
instance Eq a => Eq (Kd2nTree a) where
    Empty == Empty  =True
    _ == Empty  =False
    Empty == _  = False
    (Node x l f) == (Node y k g) = (x == y && l == k && f == g)

instance Show a => Show (Kd2nTree a) where
    show Empty = ""
    show (Node a l f) = "("++ show(a)++") " ++ show(l) ++ "\n" -- ++ show2 f

