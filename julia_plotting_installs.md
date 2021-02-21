Trying to get `Plots to work.

```
using Plots

ERROR: LoadError: LoadError: Failed to precompile libass_jll [0ac62f75-1d6f-5e53-bd7c-93b484bb37c0] to /home/ec2-user/.julia/compiled/v1.5/libass_jll/JqZi8_vFGwo.ji.
Stacktrace:
 [1] top-level scope at /home/ec2-user/.julia/packages/JLLWrappers/WnWcZ/src/toplevel_generators.jl:170
 [2] top-level scope at none:2
 [3] eval at ./boot.jl:331 [inlined]
in expression starting at /home/ec2-user/.julia/packages/FFMPEG_jll/xCSqL/src/wrappers/x86_64-linux-gnu.jl:4
in expression starting at /home/ec2-user/.julia/packages/FFMPEG_jll/xCSqL/src/FFMPEG_jll.jl:8
ERROR: LoadError: Failed to precompile FFMPEG_jll [b22a6f82-2f65-5046-a5b2-351ab43fb4e5] to /home/ec2-user/.julia/compiled/v1.5/FFMPEG_jll/uSD0T_vFGwo.ji.
Stacktrace:
 [1] top-level scope at none:2
 [2] eval at ./boot.jl:331 [inlined]
in expression starting at /home/ec2-user/.julia/packages/FFMPEG/aazvf/src/FFMPEG.jl:3
ERROR: LoadError: Failed to precompile FFMPEG [c87230d0-a227-11e9-1b43-d7ebe4e7570a] to /home/ec2-user/.julia/compiled/v1.5/FFMPEG/TGvga_vFGwo.ji.
```

My approach for installing this is to add each package mentioned in the above error message through the package manager, and then precompile it with `using`.
I've done four cycles of this- pretty tedious.
One would think that the package manager handled recursive dependencies.
