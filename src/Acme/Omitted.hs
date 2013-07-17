{- |
Module      : Acme.Omitted
Description : The universal omitted content operator
Copyright   : (c) 2013 Joachim Fasting
License     : BSD3

Maintainer  : joachim.fasting@gmail.com
Stability   : stable
Portability : portable

An implementation of the universal omitted content operator.
This makes it possible to differentiate between the truly \"undefined\"
and the merely \"omitted\".
-}

module Acme.Omitted ((...), omitted) where

-- | Alternative syntax for 'omitted' that has been carefully
-- optimised for programmer convenience and visual presentation
-- (e.g., for use in printed documents).
--
-- Example usage:
--
--    > definition = (...)
(...) :: a
(...) = omitted

-- | The universal omitted content operator.
--
-- This is sufficient to express _all_ types of omitted content
omitted :: a
omitted = error "omitted"
