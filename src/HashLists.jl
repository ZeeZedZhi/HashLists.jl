module HashLists

export HashList

mutable struct HashList{T} <: AbstractArray{T, 1}
	head::Union{Nothing, T}
	tail::Union{Nothing, T}
	list::Dict{T, T}
	listReverse::Dict{T, T}

	function HashList{T}() where {T}
		return new(nothing, nothing, Dict{T, T}(), Dict{T, T}())
	end
end


function Base.in(left::T, hashlist::HashList{T}) where {T}
	return haskey(hashlist.list, left)
end


function Base.push!(hashlist::HashList{T}, x::T) where {T}
	if x in hashlist
		return
	end

	try
		hashlist.list[hashlist.tail] = x
		hashlist.listReverse[x] = hashlist.tail
		hashlist.list[x] = x
	catch
		hashlist.list[x] = x
		hashlist.head = x
	end
	hashlist.tail = x
end


function Base.delete!(hashlist::HashList{T}, x::T) where {T}
	if x in hashlist
		if x == hashlist.head
			right = hashlist.list[x]
			if x == right
				delete!(hashlist.list, x)
				hashlist.head = nothing
				hashlist.tail = nothing
			else
				right = hashlist.list[x]
				delete!(hashlist.list, x)
				delete!(hashlist.listReverse, right)
				hashlist.head = right
			end
		elseif x == hashlist.tail
			left = hashlist.listReverse[x]
			hashlist.list[left] = left
			delete!(hashlist.list, x)
			delete!(hashlist.listReverse, x)
			hashlist.tail = left
		else
			left = hashlist.listReverse[x]
			right = hashlist.list[x]
			hashlist.list[left] = right
			hashlist.listReverse[right] = left
			delete!(hashlist.list, x)
			delete!(hashlist.listReverse, x)
		end
	end
end


function Base.pop!(hashlist::HashList{T}, x::T) where {T}
	if x in hashlist
		delete!(hashlist, x)
	else
		throw(KeyError(x))
	end
end


function Base.iterate(hashlist::HashList)
	return isnothing(hashlist.head) ? nothing : (hashlist.head, hashlist.head)
end

function Base.iterate(hashlist::HashList, state)
	return state == hashlist.tail ? nothing : (hashlist.list[state], hashlist.list[state])
end


function Base.getindex(hashlist::HashList, i::Int)
	entry = hashlist.head
	for i in 2:i
		entry = hashlist.list[entry]
	end
	return entry
end


function Base.length(hashlist::HashList)
	return length(hashlist.list)
end


function Base.size(hashlist::HashList)
	return (length(hashlist),)
end


Base.show(io::IO, hashlist::HashList) = print([x for x in hashlist])


Base.Tuple(hashlist::HashList) = Tuple(entry for entry in hashlist)

end
