module Acme.UndefinedSpec where

import Acme.Undefined
import Prelude hiding (undefined)
import Test.Hspec

spec :: Spec
spec = do
  describe "undefined" $ do
    it "denotes the undefinable" $
      undefined `shouldThrow` errorCall "Acme.Undefined.undefined"
