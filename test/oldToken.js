const OldToken = artifacts.require('./OldToken.sol');
const UIP1Token = artifacts.require('./UIP1Token.sol');
const assertJump = require('./helpers/assertJump');

contract('OldToken', (accounts) => {
  let token;

  beforeEach(async () => {
    token = await OldToken.new();
    await token.mint(accounts[0], 1000);
    await token.mint(accounts[1], 1000);
  });

  it('should allow to set new token contract', async () => {

    const INVESTOR = accounts[0];
    const newToken = await UIP1Token.new(token.address);

    await token.setUpgradeAgent(newToken.address);
    assert.equal(await token.newTokenAddr.call(), newToken.address, 'upgradeAgent Not Set');
    assert.equal(await token.getUpgradeState.call(), 1, 'upgrade state not displayed properly');    
  });

  it('should not allow to set non upgrade agent token contract', async () => {

    const INVESTOR = accounts[0];
    const newToken = await OldToken.new();
    
    try {
      await token.setUpgradeAgent(newToken.address);     
      assert.fail('should have failed before');
    } catch (error) {
      assertJump(error);
    }
  });

  it('should display upgrade state as waiting before setting new contract', async () => {

    const INVESTOR = accounts[0];
    const newToken = await UIP1Token.new(token.address);

    assert.equal(await token.getUpgradeState.call(), 0, 'upgrade state not displayed properly');
  });

})