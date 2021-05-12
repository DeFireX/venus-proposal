# venus-proposal

#Tests

1. Test create and vote for proposal

    1.1. Run BSC node fork
    
    ```
    ganache-cli -f https://long-blue-breeze.bsc.quiknode.pro -d -i 56 --unlock 0x60277AdD339d936C4Ab907376afEE4f7aC17D760
    ```
    
    1.2. Run
    ```
    node ./tests/test_create_proposal.js
    ```

2. Test releaseStuckTokens

    2.1. Run BSC node fork
    
    ```
    ganache-cli -f https://long-blue-breeze.bsc.quiknode.pro -d -i 56 --unlock 0x939bd8d64c0a9583a7dcea9933f7b21697ab6396 0x60277AdD339d936C4Ab907376afEE4f7aC17D760 0xdAE0aca4B9B38199408ffaB32562Bf7B3B0495fE
    ```
    
    2.2. Run
    ```
    node ./tests/test_release_funds.js
    ```
