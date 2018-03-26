const OldToken = artifacts.require('./OldToken.sol');
const UIP1Token = artifacts.require('./UIP1Token.sol');
const assertJump = require('./helpers/assertJump');

contract('UIP1', (accounts) => {
  let token;

  beforeEach(async () => {
    token = await OldToken.new();
    await token.mint(accounts[0], 1000);
    await token.mint(accounts[1], 1000);
  });

  
  it('should allow to upgrade to new contract after upgrade agent set', async () => {

    const INVESTOR = accounts[0];
    const newToken = await UIP1Token.new(token.address);

    await token.setUpgradeAgent(newToken.address);

    await token.upgrade(1000);

    assert.equal((await token.getUpgradeState.call()).toNumber(), 2, 'upgrade state not displayed properly');    
    assert.equal((await token.balanceOf.call(accounts[0])).toNumber(), 0, 'balance in old contract unchanged');    
    assert.equal((await newToken.balanceOf.call(accounts[0])).toNumber(), 1000, 'balance in new contract unchanged');    
    assert.equal((await token.totalSupply.call()).toNumber(), 1000, 'totalSupply in old contract unchanged');    
    assert.equal((await token.totalUpgraded.call()).toNumber(), 1000, 'totalUpgraded in old contract unchanged');        
    assert.equal((await newToken.totalSupply.call()).toNumber(), 1000, 'totalSupply in new contract unchanged');    
  });

  it('should allow to upgrade to new contract after upgrade agent set', async () => {

    const INVESTOR = accounts[0];
    const newToken = await UIP1Token.new(token.address);

    await token.setUpgradeAgent(newToken.address);

    await token.upgrade(1000);
    await token.upgrade(1000, {from: accounts[1]});
    
    assert.equal((await token.getUpgradeState.call()).toNumber(), 3, 'upgrade state not displayed properly');    
    assert.equal((await token.balanceOf.call(accounts[0])).toNumber(), 0, 'balance in old contract unchanged');    
    assert.equal((await newToken.balanceOf.call(accounts[0])).toNumber(), 1000, 'balance in new contract unchanged');    
    assert.equal((await token.balanceOf.call(accounts[1])).toNumber(), 0, 'balance in old contract unchanged');    
    assert.equal((await newToken.balanceOf.call(accounts[1])).toNumber(), 1000, 'balance in new contract unchanged');  
    assert.equal((await token.totalSupply.call()).toNumber(), 0, 'totalSupply in old contract unchanged');    
    assert.equal((await token.totalUpgraded.call()).toNumber(), 2000, 'totalUpgraded in old contract unchanged');        
    assert.equal((await newToken.totalSupply.call()).toNumber(), 2000, 'totalSupply in new contract unchanged');    
  });
})