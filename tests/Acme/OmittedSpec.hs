module Acme.OmittedSpec where

import Acme.Omitted
import Test.Hspec

spec :: Spec
spec = do
  describe "omitted" $ do
    it "denotes an omitted definition" $ do
      omitted `shouldThrow` errorCall "Acme.Omitted.omitted"
