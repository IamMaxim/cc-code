

function vec3(x_, y_, z_)
    vec = {
        x = x_,
        y = y_,
        z = z_
    }

    vec.add = function(x__, y__, z__)
        vec.x += x__
        vec.y += y__
        vec.z += z__
    end
end