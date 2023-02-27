set -e

GRAPH=(  
    #cholesky  
    #gemm    
    #gesummv  
    #symm  
    #trmm
    #bicg  
    #doitgen   
    #gemver  
    #mvt      
    #syrk
    atax
    conv3
    arf
    collapse_pyr
    cosine1
    ewf
    h2v2_smooth
)

ARCH=( # 0 = mesh, 1 = 1-hop, 2 = chess, 3 = hex
    0 
    #1
)

SIZE=(
    #1 
    #10 
    #100 
    1000
)

PROG=( # 0 = yolt, 1 = yott, 2 = sa
    #0
    #1
    2
)

# build and constructor the code
mkdir -p build && cd build && cmake .. && make -j 7 && cd ..

NUM_THREADS=8

export OMP_NUM_THREADS=$NUM_THREADS

mkdir -p ../exp_results/placements

for ((l=0; l < ${#PROG[@]}; l++)) do
    echo "Tool: "${PROG[l]}
    for ((k=0; k < ${#SIZE[@]}; k++)) do
        echo "SIZE: "${SIZE[k]}
        for ((j=0; j < ${#ARCH[@]}; j++)) do
            
            if [ ${ARCH[j]} == 0 ]; then
                #mkdir -p ../exp_results/placements/yolt/mesh/${SIZE[k]}
                #mkdir -p ../exp_results/placements/yott/mesh/${SIZE[k]}
                mkdir -p ../exp_results/placements/sa/mesh/assincrono_optimal/${SIZE[k]}
                echo "ARCH: MESH"
            elif [ ${ARCH[j]} == 1 ]; then
                #mkdir -p ../exp_results/placements/yolt/1hop/${SIZE[k]}
                #mkdir -p ../exp_results/placements/yott/1hop/${SIZE[k]}
                mkdir -p ../exp_results/placements/sa/1hop/${SIZE[k]}
                echo "ARCH: 1HOP"
            fi
            
            for ((i=0; i < ${#GRAPH[@]}; i++)) do

                echo "GRAPH: ${GRAPH[i]}"
                DOT="../bench/test_bench/assincrono_optimal/"${GRAPH[i]}".dot"
        
                # bench ngrids program arch
                ./build/main $DOT ${SIZE[k]} ${PROG[l]} ${ARCH[j]} 
            done
        done
    done
done
