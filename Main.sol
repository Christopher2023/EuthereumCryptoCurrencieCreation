// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract NealSary {
    string public name = "NealSary";
    string public symbol = "NSY";
    string public standard = "NealSary v1.0";
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping(address => uint256)) public allowance;

    address owner;

    constructor(){
        owner = msg.sender;
    }

    function MytokenAdmin(uint256 _initialSupply) public onlyAdmin {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply += _initialSupply;
    }
    modifier onlyAdmin{
        require (msg.sender == owner, "Only Owner allowed");
        _;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require (_value <= balanceOf[msg.sender]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender,_to,_value);
        
        return true;
    }

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    function approve (address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval (msg.sender,_spender,_value);

        return true;
    }

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require (_value <= balanceOf[_from]);
        require (_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        allowance[_from][msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}
