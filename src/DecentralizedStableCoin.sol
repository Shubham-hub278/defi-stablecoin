// SPDX-License-Identifier: MIT

// This is considered an Exogenous, Decentralized, Anchored (pegged), Crypto Collateralized low volitility coin

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

prgama solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
 * @title DecentralizedStableCoin
 * Collateral: Exogenous
 * Minting (Stability Mechanism): Decentralized (Algorithmic)
 * Value (Relative Stability): Anchored (Pegged to USD)
 * Collateral Type: Crypto
 *
 * This is the contract meant to be owned by DSCEngine. It is a ERC20 token that can be minted and burned by the DSCEngine smart contract.
 */
contract DecentralizedStableCoin is ERC20Burnable {

    error TestStableCoin__AmountMustBeMoreThanZero();
    error TestStableCoin__BurnAmountExceedsBalance();
    error TestStableCoin__NotZeroAddress();

    constructor() ERC20("TestStableCoin", "TSC"){

    }

    function burn(uint256 value) public override onlyOwner{

        uint256 balance = balanceOf(msg.sender);

        if(value <=0 ){
            revert TestStableCoin__AmountMustBeMoreThanZero();
        }
        if (balance < value) {
            revert TestStableCoin__BurnAmountExceedsBalance();
        }
        super.burn(value);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert TestStableCoin__NotZeroAddress();
        }
        if (_amount <= 0) {
            revert TestStableCoin__AmountMustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }


}