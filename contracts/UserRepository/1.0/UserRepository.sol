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
    string public baseRepositoryRevenue = 5;
    string public mediumRepositoryRevenue = 10;
    string public fullRepositoryRevenue = 20;

    mapping(address => uint256) public packageNo; 
    mapping(address => mapping(uint256 => string)) public package;
    mapping(string => mapping(address => uint256)) public revNo; 
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
        purchased[_package][_publisher][_revision][msg.sender] == true, "recipe not purchased" );
    }

    /**
     * @dev Publish a package recipe.
     * @param _package Package(s group) built by the recipe.
     * @param _publisher Package recipe publisher.
     * @param _price Recipe purchase price.
     * @param _message Recipe URI.
     */
    function publishRecipe(
      string memory _package,
      address _publisher,
      uint256 _price,
      string memory _recipe) public {
      checkOwner(
        _publisher);
      recipe[_package][_publisher][revNo[_package][_publisher]] = _recipe;
      price[_package][_publisher][revNo[_package][_publisher]] = _price;
      if ( revNo[_package][_publisher] == 0 ) {
        package[packageNo[_publisher]] = _package;
        packageNo[_publisher] = packageNo[_publisher] + 1;  
      }
      revNo[_package][_publisher] = revNo[_publisher][_package] + 1;  
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
      address payable _receiver) public {
      require(
        msg.value >= price[_package][_publisher][_revision],
	"tried to purchase the recipe for less than its price");
      if ( msg.sender != _publisher ) {
        payable(_publisher).transfer(
          msg.value);
      }
      purchased[_package][_publisher][_revision][_receiver] = true;
    }

    /**
     * @dev Read package recipe for a package.
     * @param _publisher Recipe publisher.
     * @param _package Package(s group) built by the recipe.
     * @param _revision Recipe revision.
     */
    function readRecipe(
      address _publisher,
      string memory _package,
      uint256 _revision)
    public
    view
    returns (string memory)
    {
      checkPurchased(
        _package,
	_publisher,
	_revision,
	msg.sender
      );
      return recipe[_package][_publisher][_revision];
    }
}
