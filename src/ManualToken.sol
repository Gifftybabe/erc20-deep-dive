// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;



contract ManualToken {

    error ManualToken__InsufficientBalance();
    error ManualToken__TransferFailed();
    error ManualToken__InsufficientAllowance();

    mapping (address => uint) private s_addressToBalance;
    mapping(address => mapping(address => uint256)) private s_ownerToSpenderToAmount;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);



    function name() public pure returns (string memory) {
        return "GifftyToken";
    }

    function symbol() public pure returns (string memory) {
        return "GIF";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256){
        return 100 ether;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_addressToBalance[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        if(balanceOf(msg.sender) < _value) {
            revert ManualToken__InsufficientBalance();
        }

       uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_addressToBalance[msg.sender] -= _value;
        s_addressToBalance[_to] += _value;
        if(balanceOf(msg.sender) + balanceOf(_to) != previousBalance) {
           revert ManualToken__TransferFailed(); 
        }

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        s_ownerToSpenderToAmount[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        if(balanceOf(_from) < _value) {
            revert ManualToken__InsufficientBalance();
        }

        if(s_ownerToSpenderToAmount[_from][msg.sender] < _value) {
            revert ManualToken__InsufficientAllowance();
        }

         uint256 previousBalance = balanceOf(_from) + balanceOf(_to);

        s_addressToBalance[_from] -= _value;
        s_addressToBalance[_to] += _value;
        s_ownerToSpenderToAmount[_from][msg.sender] -= _value;

        if(balanceOf(_from) + balanceOf(_to) != previousBalance) {
           revert ManualToken__TransferFailed(); 
        }

        return true;
    }


}