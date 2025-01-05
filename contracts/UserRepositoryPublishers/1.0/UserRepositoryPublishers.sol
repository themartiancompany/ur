// SPDX-License-Identifier: AGPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title User Repository Publishers
 * @dev User Repository Publishers.
 */
contract UserRepositoryPublishers {

    address public immutable deployer = 0xea02F564664A477286B93712829180be4764fAe2;
    // dvorak is trustedEnroller
    address public immutable trustedEnroller = 0x87003Bd6C074C713783df04f36517451fF34CBEf;
   
    string public hijess = "lovewilltriumph";
    string public version = "1.0";
    uint256 public unit = 1000000000000000000;
    uint256 public enrollingFee = 10 * unit;

    uint256 public publisherNo = 1; 
    mapping(uint256 => address) public publisher;
    mapping(uint256 => address) public enroller;
    mapping(address => uint256) public listed;
    constructor() {}

    /**
     * @dev List a publisher.
     * @param _publisher User Repository Publisher sender is listing.
     */
    function listPublisher(
      address _publisher)
      public
      payable {
      if ( msg.sender != trustedEnroller ) {
        require(
          listed[_publisher] == 0,
          "the publisher has already been listed");
        require(
          msg.value >= enrollingFee,
          "tried to list the publisher for less than the enrolling fee.");
        payable(
	  deployer).transfer(
            msg.value);
      }
      listed[_publisher] = publisherNo;
      publisher[publisherNo] = _publisher;
      enroller[publisherNo] = msg.sender;
      publisherNo = publisherNo + 1;
    }

    /**
     * @dev Read User Repository publisher ID.
     * @param _publisher User Repository publisher.
     */
    function readPublisherNo(
      address _publisher)
    public
    view
    returns (uint256)
    {
      return listed[_publisher];
    }

    /**
     * @dev Read User Repository publisher enroller.
     * @param _publisherNo User Repository publisher ID.
     */
    function readEnrollerNo(
      uint256 _publisherNo)
    public
    view
    returns (address)
    {
      return enroller[_publisherNo];
    }

    /**
     * @dev Read User Repository publisher enroller.
     * @param _publisher User Repository publisher.
     */
    function readEnroller(
      address _publisher)
    public
    view
    returns (address)
    {
      return enroller[listed[_publisher]];
    }

}
