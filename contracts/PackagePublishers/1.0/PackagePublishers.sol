// SPDX-License-Identifier: AGPL-3.0

//    ----------------------------------------------------------------------
//    Copyright © 2025  Pellegrino Prevete
//
//    All rights reserved
//    ----------------------------------------------------------------------
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU Affero General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU Affero General Public License for more details.
//
//    You should have received a copy of the GNU Affero General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.


pragma solidity >=0.7.0 <0.9.0;

interface UserRepositoryPublishersInterface { 
  function listed(
    address _publisher)
    external
    view
    returns(uint256);
}

interface UserRepositoryInterface { 
  function revNo(
    string memory _package,
    address _publisher)
    external
    view
    returns(uint256);
}


/**
 * @title Package Publishers
 * @dev Publishers for a given package.
 */
contract PackagePublishers {

    address public immutable deployer = 0xea02F564664A477286B93712829180be4764fAe2;
    string public hijess = "urthedawninadaywithoutend";
    string public version = "1.0";

    mapping(
      address => mapping(
        address => mapping(
          string => uint256))) public packagePublisherNo; 
    mapping(
      address => mapping(
        address => mapping(
          string => mapping(
            uint256 => address)))) packagePublisher;

    constructor() {}

    /**
     * @dev Checks a publisher has registered to the User Repository.
     * @param _publishers User Repository Publishers contract.
     * @param _publisher Publisher address.
     */
    function checkListed(
      address _publishers,
      address _publisher)
      public
      view {
      UserRepositoryPublishersInterface _userRepositoryPublishers =
        UserRepositoryPublishersInterface(
          _publishers);
      require(
        _userRepositoryPublishers.listed(
          _publisher) > 0, 
          "Publisher not listed on the user repository."
      );
    }

    /**
     * @dev Checks a publisher has published a package.
     * @param _repository User Repository contract.
     * @param _publishers User Repository Publishers contract.
     * @param _publisher Publisher address.
     * @param _package Package(s group) to check.
     */
    function checkPublished(
      address _repository,
      address _publishers,
      address _publisher,
      string memory _package)
      public
      view {
      checkListed(
        _publishers,
        _publisher);
      UserRepositoryInterface _userRepository =
        UserRepositoryInterface(
          _repository);
      require(
        _userRepository.revNo(
          _package,
          _publisher) > 0, 
          "Publisher has not published a recipe for the package."
      );
    }

    /**
     * @dev List a publisher for a package recipe.
     * @param _repository User Repository contract.
     * @param _publishers User Repository Publishers contract.
     * @param _package Package(s group).
     * @param _publisher Publisher address.
     */
    function listPublisher(
      address _repository,
      address _publishers,
      string memory _package,
      address _publisher)
      public {
      checkPublished(
        _repository,
        _publishers,
        _publisher,
        _package);
      packagePublisher[
        _repository][
          _publishers][
            _package][
              packagePublisherNo[
                _repository][
                  _publishers][
                    _package]] =
        _publisher;
      packagePublisherNo[
        _repository][
          _publishers][
            _package] =
        packagePublisherNo[
          _repository][_publishers][_package] + 1;  
    }

}
