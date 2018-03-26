pragma solidity ^0.4.16;

import "./OldToken.sol";
import "./ReceiverInterface.sol";


contract UIP1Token is ReceiverInterface, OldToken {

    address public oldTokenAddr;

    function UIP1Token (address _oldTokenAddr) public {
        oldTokenAddr = _oldTokenAddr;
    }

    function isUpgradeAgent() public pure returns (bool) {
        return true;
    }

    /**
    * Allow the new token contract to update the token balances.
    */
    function upgradeFrom(address _from, uint256 value) public returns (bool) {
        // Make sure the call is from old token contract
        require(msg.sender == oldTokenAddr);
        // Validate input value.
        balances[_from] = balances[_from].add(value);
        // Take tokens out from circulation
        totalSupply_ = totalSupply_.add(value);
        return true;
    }


}
