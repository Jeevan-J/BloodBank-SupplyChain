// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import "./Structure.sol";

contract BloodBankSupplyChain {
    event CollectionCentreAdded(address indexed _account);
    
    //Blood Sample code
    uint256 public uid;
    uint256 sku;

    address owner;

    mapping(uint256 => Structure.Sample) samples;
    mapping(uint256 => Structure.SampleHistory) sampleHistory;
    mapping(address => Structure.Roles) roles;

    function hasCollectionCentreRole(address _account) public view returns (bool) {
        require(_account != address(0));
        return roles[_account].collectionCentre;
    }

    function addCollectionCentreRole(address _account) public {
        require(_account != address(0));
        require(!hasCollectionCentreRole(_account));

        roles[_account].collectionCentre = true;
    }

    function hasTestingCentreRole(address _account) public view returns (bool) {
        require(_account != address(0));
        return roles[_account].testingCentre;
    }

    function addTestingCentreRole(address _account) public {
        require(_account != address(0));
        require(!hasTestingCentreRole(_account));

        roles[_account].testingCentre = true;
    }

    function hasBloodBankRole(address _account) public view returns (bool) {
        require(_account != address(0));
        return roles[_account].bloodBank;
    }

    function addBloodBankRole(address _account) public {
        require(_account != address(0));
        require(!hasBloodBankRole(_account));

        roles[_account].bloodBank = true;
    }
    
    function hasHospitalRole(address _account) public view returns (bool) {
        require(_account != address(0));
        return roles[_account].hospital;
    }

    function addHospitalRole(address _account) public {
        require(_account != address(0));
        require(!hasHospitalRole(_account));

        roles[_account].hospital = true;
    }

    function hasDonorRole(address _account) public view returns (bool) {
        require(_account != address(0));
        return roles[_account].donor;
    }

    function addDonorRole(address _account) public {
        require(_account != address(0));
        require(!hasDonorRole(_account));

        roles[_account].donor = true;
    }

    constructor() public payable {
        owner = msg.sender;
        sku = 1;
        uid = 1;
    }

    event SampleCollected(uint256 uid);
    event SentToTestingCentre(uint256 uid);
    event RecievedByTestingCentre(uint256 uid);
    event AcceptedByTestingCentre(uint256 uid);
    event RejectedByTestingCentre(uint256 uid);
    event SentToBloodBank(uint256 uid);
    event RecievedByBloodBank(uint256 uid);
    event RequestedByHospital(uint256 uid);
    event SentToHospital(uint256 uid);
    event RecievedByHospital(uint256 uid);

    modifier verifyAddress(address add) {
        require(msg.sender == add);
        _;
    }

    modifier sampleCollected(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.SampleCollected);
        _;
    }

    modifier sentToTestingCentre(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.SentToTestingCentre);
        _;
    }

    modifier recievedByTestingCentre(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.RecievedByTestingCentre);
        _;
    }

    modifier acceptedByTestingCentre(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.AcceptedByTestingCentre);
        _;
    }

    modifier rejectedByTestingCentre(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.RejectedByTestingCentre);
        _;
    }

    modifier sentToBloodBank(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.SentToBloodBank);
        _;
    }

    modifier recievedByBloodBank(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.RecievedByBloodBank);
        _;
    }

    modifier requestedByHospital(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.RequestedByHospital);
        _;
    }

    modifier sentToHospital(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.SentToHospital);
        _;
    }

    modifier recievedByHospital(uint256 _uid) {
        require(samples[_uid].sampleState == Structure.State.RecievedByHospital);
        _;
    }

    function testingCentreEmptyInitialize(Structure.TestingCentreDetails memory testingCentre)
        internal
        pure
    {
        address _address;
        string memory _name;
        string memory _id;

        string memory line1;
        string memory line2;
        string memory city;
        uint16 pincode;
        string memory state;
        string memory country;
        string memory latitude;
        string memory longitude;

        string memory phoneNumber;
        string memory email;
        string memory website;

        testingCentre.testingCentre = _address;
        testingCentre.testingCentreName = _name;
        testingCentre.testingCentreId = _id;

        testingCentre.testingCentreLocationAddress.line1 = line1;
        testingCentre.testingCentreLocationAddress.line2 = line2;
        testingCentre.testingCentreLocationAddress.city = city;
        testingCentre.testingCentreLocationAddress.pincode = pincode;
        testingCentre.testingCentreLocationAddress.state = state;
        testingCentre.testingCentreLocationAddress.country = country;
        testingCentre.testingCentreLocationAddress.latitude = latitude;
        testingCentre.testingCentreLocationAddress.longitude = longitude;

        testingCentre.testingCentreContactDetails.phoneNumber = phoneNumber;
        testingCentre.testingCentreContactDetails.email = email;
        testingCentre.testingCentreContactDetails.website = website;
    }
    
    
    function bloodBankEmptyInitialize(Structure.BloodBankDetails memory bloodBank)
        internal
        pure
    {
        address _address;
        string memory _name;
        string memory _id;

        string memory line1;
        string memory line2;
        string memory city;
        uint16 pincode;
        string memory state;
        string memory country;
        string memory latitude;
        string memory longitude;

        string memory phoneNumber;
        string memory email;
        string memory website;

        bloodBank.bloodBank = _address;
        bloodBank.bloodBankName = _name;
        bloodBank.bloodBankId = _id;

        bloodBank.bloodBankLocationAddress.line1 = line1;
        bloodBank.bloodBankLocationAddress.line2 = line2;
        bloodBank.bloodBankLocationAddress.city = city;
        bloodBank.bloodBankLocationAddress.pincode = pincode;
        bloodBank.bloodBankLocationAddress.state = state;
        bloodBank.bloodBankLocationAddress.country = country;
        bloodBank.bloodBankLocationAddress.latitude = latitude;
        bloodBank.bloodBankLocationAddress.longitude = longitude;

        bloodBank.bloodBankContactDetails.phoneNumber = phoneNumber;
        bloodBank.bloodBankContactDetails.email = email;
        bloodBank.bloodBankContactDetails.website = website;
    }
    
    function hospitalEmptyInitialize(Structure.HospitalDetails memory hospital)
        internal
        pure
    {
        address _address;
        string memory _name;
        string memory _id;

        string memory line1;
        string memory line2;
        string memory city;
        uint16 pincode;
        string memory state;
        string memory country;
        string memory latitude;
        string memory longitude;

        string memory phoneNumber;
        string memory email;
        string memory website;

        hospital.hospital = _address;
        hospital.hospitalName = _name;
        hospital.hospitalId = _id;

        hospital.hospitalLocationAddress.line1 = line1;
        hospital.hospitalLocationAddress.line2 = line2;
        hospital.hospitalLocationAddress.city = city;
        hospital.hospitalLocationAddress.pincode = pincode;
        hospital.hospitalLocationAddress.state = state;
        hospital.hospitalLocationAddress.country = country;
        hospital.hospitalLocationAddress.latitude = latitude;
        hospital.hospitalLocationAddress.longitude = longitude;

        hospital.hospitalContactDetails.phoneNumber = phoneNumber;
        hospital.hospitalContactDetails.email = email;
        hospital.hospitalContactDetails.website = website;
    }

    function collectEmptyInitialize(Structure.Sample memory sample)
        internal
        pure
    {
        address customer;
        string memory transaction;

        testingCentreEmptyInitialize(sample.testingCentre);
        bloodBankEmptyInitialize(sample.bloodBank);
        hospitalEmptyInitialize(sample.hospital);

        sample.customer = customer;
        sample.transaction = transaction;
    }

    function collectSampleInitialize(
        Structure.Sample memory sample,
        string memory sampleId,
        string memory bloodGroup,
        address donorAddress
    ) internal pure {
        string memory testingRemark;

        sample.sampleDetails.sampleId = sampleId;
        sample.sampleDetails.bloodGroup = bloodGroup;
        sample.sampleDetails.testingRemark = testingRemark;
        sample.sampleDetails.donorAddress = donorAddress;
    }


    ///@dev STEP 1 : Collect a Sample
    function collectSample(
        string memory collectionCentreName,
        string memory collectionCentreId,
        Structure.LocationAddress memory collectionCentreLocationAddress,
        Structure.ContactDetails memory collectionCentreContactDetails,
        address donorAddress,
        string memory sampleId,
        string memory bloodGroup
    ) public {
        require(hasCollectionCentreRole(msg.sender));
        uint256 _uid = uid;
        Structure.Sample memory sample;

        sample.sku = sku;
        sample.uid = _uid;
        sample.collectionCentre.collectionCentreName = collectionCentreName;
        sample.collectionCentre.collectionCentreId = collectionCentreId;
        sample.collectionCentre.collectionCentreLocationAddress = collectionCentreLocationAddress;
        sample.collectionCentre.collectionCentreContactDetails = collectionCentreContactDetails;

        sample.owner = msg.sender;
        sample.collectionCentre.collectionCentre = msg.sender;

        collectEmptyInitialize(sample);

        sample.sampleState = Structure.State.SampleCollected;
        
        collectSampleInitialize(
            sample,
            sampleId,
            bloodGroup,
            donorAddress
        );
        sample.sampleDetails.collectedOnDate = block.timestamp;
        samples[_uid] = sample;

        sampleHistory[_uid].history.push(sample);

        sku++;
        uid++;

        emit SampleCollected(_uid);
    }

    ///@dev STEP 2 : Send collected samples to Testing Centre
    function sendToTestingCentre
    (
        uint256 _uid, 
        address testingCentreAddress,
        string memory testingCentreName,
        string memory testingCentreId,
        Structure.LocationAddress memory testingCentreLocationAddress,
        Structure.ContactDetails memory testingCentreContactDetails
    ) 
        public 
        sampleCollected(_uid) 
        verifyAddress(samples[_uid].collectionCentre.collectionCentre)
    {
        require(hasCollectionCentreRole(msg.sender));
        samples[_uid].sampleState = Structure.State.SentToTestingCentre;
        samples[_uid].testingCentre.testingCentre = testingCentreAddress;
        samples[_uid].testingCentre.testingCentreName = testingCentreName;
        samples[_uid].testingCentre.testingCentreId = testingCentreId;
        samples[_uid].testingCentre.testingCentreLocationAddress = testingCentreLocationAddress;
        samples[_uid].testingCentre.testingCentreContactDetails = testingCentreContactDetails;
        
        // sampleHistory[_uid].history.push(samples[_uid]);

        emit SentToTestingCentre(_uid);
    }

    ///@dev STEP 3 : Recieve the samples at Testing Centre
    function recieveByTestingCentre (uint256 _uid)
        public
        sentToTestingCentre(_uid)
        verifyAddress(samples[_uid].testingCentre.testingCentre)
    {
        require(hasTestingCentreRole(msg.sender));
        require(samples[_uid].testingCentre.testingCentre==msg.sender);
        samples[_uid].owner = msg.sender;

        samples[_uid].sampleState = Structure.State.RecievedByTestingCentre;
        // sampleHistory[_uid].history.push(samples[_uid]);

        emit RecievedByTestingCentre(_uid);
    }

    ///@dev STEP 4 : Accept or Reject the Sample
    function updateByTestingCentre
    (
        uint256 _uid,
        string memory testingRemark,
        bool isAccepted
    )
        public
        recievedByTestingCentre(_uid)
    {
        require(hasTestingCentreRole(msg.sender));
        require(samples[_uid].testingCentre.testingCentre==msg.sender);

        samples[_uid].sampleDetails.testingRemark = testingRemark;
        // sampleHistory[_uid].history.push(samples[_uid]);

        if (isAccepted) {
            emit AcceptedByTestingCentre(_uid);
        }
        else {
            emit RejectedByTestingCentre(_uid);
        }
    }

    ///@dev STEP 5 : Send Accpeted samples to BloodBank
    function sendToBloodBank 
    (
        uint256 _uid, 
        address bloodBankAddress,
        string memory bloodBankName,
        string memory bloodBankId,
        Structure.LocationAddress memory bloodBankLocationAddress,
        Structure.ContactDetails memory bloodBankContactDetails
    ) 
        public 
        acceptedByTestingCentre(_uid) 
        verifyAddress(samples[_uid].testingCentre.testingCentre)
    {
        require(hasTestingCentreRole(msg.sender));
        samples[_uid].sampleState = Structure.State.SentToBloodBank;
        samples[_uid].bloodBank.bloodBank = bloodBankAddress;
        samples[_uid].bloodBank.bloodBankName = bloodBankName;
        samples[_uid].bloodBank.bloodBankId = bloodBankId;
        samples[_uid].bloodBank.bloodBankLocationAddress = bloodBankLocationAddress;
        samples[_uid].bloodBank.bloodBankContactDetails = bloodBankContactDetails;
        
        // sampleHistory[_uid].history.push(samples[_uid]);

        emit SentToBloodBank(_uid);
    }

    ///@dev STEP 6 : Recieved by BloodBank
    function recieveByBloodBank (uint256 _uid)
        public
        sentToBloodBank(_uid)
        verifyAddress(samples[_uid].bloodBank.bloodBank)
    {
        require(hasBloodBankRole(msg.sender));
        require(samples[_uid].bloodBank.bloodBank==msg.sender);
        samples[_uid].owner = msg.sender;

        samples[_uid].sampleState = Structure.State.RecievedByBloodBank;
        // sampleHistory[_uid].history.push(samples[_uid]);

        emit RecievedByBloodBank(_uid);
    }

    ///@dev STEP 7 : Request By Hospital
    function requestSampleByHospital 
    (
        uint256 _uid,
        string memory hospitalName,
        string memory hospitalId,
        Structure.LocationAddress memory hospitalLocationAddress,
        Structure.ContactDetails memory hospitalContactDetails
    )
        public
        recievedByBloodBank(_uid)
    {
        require(hasHospitalRole(msg.sender));
        samples[_uid].hospital.hospital = msg.sender;
        samples[_uid].hospital.hospitalName = hospitalName;
        samples[_uid].hospital.hospitalId = hospitalId;
        samples[_uid].hospital.hospitalLocationAddress = hospitalLocationAddress;
        samples[_uid].hospital.hospitalContactDetails = hospitalContactDetails;

        samples[_uid].sampleState = Structure.State.RequestedByHospital;
        // sampleHistory[_uid].history.push(samples[_uid]);
        emit RequestedByHospital(_uid);
    }

    ///@dev STEP 8 : Send to Hospital
    function sendToHospital
    (
        uint256 _uid
    )
        public
        requestedByHospital(_uid)
        verifyAddress(samples[_uid].hospital.hospital)
    {
        require(hasBloodBankRole(msg.sender));
        samples[_uid].sampleState = Structure.State.SentToHospital;
        // sampleHistory[_uid].history.push(samples[_uid]);
        emit SentToHospital(_uid);
    }

    ///@dev STEP 9 : Recieve by Hospital
    function recieveByHospital (uint256 _uid)
        public
        sentToHospital(_uid)
        verifyAddress(samples[_uid].hospital.hospital)
    {
        require(hasHospitalRole(msg.sender));
        require(samples[_uid].hospital.hospital==msg.sender);
        samples[_uid].owner = msg.sender;

        samples[_uid].sampleState = Structure.State.RecievedByHospital;
        // sampleHistory[_uid].history.push(samples[_uid]);

        emit RecievedByHospital(_uid);
    }

    ///@dev Fetch Samples for Collection Centre
    function fetchSamplesForCollectionCentre(
        uint256 _uid,
        string memory _type,
        uint256 i
    )
        public
        view
        returns (
            uint256,
            address,
            string memory,
            string memory,
            address,
            string memory,
            uint256
        )
    {
        require(samples[_uid].uid != 0);
        Structure.Sample storage sample = samples[_uid];
        if (keccak256(bytes(_type)) == keccak256(bytes("sample"))) {
            sample = samples[_uid];
        }
        if (keccak256(bytes(_type)) == keccak256(bytes("history"))) {
            sample = sampleHistory[_uid].history[i];
        }
        return (
            sample.uid,
            sample.owner,
            sample.sampleDetails.sampleId,
            sample.sampleDetails.bloodGroup,
            sample.collectionCentre.collectionCentre,
            sample.collectionCentre.collectionCentreName,
            sample.sampleDetails.collectedOnDate
        );
    }

    // ///@dev Fetch Sample for Sample Details
    // function fetchSamplesForTestingCentre(
    //     uint256 _uid,
    //     string memory _type,
    //     uint256 i
    // )
    //     public
    //     view
    //     returns (
    //         uint256,
    //         uint256,
    //         address,
    //         string memory,
    //         string memory,
    //         string memory,
    //         uint256,
    //         address
    //     )
    // {
    //     require(samples[_uid].uid != 0);
    //     Structure.Sample storage sample = samples[_uid];
    //     if (keccak256(bytes(_type)) == keccak256(bytes("sample"))) {
    //         sample = samples[_uid];
    //     }
    //     if (keccak256(bytes(_type)) == keccak256(bytes("history"))) {
    //         sample = sampleHistory[_uid].history[i];
    //     }
    //     return (
    //         sample.uid,
    //         sample.sku,
    //         sample.owner,
    //         sample.sampleDetails.sampleId,
    //         sample.sampleDetails.bloodGroup,
    //         sample.sampleDetails.testingRemark,
    //         sample.sampleDetails.collectedOnDate,
    //         sample.sampleDetails.donorAddress
    //     );
    // }

    // ///@dev Fetch Sample for Blood Bank
    // function fetchSamplesForBloodBank(
    //     uint256 _uid,
    //     string memory _type,
    //     uint256 i
    // )
    //     public
    //     view
    //     returns (
    //         uint256,
    //         uint256,
    //         address,
    //         string memory,
    //         string memory,
    //         string memory,
    //         uint256,
    //         string memory
    //     )
    // {
    //     require(samples[_uid].uid != 0);
    //     Structure.Sample storage sample = samples[_uid];
    //     if (keccak256(bytes(_type)) == keccak256(bytes("sample"))) {
    //         sample = samples[_uid];
    //     }
    //     if (keccak256(bytes(_type)) == keccak256(bytes("history"))) {
    //         sample = sampleHistory[_uid].history[i];
    //     }
    //     return (
    //         sample.uid,
    //         sample.sku,
    //         sample.owner,
    //         sample.sampleDetails.sampleId,
    //         sample.sampleDetails.bloodGroup,
    //         sample.sampleDetails.testingRemark,
    //         sample.sampleDetails.collectedOnDate,
    //         sample.bloodBank.bloodBankName
    //     );
    // }

    // ///@dev Fetch Sample for Hospital
    // function fetchSamplesForHospital(
    //     uint256 _uid,
    //     string memory _type,
    //     uint256 i
    // )
    //     public
    //     view
    //     returns (
    //         uint256,
    //         uint256,
    //         address,
    //         string memory,
    //         string memory,
    //         string memory,
    //         uint256,
    //         string memory,
    //         Structure.LocationAddress memory,
    //         Structure.ContactDetails memory
    //     )
    // {
    //     require(samples[_uid].uid != 0);
    //     Structure.Sample storage sample = samples[_uid];
    //     if (keccak256(bytes(_type)) == keccak256(bytes("sample"))) {
    //         sample = samples[_uid];
    //     }
    //     if (keccak256(bytes(_type)) == keccak256(bytes("history"))) {
    //         sample = sampleHistory[_uid].history[i];
    //     }
    //     return (
    //         sample.uid,
    //         sample.sku,
    //         sample.owner,
    //         sample.sampleDetails.sampleId,
    //         sample.sampleDetails.bloodGroup,
    //         sample.sampleDetails.testingRemark,
    //         sample.sampleDetails.collectedOnDate,
    //         sample.bloodBank.bloodBankName,
    //         sample.bloodBank.bloodBankLocationAddress,
    //         sample.bloodBank.bloodBankContactDetails
    //     );
    // }

    function fetchSampleCount() public view returns (uint256) {
        return uid;
    }

    // function fetchSampleHistoryLength(uint256 _uid)
    //     public 
    //     view
    //     returns (uint256)
    // {
    //     return sampleHistory[_uid].history.length;
    // }

    function fetchSampleState(uint256 _uid)
        public
        view
        returns (Structure.State)
    {
        return samples[_uid].sampleState;
    }

    function setTransactionHashOnCollect(string memory tran) public {
        sampleHistory[uid - 1].history[
            sampleHistory[uid - 1].history.length - 1
        ].transaction = tran;
    }

    function setTransactionHash(uint256 _uid, string memory tran) public {
        Structure.Sample storage p = sampleHistory[_uid].history[
                sampleHistory[_uid].history.length - 1
            ];
        p.transaction = tran;
    }

}