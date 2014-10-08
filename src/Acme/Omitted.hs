{-|
Module      : Acme.Omitted
Description : A universal definition of omitted content
Copyright   : (c) 2013-2014 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : stable
Portability : portable

A definition of \"omitted content\", definitions that are not inherently
undefinable, but currently not provided (for whatever reason).
-}

module Acme.Omitted
  (
    -- * Usage
    --
    -- $usage

    -- * A universal definition of \"omitted content\"
    --
    -- $omitted
    omitted
  , (...)

  ) where

{-$omitted

The difference between \"omitted\" and \"undefined\" is that the
programmer may choose to omit something but she cannot define the
undefinable.
The former is contingent on the whims of the programmer, the latter
a fundamental truth.

Operationally, there is no difference between undefined and omitted;
attempting to evaluate either is treated as an error.

Ideally, programmers would only ever use 'undefined' for things that
are truly undefined, e.g., division by zero, and use 'omitted' for
definitions that have yet to be written or that are currently not needed.
-}

-- | Alternative syntax for 'omitted' that has been carefully
-- optimised for programmer convenience and visual presentation
-- (e.g., for use in printed documents).
--
-- Example usage:
--
--    > definition = (...)
(...) :: a
(...) = omitted

-- | The universal omitted content indicator.
--
-- This is sufficient to express _all_ types of omitted content
omitted :: a
omitted = error "Acme.Omitted.omitted"
