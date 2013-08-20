module Acme.OmittedSpec where

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
      isOmitted 0 `shouldReturn` False
    it "isOmitted undefined = False" $ do
      isOmitted undefined `shouldReturn` False
    it "isOmitted omitted   = True" $ do
      isOmitted omitted  `shouldReturn` True
  describe "isUndefined" $ do
    it "isUndefined 0         = False" $ do
      isUndefined 0 `shouldReturn` False
    it "isUndefined undefined = True" $ do
      isUndefined undefined `shouldReturn` True
    it "isUndefined omitted   = False" $ do
      isUndefined omitted  `shouldReturn` False
