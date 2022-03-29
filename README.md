
# ICO smart contract

ICO stands for a token or cryptocurrency initial offering crowdsale. It is a common method in blockchain space, decentralized applications and in-game tokens for bootstrap funding of your project.

This project aims to provide standard, secure smart contracts and tools to create crowdsales for Ethereum blockchain.


![Logo](https://www.researchgate.net/publication/338845616/figure/fig3/AS:941831072280579@1601561434403/The-ICO-process-and-generation-of-tokens.png)


## Problem Statement

Create an ICO Smart Contract, with your custom ERC20 Token with the below details: (No plagiarism allowed, can use OpenZeppelin)
- Total Supply of Token: 100 Million 
- Initial Value at $0.01 (Pre-sale Quantity: 30 Million)
- 2nd Sale Value at $0.02 (Seed Sale Quantity: 50 Million)
- Final Sale for Remaining Tokens should be dynamically allocated.
## Installation

Install ICO crowdsale-project with npm

```bash
  npm install Vimannyu/ICO-smart-contract
  cd ICO-project
```
    
## ICO smart contract function walkthrough

## Token creation

```http
   Token is created by the ERC20 standards.
```

| Method | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `ERC20` | `Token` | returns the address of the created token |

####  Parameter to generate Token

```http
  Name of the token
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Name`    | `string` | Defines the name of the token |


```http
  Symbol of the token
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Symbol`    | `string` | Defines the symbol of the token |


```http
  Total Supply
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Total Supply`    | `uint256` | Total number of tokens at initial stage |

## Crowdsale ICO

```http
   To distribute the tokens among the intresting buyers and raise funds of the organisation.
```

| Method | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `setStage` | `function` | This method set the stage for the corwdsale weather the sale is in presale phase or seedsale phase. |

```http
   
```

| Method | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `setFinalStage` | `function` | This method set the final stage for the remaining to get sold out . |

```http
  
```

| Method | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| ` fundTransfer`    | `function` | Transfers the collected funds to the wallet |

```http
  
```

| Method | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| ` endCrowdSale`    | `function` | Only owner can call this method what this method does is end the crowdsale and transfer the collected funds to wallet. |



## Tech Stack

- **Programming Languages:** Javascript and solidity.
- **Tools :** Hardhat , remix , chai , Metamask , ganache etc.



## Running Tests

To run tests, run the following command

```bash
  npx hardhat test
```


## Deployment

To deploy this project run

```bash
  npx hardhat run --network ropsten scripts/tokenDeploy.js
```


## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`ETHERSCAN_API_KEY`

`ROPSTEN_URL`

`PRIVATE_KEY`

