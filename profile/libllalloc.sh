for f in {/opt,/usr/local,~/.local}/lib/libllalloc.so; do
	[ -r $f ] && {
		export ALLOCATOR="LD_PRELOAD=$f"
		break
	}
done
