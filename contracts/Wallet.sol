// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Router {
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        )
    {}
}

contract MasterChefV2 {
    function poolLength() external view returns (uint256) {}

    function deposit(uint256 pid, uint256 amount) public {}
}

contract Wallet {
    ERC20 SushiToken = ERC20(0x80C7DD17B01855a6D2347444a0FCC36136a314de);
    ERC20 LPtoken = ERC20(0x594752832B5E84bD3134254f0313c4e61816cB2c);
    Router router = Router(0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506);
    MasterChefV2 masterChef =
        MasterChefV2(0x80C7DD17B01855a6D2347444a0FCC36136a314de);

    function mainFunction(
        address _tokenA,
        address _tokenB,
        uint256 _amountADesired,
        uint256 _amountBDesired,
        uint256 _amountAMin,
        uint256 _amountBMin
    ) public {
        ERC20 tokenA = ERC20(_tokenA);
        ERC20 tokenB = ERC20(_tokenB);

        //-------------1. Approve the SushiSwap router to use your tokens

        tokenA.transferFrom(msg.sender, address(this), _amountADesired); //Carga el contrato con el par
        tokenB.transferFrom(msg.sender, address(this), _amountBDesired);

        tokenA.approve(address(router), _amountADesired); //Aprueba al router
        tokenB.approve(address(router), _amountBDesired);

        /*-------------2. Provide liquidity on SushiSwap by entering a pool using that
        is incentivized by Sushi (https://app.sushi.com/pool)---------*/

        router.addLiquidity(
            _tokenA,
            _tokenB,
            _amountADesired,
            _amountBDesired,
            _amountAMin,
            _amountBMin,
            address(this),
            block.timestamp
        );

        uint256 LPamount = LPtoken.balanceOf(address(this));

        //-------------3. Approve the MasterChef smart contract to use your tokens

        LPtoken.approve(address(masterChef), LPamount);

        /*-------------4. Deposit the liquidity token (SLP) you received after supplying liquidity into a yield farm
      managed by MasterChef smart contract (https://app.sushi.com/yield), and earn SUSHI.--------*/

        uint256 poolIndex = masterChef.poolLength() - 1;

        masterChef.deposit(poolIndex, LPamount);    //Esto deberia depositar los SLP y entregarme SUSHI
    }

    function sushiTokenBalance() public view returns (uint256 sushiAmount) {
        sushiAmount = SushiToken.balanceOf(address(this));
    }

    function withdraw(address _to, uint256 _amount) public payable {
        LPtoken.transferFrom(address(this), _to, _amount);
    }
}
