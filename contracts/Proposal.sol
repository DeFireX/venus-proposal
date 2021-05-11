/**
 *Submitted for verification at BscScan.com on 2021-05-11
*/

pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract VBep20Delegate {
    function _setImplementation(address implementation_, bool allowResign, bytes memory becomeImplementationData) public;
}

contract GovernorAlpha {
    function propose(address[] memory targets, uint[] memory values, string[] memory signatures, bytes[] memory calldatas, string memory description) public returns (uint);
    function castVote(uint proposalId, bool support) public;
}

// Proposal to return locked funds
contract Proposal {
    GovernorAlpha public constant governorAlpha = GovernorAlpha(0x406f48f47D25E9caa29f17e7Cfbd1dc6878F078f);

    uint256 public proposeId;
    // new implementation of vToken with new function releaseStuckTokens
    address public constant newImplementation = 0x1115851EE76B5F1C1EA78D20e6bEB9A9f83B11Af;

    //                              vBUSD                                   vUSDT
    address[] public targets = [0x95c78222B3D6e262426483D42CfA53685A67Ab9D, 0xfD5840Cd36d94D7229439859C0112a4185BC0255];
    uint[] public values = [0, 0];
    string[] public signatures = ["_setImplementation(address,bool,bytes)", "_setImplementation(address,bool,bytes)"];

    string public description;
    address public descriptionOwner = msg.sender;

    function propose() public {
        require(proposeId == 0, "proposal already submitted");

        bytes[] memory calldatas = new bytes[](2);
        calldatas[0] = abi.encode(newImplementation, true, bytes(""));
        calldatas[1] = abi.encode(newImplementation, true, bytes(""));

        proposeId = governorAlpha.propose(targets, values, signatures, calldatas, description);
    }

    function castVote() public {
        require(proposeId != 0, "proposal isn't submitted");
        governorAlpha.castVote(proposeId, true);
    }

    function changeDescription(string memory _newDescription) public {
        require(msg.sender == descriptionOwner);
        require(proposeId == 0, "proposal already submitted");

        description = _newDescription;
    }

    function finalizeDescription() public {
        require(msg.sender == descriptionOwner);
        require(proposeId == 0, "proposal already submitted");
        require(bytes(description).length > 0, "finalize only when non-empty description");

        descriptionOwner = address(0);
    }
}
