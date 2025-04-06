--------------------------------------------------------------------------------
-- DO NOT MODIFY ANYTHING IN THIS FILE -----------------------------------------
--------------------------------------------------------------------------------

{-# LANGUAGE ScopedTypeVariables #-}

import Data.IORef
import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.Runners
import System.Exit
import Control.Exception
import Language.Elsa
import System.FilePath

main :: IO ()
main = runTests [unit1]

unit1 :: Score -> TestTree
unit1 sc = testGroup "Unit 1"
  [ mkTest
      (check "01_bool.lc")
      "not_false"
      True
      5
      "bool: not_false"
  , mkTest
      (check "01_bool.lc")
      "and_false_true"
      True
      5
      "bool: and_false_true"
  , mkTest
      (check "01_bool.lc")
      "or_true_false"
      True
      5
      "bool: or_true_false"
  , mkTest
      (check "02_plus.lc")
      "incr_one"
      True
      10
      "add: incr_one"
  , mkTest
      (check "02_plus.lc")
      "add_one_zero"
      True
      10
      "add: add_one_zero"
  , mkTest
      (check "02_plus.lc")
      "add_one_two"
      True
      10
      "add: add_one_two"
  , mkTest
      (check "03_minus.lc")
      "skip1_false"
      True
      10
      "skip1_false"
  , mkTest
      (check "03_minus.lc")
      "skip1_true_zero"
      True
      10
      "skip1_true_zero"
  , mkTest
      (check "03_minus.lc")
      "skip1_true_one"
      True
      10
      "skip1_true_one"
  , mkTest
      (check "03_minus.lc")
      "decr_zero"
      True
      5
      "decr_zero"
  , mkTest
      (check "03_minus.lc")
      "decr_one"
      True
      5
      "decr_one"
  , mkTest
      (check "03_minus.lc")
      "decr_two"
      True
      5
      "decr_two"

  , mkTest
      (check "03_minus.lc")
      "sub_two_zero"
      True
      5
      "sub_two_zero"
  , mkTest
      (check "03_minus.lc")
      "sub_two_one"
      True
      5
      "sub_two_one"
  , mkTest
      (check "03_minus.lc")
      "sub_two_two"
      True
      5
      "sub_two_two"
  , mkTest
      (check "03_minus.lc")
      "sub_one_two"
      True
      5
      "sub_one_two"
  , mkTest
      (check "03_minus.lc")
      "isz_zero"
      True
      5
      "isz_zero"
  , mkTest
      (check "03_minus.lc")
      "isz_one"
      True
      5
      "isz_one"

  , mkTest
      (check "03_minus.lc")
      "eq_zero_zero"
      True
      5
      "eq_zero_zero"
  , mkTest
      (check "03_minus.lc")
      "eq_zero_one"
      True
      5
      "eq_zero_one"
  , mkTest
      (check "03_minus.lc")
      "eq_one_two"
      True
      5
      "eq_one_two"
  , mkTest
      (check "03_minus.lc")
      "eq_two_two"
      True
      5
      "eq_two_two"
  , mkTest
      (check "03_minus.lc")
      "eq_two_one"
      True
      5
      "eq_two_one"
  ]
  where
    mkTest :: (Show b, Eq b) => (a -> IO b) -> a -> b -> Int -> String -> TestTree
    mkTest = scoreTest' sc

--------------------------------------------------------------------------------
-- | runElsa checks if the single eval-target `x` in file `f` is OK.
--------------------------------------------------------------------------------
check :: FilePath -> Id -> IO Bool
check f x = do
  r <- runElsaId (testDir </> f) x
  return (r == Just (OK (Bind x ())))

testDir :: FilePath
testDir = "tests"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

type Score = IORef (Int, Int)

runTests :: [Score -> TestTree] -> IO ()
runTests groups = do
  sc <- initScore
  defaultMainWithIngredients (includingOptions coreOptions : defaultIngredients) 
    (tests sc groups) `catch` (\(e :: ExitCode) -> do
      (n, tot) <- readIORef sc
      putStrLn ("OVERALL SCORE = " ++ show n ++ " / "++ show tot)
      case (tot > 0) of
        True -> throwIO e
        False -> exitFailure
    )

tests :: Score -> [Score -> TestTree] -> TestTree
tests x gs = testGroup "Tests" [ g x | g <- gs ]

--------------------------------------------------------------------------------
-- | Construct a single test case
--------------------------------------------------------------------------------
scoreTest'
 :: (Show b, Eq b) => Score -> (a -> IO b) -> a -> b -> Int -> String -> TestTree
--------------------------------------------------------------------------------
scoreTest' sc f x expR points name =
  testCase name $ do
    updateTotal sc points
    actR <- f x
    if actR == expR
      then updateCurrent sc points
      else assertFailure "Wrong Result"

updateTotal :: Score -> Int -> IO ()
updateTotal sc n = modifyIORef sc (\(x, y) -> (x, y + n))

updateCurrent :: Score -> Int -> IO ()
updateCurrent sc n = modifyIORef sc (\(x, y) -> (x + n, y))

initScore :: IO Score
initScore = newIORef (0, 0)
