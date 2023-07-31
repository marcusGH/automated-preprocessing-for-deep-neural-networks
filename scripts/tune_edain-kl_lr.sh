#!/bin/bash

declare -a scale_lrs=(100 10 1 0.1 0.01)
declare -a shift_lrs=(100 10 1 0.1 0.01)
declare -a outlier_lrs=(100 10 1 0.1 0.01)
i=0

for LR_scale in "${scale_lrs[@]}" ; do
    for LR_shift in "${shift_lrs[@]}" ; do
        for LR_out in "${outlier_lrs[@]}" ; do
            CMD="CUDA_VISIBLE_DEVICES=2,3,4,5,6,7 python3 src/experiments/run_experiment.py --experiment-config src/experiments/configs/experiment-config-alpha.yaml --device 0 --dataset amex --model gru-rnn --preprocessing-method min-max --num-cross-validation-folds 1 --edain-kl --experiment-name edain-kl-tuning-${i} --override='edain_bijector_fit:scale_lr:${LR_scale} edain_bijector_fit:shift_lr:${LR_shift} edain_bijector_fit:outlier_lr:${LR_out} edain_bijector_fit:power_lr:0.0000001 fit:num_epochs:10'"
            i=$((i+1))
            eval "$CMD"
        done 
    done 
done
