# compute the required multiplication modules

from numpy import uintc

def get_required_bit_depths(bit_depth: uintc) -> set :
    '''Return a set of required bit depth for all multiplication modules.
    '''

    # set to store the bit depths
    bit_depths = set()

    # bit depth for multiplication modules still to be processes
    to_process = [bit_depth]

    while to_process :
        current_bit_depth = to_process.pop()

        # if current_bit_depth is already in bit_depths, it has already been processed
        if not(current_bit_depth in bit_depths):

            # add the current bit depth to the results
            bit_depths.add(current_bit_depth) 

            # current_bit_depth // 2 (to compute a_1 b_1) and current_bit_depth // 2 + 1
            # (to compute a_0 b_0 if current_bit_depth is odd or (a_0 + b_0) (a_1 + b_1) if it is 
            # even) are wlways needed except if current_bit_depth is 1
            if current_bit_depth > 1 :
                to_process.append(current_bit_depth // 2)
                to_process.append(current_bit_depth // 2 + 1)

                # current_bit_depth // 2 + 2 is needed for (a_0 + b_0) (a_1 + b_1) if 
                # current_bit_depth is odd
                if (current_bit_depth % 2 == 1):
                    to_process.append(current_bit_depth // 2 + 2)

    return bit_depths
