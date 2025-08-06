MAX_JOBS=200 PYTORCH_NVCC=/root/workspace/llvm-project/build/bin/clang++ python ./setup.py install &> build.log

HIP_VISIBLE_DEVICES=1 pytest tests/test_flash_attn_ck.py --shard-id=0 --num-shards=7 --maxfail=5 &> test_shard0.log &
HIP_VISIBLE_DEVICES=2 pytest tests/test_flash_attn_ck.py --shard-id=1 --num-shards=7 --maxfail=5 &> test_shard1.log &
HIP_VISIBLE_DEVICES=3 pytest tests/test_flash_attn_ck.py --shard-id=2 --num-shards=7 --maxfail=5 &> test_shard2.log &
HIP_VISIBLE_DEVICES=4 pytest tests/test_flash_attn_ck.py --shard-id=3 --num-shards=7 --maxfail=5 &> test_shard3.log &
HIP_VISIBLE_DEVICES=5 pytest tests/test_flash_attn_ck.py --shard-id=4 --num-shards=7 --maxfail=5 &> test_shard4.log &
HIP_VISIBLE_DEVICES=6 pytest tests/test_flash_attn_ck.py --shard-id=5 --num-shards=7 --maxfail=5 &> test_shard5.log &
HIP_VISIBLE_DEVICES=7 pytest tests/test_flash_attn_ck.py --shard-id=6 --num-shards=7 --maxfail=5 &> test_shard6.log &
wait && grep ' skipped,' ./test_shard* &>> build.log
grep 'FAILED tests/test_flash_attn_ck.py::' ./test_shard* &>> build.log
