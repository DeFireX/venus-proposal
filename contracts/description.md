#Short issue explanation
DefireX provide a yield farming strategies. Some of them uses Venus.
Due to error on upgrading DefireX smart-contracts it lost control over 16M user funds. All the funds got locked in v-tokens.

In vUSDT https://bscscan.com/address/0x22b433402b65dccbe79fe66b4990a2569ab01572

And in vBUSD

https://bscscan.com/address/0x3b1a4f61bd3d7301edbd3ea2a5e05ede8dda812d

#Suggested solution
vBUSD and vUSDT contracts should be upgraded to new implementation that have a function to return frozen funds to contract owner.
We prepared such implementation, it's include just one new function releaseStuckTokens pretty simple and easy to understand.

You can check it here https://github.com/DeFireX/venus-protocol/commit/1e137493223edb9896ac855670ba177e7e564a7f
Deployed implementation https://bscscan.com/address/0x3b7F27b05B11ce6c8bC7863BbebF89f49c7f9970#code

- we didn't create new complicated functions - just use existing.
- we didn't create new storage variables.
- we didn't change any of existing code.
- we made a function that can't be used in any other way but returning frozen funds.

#Full issue explanation
We have 2 upgradable strategy contracts:
USDT Main strategy
0xb7552a0463515bda8b47ab7503ca893e52c58df8
BUSD Main strategy
0x987f04dece1c5ae9e69cf4f93d00bbe2ca5af98c

We upgraded contracts to temporary implementation that can't withdraw funds from wallet, it just
unwind/repay all current positions (function unwindAllPositions) and collect all the funds
at DfProxyWallet contract (controlled by strategy, but can't directly withdraw funds):
USDT DfProxyWallet 
0x22b433402b65dccbe79fe66b4990a2569ab01572
BUSD DfProxyWallet 
0x3b1a4f61bd3d7301edbd3ea2a5e05ede8dda812d

Next step should be upgrade the implementation and process the migration funds to new contract,
but instead of calling "upgrade(proxy, implementation)" was called "changeProxyAdmin(proxy, newAdmin)" function that has the same 
signature. 

changeAdmin trx
https://bscscan.com/tx/0xa295adf5250f650ed106f31c6f12fc6ff774b896f8783f97d275720810562069#eventlog

https://bscscan.com/tx/0x24c0aad2931a203f933aceeb52344196f6ea6de55e2be7f8261f85a0a290c69a#eventlog

So new admin become a contract should be implementation for strategy. It hasn't "changeAdmin" and "upgrade" functions.
After that, we completely lost control over the funds.
All contracts has been verified at BSCScan.

