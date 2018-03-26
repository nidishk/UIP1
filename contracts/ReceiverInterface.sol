praggma solidity ^0.4.17;

contract ReceiverInterface {

    function upgradeFrom(address _owner, uint256 _value) public;
    function isUpgradeAgent() public constant (bool);
}
