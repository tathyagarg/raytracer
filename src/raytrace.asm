; Get the direction vector's x from the camera to the pixel
; Input:  x = pixel x, y = pixel y
; Output: xmm0 = direction vector's x
get_direction_x:
    movsd xmm0, [x]
    mulsd xmm0, [rel COS_CAM_DIR_Y]
    mulsd xmm0, [rel COS_CAM_DIR_Z]

    movsd xmm1, [rel SIN_CAM_DIR_X]
    mulsd xmm1, [rel SIN_CAM_DIR_Y]
    mulsd xmm1, [rel COS_CAM_DIR_Z]

    movsd xmm2, [rel COS_CAM_DIR_X]
    mulsd xmm2, [rel SIN_CAM_DIR_Z]
    subsd xmm1, xmm2

    mulsd xmm1, [y]
    addsd xmm0, xmm1

    movsd xmm1, [rel COS_CAM_DIR_X]
    mulsd xmm1, [rel SIN_CAM_DIR_Y]
    mulsd xmm1, [rel COS_CAM_DIR_Z]

    movsd xmm2, [rel SIN_CAM_DIR_X]
    mulsd xmm2, [rel SIN_CAM_DIR_Z]
    addsd xmm1, xmm2
    addsd xmm0, xmm1

    ret

get_direction_y:
    movsd xmm0, [x]
    mulsd xmm0, [rel COS_CAM_DIR_Y]
    mulsd xmm0, [rel SIN_CAM_DIR_Z]

    movsd xmm1, [rel SIN_CAM_DIR_X]
    mulsd xmm1, [rel SIN_CAM_DIR_Y]
    mulsd xmm1, [rel SIN_CAM_DIR_Z]

    movsd xmm2, [rel COS_CAM_DIR_X]
    mulsd xmm2, [rel COS_CAM_DIR_Z]
    addsd xmm1, xmm2

    mulsd xmm1, [y]
    addsd xmm0, xmm1

    movsd xmm1, [rel COS_CAM_DIR_X]
    mulsd xmm1, [rel SIN_CAM_DIR_Y]
    mulsd xmm1, [rel SIN_CAM_DIR_Z]

    movsd xmm2, [rel SIN_CAM_DIR_X]
    mulsd xmm2, [rel COS_CAM_DIR_Z]
    subsd xmm1, xmm2
    addsd xmm0, xmm1
    ret

get_direction_z:
    movsd xmm0, [x]
    mulsd xmm0, [rel SIN_CAM_DIR_Y]
    mulsd xmm0, [rel neg_one]

    movsd xmm1, [y]
    mulsd xmm1, [rel SIN_CAM_DIR_X]
    mulsd xmm1, [rel COS_CAM_DIR_Y]
    addsd xmm0, xmm1

    movsd xmm1, [rel COS_CAM_DIR_X]
    mulsd xmm1, [rel COS_CAM_DIR_Y]
    addsd xmm0, xmm1

    ret

normalize:
    movsd xmm4, xmm0
    movsd xmm5, xmm1
    movsd xmm6, xmm2

    mulsd xmm4, xmm4
    mulsd xmm5, xmm5
    mulsd xmm6, xmm6
    addsd xmm4, xmm5
    addsd xmm4, xmm6
    sqrtsd xmm4, xmm4
  
    divsd xmm2, xmm4
    divsd xmm1, xmm4
    divsd xmm0, xmm4
  
    ret
