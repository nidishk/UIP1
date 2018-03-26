praggma solidity ^0.4.17;

import "./OldToken.sol";
import "./ReceiverInterface.sol";


contract UIP1Token is ReceiverInterface, OldToken {

    function isUpgradeAgent() public constant returns (bool) {
        return true;
    }

    /**
    * Allow the new token contract to update the token balances.
    */
    function upgradeFrom(address _from, uint256 value) public {
        // Make sure the call is from old token contract
        require(msg.sender == oldTokenAddr);
        // Validate input value.
        balances[_from] = balances[_from].add(value);
        // Take tokens out from circulation
        totalSupply = totalSupply.add(value);
    }
}
