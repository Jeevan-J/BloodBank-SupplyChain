// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

library Structure {
    // Sample States
    enum State {
        SampleCollected,
        SentToTestingCentre,
        RecievedByTestingCentre,
        AcceptedByTestingCentre,
        RejectedByTestingCentre,
        SentToBloodBank,
        RecievedByBloodBank,
        RequestedByHospital,
        SentToHospital,
        RecievedByHospital
    }

    // Gender types
    enum Gender {
        Male,
        Female,
        Transgender
    }

    // Blood Group types
    // string[] BloodGroup {
    //     "A+",
    //     A-,
    //     B+,
    //     B-,
    //     AB+,
    //     AB-,
    //     O+,
    //     O-,
    // }

    struct LocationAddress {
        string line1;
        string line2;
        string city;
        uint16 pincode;
        string state;
        string country;
        string latitude;
        string longitude;
    }

    struct ContactDetails {
        string phoneNumber;
        string email;
        string website;
    }

    // Donor Details
    struct DonorDetails {
        address donor;
        bool isFitAndHealthy;
        bool isWeightAbove50;
        uint256 dateOfBirth;
        uint256 lastDonationDate;
        Gender gender;
        string UniqueID;
        ContactDetails contactDetails;
    }

    // Citizen Details -- Need to finalize on how to use or reference citizen from donor
    struct CitizenDetails {
        address citizen;
        string firstName;
        string lastName;
        uint256 dateOfBirth;
        Gender gender;
        string UniqueID;
        LocationAddress locationAddress;
        ContactDetails contactDetails;
    }

    // Collection Centre Details
    struct CollectionCentreDetails {
        address collectionCentre;
        string collectionCentreName;
        string collectionCentreId;
        LocationAddress collectionCentreLocationAddress;
        ContactDetails collectionCentreContactDetails;
    }

    // Testing Centre Details
    struct TestingCentreDetails {
        address testingCentre;
        string testingCentreName;
        string testingCentreId;
        LocationAddress testingCentreLocationAddress;
        ContactDetails testingCentreContactDetails;
    }

    // BloodBank Details
    struct BloodBankDetails {
        address bloodBank;
        string bloodBankName;
        string bloodBankId;
        LocationAddress bloodBankLocationAddress;
        ContactDetails bloodBankContactDetails;
    }

    // Hospital Details
    struct HospitalDetails {
        address hospital;
        string hospitalName;
        string hospitalId;
        LocationAddress hospitalLocationAddress;
        ContactDetails hospitalContactDetails;
    }

    // Blood Sample Details
    struct SampleDetails {
        string sampleId;
        string bloodGroup;
        string testingRemark;
        uint256 collectedOnDate;
        address donorAddress;
    }

    // Blood Sample Attributes
    struct Sample {
        uint256 uid;
        uint256 sku;
        address owner;
        State sampleState;
        CollectionCentreDetails collectionCentre;
        TestingCentreDetails testingCentre;
        BloodBankDetails bloodBank;
        HospitalDetails hospital;
        SampleDetails sampleDetails;
        address customer;
        string transaction;
    }

    // Blood Sample History
    struct SampleHistory {
        Sample[] history;
    }

    struct Roles {
        bool collectionCentre;
        bool testingCentre;
        bool bloodBank;
        bool hospital;
        bool donor;
    }
}