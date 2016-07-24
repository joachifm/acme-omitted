{-|
Module      : Acme.Undefined
Description : Undefined redefined
Copyright   : (c) 2013-2016 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : stable
Portability : portable

This module provides an alternative implementation of
\"Prelude.undefined\", intended exclusively for denoting
truly undefinable values.
-}

module Acme.Undefined (
    -- * \"Undefined\" redefined
    --
    -- $undefined
    undefined
  ) where

import Prelude hiding (undefined)

{-$undefined

Lacking a dedicated name for omitted defintions, users of Standard
Haskell are left with no choice but to use \"undefined\" for both
the undefinable and the omitted.
This makes the standard implementation of \"undefined\" deficient, we
cannot be sure what the programmer has intended, only that the definition is
missing.
The following implementation of undefined is similar in every way to
the standard implementation, but is free from conceptual contamination.
-}

-- | Denotes all values that are, fundamentally, undefinable.
--
-- The contract of 'undefined' is that it will never be used for
-- merely omitted definitions.
undefined :: a
undefined = error "Acme.Undefined.undefined"
