#!/usr/bin/env bash

# Array of submodules and their desired commit hashes
declare -A submodule_commits=(
    ["vendor/db_connector"]="74aef399e5c232f95c9fc5c987cebac846f09d62"
    ["vendor/dnsclient.nim"]="23214235d4784d24aceed99bbfe153379ea557c8"
    ["vendor/nim-bearssl"]="667b40440a53a58e9f922e29e20818720c62d9ac"
    ["vendor/nim-chronicles"]="81a4a7a360c78be9c80c8f735c76b6d4a1517304"
    ["vendor/nim-chronos"]="c04576d829b8a0a1b12baaa8bc92037501b3a4a0"
    ["vendor/nim-confutils"]="e214b3992a31acece6a9aada7d0a1ad37c928f3b"
    ["vendor/nim-dnsdisc"]="c3d37c2860bcef9e3e2616ee4c53100fe7f0e845"
    ["vendor/nim-eth"]="c6c9dc7ae01656eba8126b913e84bdfb95c8c323"
    ["vendor/nim-faststreams"]="2b08c774afaafd600cf4c6f994cf78b8aa090c0c"
    ["vendor/nim-http-utils"]="79cbab1460f4c0cdde2084589d017c43a3d7b4f1"
    ["vendor/nim-json-rpc"]="c0ac848733e42e672081f429fb146451894f7711"
    ["vendor/nim-json-serialization"]="2b1c5eb11df3647a2cee107cd4cce3593cbb8bcf"
    ["vendor/nim-libbacktrace"]="dbade9ba250da7db519c5cdfb225d03ca1255efc"
    ["vendor/nim-libp2p"]="78a434405435b69a24e8b263d48d622d57c4db5b"
    ["vendor/nim-metrics"]="25ffd054fd774f8cf7935e75d6cad542306d7802"
    ["vendor/nim-minilru"]="2682cffa8733f3b61751c65a963941315e887bac"
    ["vendor/nim-nat-traversal"]="213ac13dfe5c4830474912c48181b86b73f1ec1f"
    ["vendor/nim-presto"]="3ccb356220b70f7d9eb0fbd58b674c4080f78014"
    ["vendor/nim-regex"]="0673df07cb266e15942c3b5f5b8a4732f049cd73"
    ["vendor/nim-results"]="df8113dda4c2d74d460a8fa98252b0b771bf1f27"
    ["vendor/nim-secp256k1"]="62e16b4dff513f1eea7148a8cbba8a8c547b9546"
    ["vendor/nim-serialization"]="2086c99608b4bf472e1ef5fe063710f280243396"
    ["vendor/nim-sqlite3-abi"]="cc4fefd538aa43814c5864c540fb75b567c2dcc3"
    ["vendor/nim-stew"]="687d1b4ab1a91e6cc9c92e4fd4d98bec7874c259"
    ["vendor/nim-stint"]="1a2c661e3f50ff696b0b6692fab0d7bb2abf10cc"
    ["vendor/nim-taskpools"]="7b74a716a40249720fd7da428113147942b9642d"
    ["vendor/nim-testutils"]="14a56ae5aada81bed43e29d2368fc8ab8a449bf5"
    ["vendor/nim-toml-serialization"]="fea85b27f0badcf617033ca1bc05444b5fd8aa7a"
    ["vendor/nim-unicodedb"]="66f2458710dc641dd4640368f9483c8a0ec70561"
    ["vendor/nim-unittest2"]="88a613ffa4dbe452971beb937ea2db736dc9a9f4"
    ["vendor/nim-web3"]="94aac8a77cd265fe779ce8ed25a028340b925fd1"
    ["vendor/nim-websock"]="ebe308a79a7b440a11dfbe74f352be86a3883508"
    ["vendor/nim-zlib"]="3f7998095264d262a8d99e2be89045e6d9301537"
    ["vendor/nimbus-build-system"]="8fafcd0bac9f409091b7bcaee62ab6330f57441e"
    ["vendor/nimcrypto"]="dc07e3058c6904eef965394493b6ea99aa2adefc"
    ["vendor/nph"]="0d8000e741fa11ed48fdd116f24b4251b92aa9b5"
    ["vendor/waku-rlnv2-contract"]="a576a8949ca20e310f2fbb4ec0bd05a57ac3045f"
    ["vendor/zerokit"]="b9d27039c3266af108882d7a8bafc37400d29855"
)

# Initialize and update submodules
echo "Initializing and updating submodules..."
git submodule init
git submodule update

# Iterate through each submodule and checkout the desired commit
for submodule in "${!submodule_commits[@]}"; do
    commit="${submodule_commits[$submodule]}"
    echo "Checking out commit $commit in $submodule..."
    (
        cd "$submodule" || exit 1
        git fetch --all
        git checkout "$commit" || exit 1
    )
done

# Add the submodule changes to the main repository
echo "Staging submodule changes..."
git add .
git commit -m "Pinned submodules to desired commits"

echo "All submodules pinned successfully!"
