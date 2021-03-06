pragma solidity ^0.4.16;


contract ReceiverInterface {

    function upgradeFrom(address _owner, uint256 _value) public returns (bool);
    function isUpgradeAgent() public pure returns (bool);
}
