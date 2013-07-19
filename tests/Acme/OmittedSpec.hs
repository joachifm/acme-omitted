module Acme.OmittedSpec where

import Acme.Omitted
import Test.Hspec

------------------------------------------------------------------------

spec :: Spec
spec = do
  describe "omitted" $ do
    it "denotes omitted content" $ do
      omitted `shouldThrow` errorCall "omitted"
