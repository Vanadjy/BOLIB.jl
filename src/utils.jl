export get_x0, get_y0, get_opt_val

function get_x0(model::BilevelProblem)
    xy0 = model.xy0
    dims = model.dim
    return xy0[1:dims[1]]
end

function get_y0(model::BilevelProblem)
    xy0 = model.xy0
    dims = model.dim
    return xy0[dims[1]+1:end]
end

function get_opt_val(model::BilevelProblem)
    if model.sol !== nothing && !isempty(model.sol)
        if model.sol isa Vector{Float64}
            x_star = model.sol[1:model.dim[1]]
            y_star = model.sol[model.dim[1]+1:model.dim[1]+model.dim[2]]
            return model.F_func(x_star, y_star)
        else
            return model.sol
        end
    else
        return NaN
    end
end