// SPDX-License-Identifier: AGPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title User Repository
 * @dev Universal build recipes publishing platform.
 */
contract UserRepository {

    address public immutable deployer = 0xea02F564664A477286B93712829180be4764fAe2;
    string public hijess = "urlife";
    string public version = "1.0";
    uint256 public baseRepositoryRevenue = 5;
    uint256 public mediumRepositoryRevenue = 10;
    uint256 public fullRepositoryRevenue = 20;
    uint256 public unit = 1000000000000000000;
    uint256 public baseRevenueThreshold = unit;
    uint256 public fullRevenueThreshold = 10 * unit;
    uint256 public scale = 1000000000;

    mapping(address => uint256) public packageNo; 
    mapping(address => mapping(uint256 => string)) public package;
    mapping(string => mapping(address => uint256)) public revNo; 
    mapping(string => mapping(address => uint256)) public revTarget; 
    mapping(string => mapping(address => mapping(uint256 => string))) public recipe; 
    mapping(string => mapping(address => mapping(uint256 => uint256))) public price; 
    mapping(string => mapping(address => mapping(uint256 => mapping(address => bool)))) public purchased; 
    constructor() {}

    /**
     * @dev Check owner.
     * @param _publisher Package recipe publisher.
     */
    function checkOwner(
      address _publisher)
      public
      view {
      require( msg.sender == _publisher, "not ur namespace" );
    }

    /**
     * @dev Check a recipe has been purchased.
     * @param _package Package(s group) built by the recipe.
     * @param _publisher Package recipe publisher.
     * @param _revision Recipe revision to check.
     */
    function checkPurchased(
      string memory _package,
      address _publisher,
      uint256 _revision)
      public
      view {
      require(
        purchased[_package][_publisher][_revision][msg.sender] == true, "sender has not purchased the recipe" );
    }

    /**
     * @dev Check an URI is an evmfs resource.
     * @param _uri The URI to check.
     */
    function checkUri(
      string memory _uri)
      internal
      pure {
      bytes memory _prefix = bytes(
        "evmfs://");
      bytes memory _uri_prefix = new bytes(
        8);
      for(
        uint i = 0;
        i <= 7;
        i++){
        _uri_prefix[i] = bytes(
	  _uri)[i];
      }
      require(
	_uri_prefix.length == _prefix.length &&
        keccak256(
          _uri_prefix) == keccak256(
            _prefix),
	"input is not an evmfs uri");
    }

    /**
     * @dev Publish a package recipe.
     * @param _package Package(s group) built by the recipe.
     * @param _publisher Package recipe publisher.
     * @param _price Recipe purchase price.
     * @param _recipe Recipe Ethereum Virtual Machine File System URI.
     */
    function publishRecipe(
      string memory _package,
      address _publisher,
      uint256 _price,
      string memory _recipe)
      public {
      checkOwner(
        _publisher);
      checkUri(
        _recipe);
      recipe[_package][_publisher][revNo[_package][_publisher]] = _recipe;
      price[_package][_publisher][revNo[_package][_publisher]] = _price;
      if ( revNo[_package][_publisher] == 0 ) {
        package[_publisher][packageNo[_publisher]] = _package;
        packageNo[_publisher] = packageNo[_publisher] + 1;  
      }
      revNo[_package][_publisher] = revNo[_package][_publisher] + 1;  
    }

    /**
     * @dev Set a recommended revision for a package recipe.
     * @param _package Package(s group) built by the recipe.
     * @param _publisher Package recipe publisher.
     * @param _rev Recipe revision to set as recommended.
     */
    function setRevTarget(
      string memory _package,
      address _publisher,
      uint256 _rev)
      public {
      checkOwner(
        _publisher);
      revTarget[_package][_publisher] = _rev;
    }

    /**
    * @dev Multiplies two numbers, throws on overflow.
     * @param a An integer.
     * @param b Another integer.
    */
    function mul(
      uint256 a,
      uint256 b)
      internal
      pure
      returns (uint256 c) {
      if (a == 0) {
        return 0;
      }
      c = a * b;
      assert(
        c / a == b );
      return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
     * @param a An integer.
     * @param b Another integer.
    */
    function div(
      uint256 a,
      uint256 b)
      internal
      pure
      returns (uint256) {
      // Solidity automatically throws when dividing by 0
      // assert(b > 0);
      // uint256 c = a / b;
      // There is no case in which this doesn't hold
      // assert(a == b * c + a % b);
      return a / b;
    }

     /**
     * @dev Returns publisher share for the set price of a recipe revision.
     * @param _amount A revision purchase price.
     */
    function getPublisherShare(
      uint256 _amount)
    public
    view
    returns (uint256)
    {
      uint256 repositoryRevenue;
      if ( _amount <= baseRevenueThreshold ) {
        repositoryRevenue = baseRepositoryRevenue;
      }
      else if ( baseRevenueThreshold < _amount && _amount <= fullRevenueThreshold * unit ) {
	repositoryRevenue = mediumRepositoryRevenue;
      }
      else if ( _amount > fullRevenueThreshold ) {
        repositoryRevenue = fullRepositoryRevenue;
      }
      uint256 publisherRevenue = 100 - repositoryRevenue;
      return div(
        div(
          mul(
            _amount,
	    scale),
	  publisherRevenue),
	scale);
    }

    /**
     * @dev Purchase a package recipe.
     * @param _package Package(s group) built by the recipe.
     * @param _publisher Package recipe publisher from which one is purchasing the recipe.
     * @param _revision Recipe revision to buy.
     * @param _receiver Address for which one is purchasing the revision.
     */
    function purchaseRecipe(
      string memory _package,
      address payable _publisher,
      uint256 _revision,
      address payable _receiver)
      public
      payable {
      if ( msg.sender != _publisher ) {
        require(
          msg.value >= price[_package][_publisher][_revision],
          "tried to purchase the recipe for less than its price");
	uint256 publisherShare = getPublisherShare(
          price[_package][_publisher][_revision]);
        payable(
          _publisher).transfer(
            publisherShare);
        payable(
	  deployer).transfer(
            msg.value - publisherShare);
      }
      purchased[_package][_publisher][_revision][_receiver] = true;
    }

    /**
     * @dev Read publisher recommended package recipe revision.
     * @param _publisher Recipe publisher.
     * @param _package Package(s group) built by the recipe.
     */
    function readRevTarget(
      address _publisher,
      string memory _package)
    public
    view
    returns (uint256)
    {
      return revTarget[_package][_publisher];
    }

    /**
     * @dev Read package recipe for a package.
     * @param _publisher Recipe publisher.
     * @param _package Package(s group) built by the recipe.
     * @param _revision Recipe revision.
     */
    function readRecipe(
      string memory _package,
      address _publisher,
      uint256 _revision)
    public
    view
    returns (string memory)
    {
      checkPurchased(
        _package,
        _publisher,
        _revision
      );
      return recipe[_package][_publisher][_revision];
    }
}
