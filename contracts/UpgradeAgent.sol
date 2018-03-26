pragma solidity ^0.4.16;

import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract UpgradeAgent is ERC20 {

    address public newTokenAddr;
    uint256 public totalUpgraded;

    event Upgrade(address indexed _from, address indexed newTokenAddr, uint256 _value);
    enum UpgradeState { Waiting, Ready, Upgrading, Complete }

    function getUpgradeState() public constant returns (UpgradeState) {
        
        if (newTokenAddr == 0x00) {
            return UpgradeState.Waiting;
        } else if (totalUpgraded == 0) {
            return UpgradeState.Ready;
        } else if (totalUpgraded == ERC20(newTokenAddr).totalSupply() && totalSupply() == 0) {
            return UpgradeState.Complete;
        } else {
            return UpgradeState.Upgrading;
        }
    }

}
