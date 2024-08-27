# HashLists

[![Build Status](https://github.com/ZeeZedZhi/HashLists.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ZeeZedZhi/HashLists.jl/actions/workflows/CI.yml?query=branch%3Amain)

```HashList``` a linked with O(1) lookup time—or at least as fast as ```haskey``` for ```Dict```.

Usage:
```
hashlist = HashList{Int}()
push!(hashlist, 1)                  # O(1)
push!.(Ref(hashlist), [2, 3, 4])
delete!(hashlist, 2)                # O(1)
delete!(hashlist, 2)                # no error
pop!(hashlist, 3)                   # O(1)
pop!(hashlist, 3)                   # throws error
3 in hashlist                       # O(1); returns true
2 in hashlist                       # returns false
collect(hashlist)                   # returns [1, 4]
length(hashlist)                    # returns 2
```
