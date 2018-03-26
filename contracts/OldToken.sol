praggma solidity ^0.4.17;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";


contract OldToken is Ownable, UpgradeAgent, MintableToken {

    function setUpgradeAgent(address _newTokenAddr) public onlyOwner {
        require(ReceiverInterface(_newTokenAddr).isUpgradeAgent());
        newTokenAddr = _newTokenAddr;
    }

    /**
    * Allow the token holder to upgrade some of their tokens to a new contract.
    */
    function upgrade(uint256 value) public {
      // Validate input value.
        require(value != 0);
        require(newTokenAddr != address(0));
        balances[msg.sender] = balances[msg.sender].sub(value);
        // Take tokens out from circulation
        totalSupply = totalSupply.sub(value);
        totalUpgraded = totalUpgraded.add(value);
        // Upgrade agent reissues the tokens
        ReceiverInterface(newTokenAddr).upgradeFrom(msg.sender, value);
        Upgrade(msg.sender, newTokenAddr, value);
    }

}
