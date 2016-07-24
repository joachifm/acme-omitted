{-|
Module      : Acme.Undefined
Description : Undefined redefined
Copyright   : (c) 2013-2016 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : stable
Portability : portable
-}

module Acme.Undefined (
    undefined
  ) where

import Prelude hiding (undefined)

{-|
Denotes all values that are, fundamentally, undefinable.  The contract of
'undefined' is that it will never be used for merely omitted definitions.
-}
undefined :: a
undefined = error "Acme.Undefined.undefined"
