praggma solidity ^0.4.17;

import "./ReceiverInterface.sol";


contract UpgradeAgent {

    using SafeMath for uint;
    address public newTokenAddr;
    uint256 public totalUpgraded;

    event Upgrade(address indexed _from, address indexed newTokenAddr, uint256 _value);

    function isUpgradeAgent() public constant (bool) {
        return true;
    }

}
