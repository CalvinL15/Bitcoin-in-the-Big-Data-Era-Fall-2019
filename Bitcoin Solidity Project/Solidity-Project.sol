pragma solidity ^0.4.24;

//Name: Calvin Liu
//Student ID: B06902100


//Safe maths
contract SafeCalculation { 
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

//ERC20 Protocols
contract ERC20Protocol{
	function totalSupply() public constant returns (uint);
	function balanceOf(address tokenOwner) public constant returns (uint balance);
	function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
	function transfer(address to, uint tokens) public returns (bool success);
	function approve(address spender, uint tokens) public returns (bool success);
	function transferFrom(address from, address to, uint tokens) public returns (bool success);

	event Transfer(address indexed from, address indexed to, uint tokens);
	event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// The Owned contract ensures that only the creator (deployer) of a contract can perform certain tasks.
contract Owned {
	address public owner = msg.sender;
	address public newOwner;
	event OwnershipChanged(address indexed old, address indexed current);
	modifier only_owner { require(msg.sender == owner); _; }
	function transferOwnership(address _newOwner) public only_owner{
		newOwner = _newOwner;
	}
	function acceptOwnership() public {
        require(msg.sender == newOwner);
        emit OwnershipChanged(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

//B06902100_Token
contract B06902100_Token is ERC20Protocol, Owned, SafeCalculation{
	string public name;
	string public symbol;
	uint8 public decimals;
	uint public _totalSupply;
	mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    //constructor
    constructor() public{
    	name = "B06902100";
    	symbol = "B06902100_coin";
    	decimals = 18;
    	_totalSupply = 100000000000000000000;
    	balances[0x2a9d7FE4A6e3811df202E7BC98a7ac4d50262f2E] = _totalSupply;
    	emit Transfer(address(0), 0x2a9d7FE4A6e3811df202E7BC98a7ac4d50262f2E, _totalSupply);
    }

    //ERC20 Protocols
    function totalSupply() public constant returns (uint) {
        return _totalSupply  - balances[address(0)];
    }

     function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

     function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }  

     function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
}


