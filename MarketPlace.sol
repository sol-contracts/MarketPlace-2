pragma solidity 0.5.11;

contract MarketPlace {

    mapping (address => uint256) public reputations; // Adresse = utilisateur et uint256 = chiffre de la réputation
    mapping (address => string) public usernames; // Adresse = utilisateur et string = nom
    mapping (address => bool) public blacklist;
    address owner;

constructor() public{
    owner = msg.sender;
}
    // Réputation minimale de 1
    modifier minReputation{
        require(reputations[msg.sender] >= 1);
        _;
    }
    // Fonction d'inscription avec vérification de blacklist
    function inscription(string memory _username) public {
        require(blacklist[msg.sender] == false, "Adresse bannie.");
        reputations[msg.sender] = 1; //reputation à 1; 
        usernames[msg.sender] = _username ;
    }
    // Fonction pour Owner de blacklistage
    function updateBlacklist(address _user, bool _state) public {
        require(msg.sender == owner, "Fonction accessible uniquement à l'owner.");
        blacklist[_user] = _state;
        if (_state == true){
            reputations[_user] = 0;
        } else {
            reputations[_user] = 1;
        }
    }
}
