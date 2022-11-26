// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract Thf_A_ERC20 is ERC20, IExerciceSolution {

    string private _name;
    string private _symbol;
    //MAPPING
    mapping(address=>bool) public admins;
    mapping(address=>bool) public hasMint;
    mapping(address=>bool) public addressWL;
    mapping(address=>uint256) public addressTier;
    address public owner;


    constructor(uint256 initialSupply) public ERC20("MaxToken", "Thf_A") {
        _mint(msg.sender, initialSupply-500000000);
        _mint(address(this), initialSupply);
        admins[msg.sender]=true;
        owner=msg.sender;
        _name="MaxToken";
        _symbol="Thf_A";
        addressWL[address(0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5)]=true;
        addressTier[address(0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5)]=2;
        // addressWL[msg.sender]=true;
    }

    modifier onlyAdmins() {
        require(admins[msg.sender]);
        _;
    }

    modifier HasMinted() {
        require(!hasMint[msg.sender]);
        _;
    }

    modifier OnlyWL(){
        require(addressWL[msg.sender]);
        _;
    }

    function AddAdmin(address _admin) public onlyAdmins {
        admins[_admin]=true;
    }

    function symbol() public override(IExerciceSolution,ERC20) view returns (string memory){
        return _symbol;
    }
        
    function getToken() external override returns (bool){
        require(addressWL[msg.sender],"Sender not WL");
        _transfer(address(this), msg.sender, 200);
        return true;
    }

    function buyToken() external payable override returns (bool){
        require(addressTier[msg.sender]!=0,"Caller is not register");
        if(addressTier[msg.sender]==1){
            _transfer(address(this),msg.sender,msg.value*10);
        }
        else{
            _transfer(address(this),msg.sender,msg.value*20);
        }
        return true;
    }

    function isCustomerWhiteListed(address customerAddress) external override returns (bool){
        return addressWL[customerAddress];
    }

    function customerTierLevel(address customerAddress) external override returns (uint256){
        return addressTier[customerAddress];
    }

    
}