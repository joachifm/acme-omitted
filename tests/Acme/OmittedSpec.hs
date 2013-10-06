module Acme.OmittedSpec where

import Prelude hiding (undefined)
import qualified Prelude
import Acme.Omitted
import Test.Hspec

------------------------------------------------------------------------

spec :: Spec
spec = do
  describe "omitted" $ do
    it "denotes omitted content" $ do
      omitted `shouldThrow` errorCall "omitted"
  describe "isOmitted" $ do
    it "isOmitted 0         = False" $ do
      isOmitted zero `shouldReturn` False
    it "isOmitted undefined = False" $ do
      isOmitted undefined `shouldReturn` False
    it "isOmitted omitted   = True" $ do
      isOmitted omitted  `shouldReturn` True
  describe "isUndefined" $ do
    it "isUndefined 0         = False" $ do
      isUndefined zero `shouldReturn` False
    it "isUndefined undefined = True" $ do
      isUndefined undefined `shouldReturn` True
    it "isUndefined omitted   = False" $ do
      isUndefined omitted  `shouldReturn` False
    it "isUndefined Prelude.undefined = False" $ do
      isUndefined Prelude.undefined `shouldReturn` False
  describe "isPreludeUndefined" $ do
    it "isPreludeUndefined 0         = False" $ do
      isPreludeUndefined zero `shouldReturn` False
    it "isPreludeUndefined undefined = False" $ do
      isPreludeUndefined undefined `shouldReturn` False
    it "isPreludeUndefined omitted   = False" $ do
      isPreludeUndefined omitted  `shouldReturn` False
    it "isPreludeUndefined Prelude.undefined = True" $ do
      isPreludeUndefined Prelude.undefined `shouldReturn` True

zero :: Integer
zero = 0
