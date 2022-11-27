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
    function deposit(
        uint256 pid,
        uint256 amount,
        address to
    ) public {}
}

contract Wallet {

    ERC20 SushiToken = ERC20(0x6B3595068778DD592e39A122f4f5a5cF09C90fE2);
    ERC20 LPtoken = ERC20(0xC3f279090a47e80990Fe3a9c30d24Cb117EF91a8);

    function ratherFunction(
        address _tokenA,
        address _tokenB,
        uint256 _amountADesired,
        uint256 _amountBDesired,
        uint256 _amountAMin,
        uint256 _amountBMin
    ) public returns (string memory) {
        Router router = Router(0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff);
        MasterChefV2 masterChef = MasterChefV2(
            0xEF0881eC094552b2e128Cf945EF17a6752B4Ec5d
        );

        ERC20 tokenA = ERC20(_tokenA); //DAI
        ERC20 tokenB = ERC20(_tokenB); //USDC

        //-------------1. Approve the SushiSwap router to use your tokens

        tokenA.transferFrom(msg.sender, address(this), _amountADesired); //Ingresa dos coin
        tokenB.transferFrom(msg.sender, address(this), _amountBDesired);

        tokenA.approve(address(router), _amountADesired); //Aprueba al router
        tokenB.approve(address(router), _amountBDesired);

        /*-------------2. Provide liquidity on SushiSwap by entering a pool using that
        is incentivized by Sushi (https://app.sushi.com/pool)*/

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
      managed by MasterChef smart contract (https://app.sushi.com/yield), and earn SUSHI.*/

        masterChef.deposit(123, LPamount, address(this));   //Que es el pid???
        
        return "Done!";
    }

    function sushiTokenBalance () public view returns (uint sushiAmount) {
        sushiAmount = SushiToken.balanceOf(address(this));
    }

    function withdraw (address _to, uint _amount) public payable {
        SushiToken.transferFrom(address(this), _to, _amount);
    }

}