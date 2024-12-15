module Main where

<<<<<<< HEAD
main :: IO ()
main = putStrLn "Hello, Haskell!,My name is Canis Ouambo"
=======
import Data.List
import Data.Char
import System.IO

type Board = [String]

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Welcome to Tic Tac Toe!"
    let board = replicate 3 "   "
    playGame board 'X'

displayBoard :: Board -> IO ()
displayBoard board = do
    putStrLn $ intercalate "\n---+---+---\n" $ map (intercalate " | ") $ map (map (:[])) board

checkWin :: Board -> Char -> Bool
checkWin board player =
    any (all (== player)) (rows ++ cols ++ diags)
    where
        rows = board
        cols = transpose board
        diags = [diag1, diag2]
        diag1 = [board !! i !! i | i <- [0..2]]
        diag2 = [board !! i !! (2 - i) | i <- [0..2]]

isFull :: Board -> Bool
isFull = all (all (/= ' '))

playGame :: Board -> Char -> IO ()
playGame board player = do
    displayBoard board
    if checkWin board (nextPlayer player)
        then putStrLn $ "Player " ++ [nextPlayer player] ++ " wins!"
        else if isFull board
            then putStrLn "It's a draw!"
            else do
                putStrLn $ "Player " ++ [player] ++ "'s turn. Enter your move as 'row col' (e.g., 0 0 for top-left):"
                move <- getLine
                let (row, col) = parseMove move
                if isValidMove board row col
                    then playGame (makeMove board player row col) (nextPlayer player)
                    else do
                        putStrLn "Invalid move! Try again."
                        playGame board player

nextPlayer :: Char -> Char
nextPlayer 'X' = 'O'
nextPlayer _ = 'X'

parseMove :: String -> (Int, Int)
parseMove move =
    let [row, col] = words move
    in (read row, read col)

isValidMove :: Board -> Int -> Int -> Bool
isValidMove board row col = board !! row !! col == ' '

makeMove :: Board -> Char -> Int -> Int -> Board
makeMove board player row col =
    let (r1, r:rs) = splitAt row board
        (c1, _:cs) = splitAt col r
    in r1 ++ ((c1 ++ [player]) ++ cs) : rs
>>>>>>> acf3139 ( Initial commit: Setting up the Tic Tac Toe game project in Haskell!)
