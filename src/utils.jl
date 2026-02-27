export get_x0, get_y0

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