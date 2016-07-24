{-|
Module      : Acme.Omitted
Description : A name for omitted definitions
Copyright   : (c) 2013-2014 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : stable
Portability : portable

This module provides the means to indicate that a definition
has been omitted (for whatever reason), as opposed to being
inherently undefinable.
-}

module Acme.Omitted
  (
    omitted
  , (...)

  ) where

{-|
Alternative syntax for 'omitted' that has been carefully optimised for
programmer convenience and visual presentation (e.g., for use in printed
documents).

Example usage:

  > definition = (...)
-}
(...) :: a
(...) = omitted

-- | Indicate that a definition has been omitted.
omitted :: a
omitted = error "Acme.Omitted.omitted"
