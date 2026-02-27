# transform.jl
# Reads "Untitled-1" and writes "Untitled-1.out" where every non-empty input line
# is converted to a bracketed vector with a trailing comma (blank lines -> [],).
lines = readlines("G_value.txt")
out = String[]
for l in lines
    if occursin(r"^\s*G_value\s*=\s*\[", l)   # keep the opening line as-is
        push!(out, l)
    elseif occursin(r"^\s*\]\s*$", l)         # keep the final closing bracket as-is
        push!(out, l)
    else
        s = strip(l)
        if s == ""
            push!(out, "[],")
        else
            s = replace(s, r",\s*$" => "")   # drop existing trailing comma
            # if already bracketed, strip outer brackets
            if startswith(s, "[") && endswith(s, "]")
                inner = s[2:end-1]
            else
                inner = s
            end
            tokens = split(inner)             # split on whitespace/tabs
            joined = join(tokens, ", ")
            push!(out, "[$joined],")
        end
    end
end
write("G_value_out.txt", join(out, "\n"))
