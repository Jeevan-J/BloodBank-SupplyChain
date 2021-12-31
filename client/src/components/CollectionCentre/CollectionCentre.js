import React, { useState } from "react";
import { Divider, PageHeader, Input, Select, Button, Form, message, Tabs, Table  } from 'antd';

import {checkRole, LocationAddressForm, ContactDetailsForm} from '../Utils';


const { Option } = Select;
const { TabPane } = Tabs;

const CollectionCentre = (props) => {
    const {
        web3,
        accounts,
        chainid,
        bloodBankSupplyChain
    } = props.state

    const [hasRole, updateHasRole] = useState(false)
    const [count, setCount] = useState(0);
    const [allCollectedSamples, setAllCollectedSamples] = useState([]);

    const collectedSamplesColumns = [
        {
          title: 'Sample UID',
          dataIndex: '0',
          key: '0',
        },
        {
          title: 'Sample Owner',
          dataIndex: '1',
          key: '1',
        },
        {
          title: 'Sample ID',
          dataIndex: '2',
          key: '2',
        },
        {
          title: 'Blood Group',
          dataIndex: '3',
          key: '3',
        },
        {
          title: 'Collection Centre',
          dataIndex: '4',
          key: '4',
        },
        {
          title: 'Collection Centre Name',
          dataIndex: '5',
          key: '5',
        },
        {
          title: 'Collected On',
          dataIndex: '6',
          key: '6',
        },
      ];

    React.useEffect(() => {
        (async () => {
          const cnt = await bloodBankSupplyChain.methods.fetchSampleCount().call();
          setCount(cnt);
        })();
    
        (async () => {
          const arr = [];
          for (var i = 1; i < count; i++) {
            const prodState = await bloodBankSupplyChain.methods
              .fetchSampleState(i)
              .call();
            if (prodState === "0") {
              var a = await bloodBankSupplyChain.methods
                .fetchSamplesForCollectionCentre(i, "sample", 0)
                .call();
              const d = new Date(parseInt(a[6] * 1000));
              a[6] = d.toDateString() + " " + d.toTimeString();
              arr.push(a);
            }
          }
          setAllCollectedSamples(arr);
          console.log("arr",arr);
        })();
      }, [count]);
    

    const getRole = async () => {
        const hasRole1 = await checkRole(bloodBankSupplyChain, 'CollectionCentreRole', accounts[0])
        updateHasRole(hasRole1)
        console.log("hello",hasRole)
    }
    getRole()

    const callback = (key) => {
        console.log(key);
    }

    const onCollectSample = async (values) => {
        console.log('Success:', values);
        getRole()
        if (hasRole){
            const collectSampleMethod = bloodBankSupplyChain.methods['collectSample']
            await collectSampleMethod(
                values['collectionCentreName'],
                values['collectionCentreId'],
                [values['line1'],values['line2'],values['city'],values['pincode'],values['state'],values['country'],values['latitude'],values['longitude'],],
                [values['phoneNumber'], values['email'], values['website']],
                values['donorAddress'],
                values['sampleId'],
                values['bloodGroup'],
            ).send({ from: accounts[0]})
            message.success('Successfully created a Sample with ID: '+values['sampleId'], 10);
        }
        else{
            message.success(accounts[0] + ' has no role permissions to create a blood sample', 10);
        }
    };
    
    const onCollectSampleFailed = (errorInfo) => {
        message.error('Error submitting the form: '+(errorInfo), 5);
        console.log('Failed:', errorInfo);
    };

    return ( <>
        <PageHeader
            title="Collection Centre"
            subTitle="BloodBank Supply Chain"
        />
        <Divider />
        {
            hasRole ? 
            <Tabs onChange={callback} tabPosition="left">
                <TabPane tab="Collect Sample" key="1">
                    <Form
                        name="basic"
                        labelCol={{span: 4,}}
                        wrapperCol={{span: 8,}}
                        initialValues={{remember: true,}}
                        onFinish={onCollectSample}
                        onFinishFailed={onCollectSampleFailed}
                        autoComplete="on"
                        >
                        <Divider orientation="left" >Sample Details</Divider>
                        <Form.Item
                            label="Sample ID"
                            name="sampleId"
                            rules={[
                            {
                                required: true,
                                message: 'Please enter the Sample ID!',
                            },
                            ]}
                        >
                            <Input placeholder="Enter Sample ID" />
                        </Form.Item>
                        <Form.Item
                            label="Blood Group"
                            name="bloodGroup"
                            rules={[
                            {
                                required: true,
                                message: 'Please enter the Blood Group!',
                            },
                            ]}
                        >
                            <Input placeholder="Enter Blood Group" />
                        </Form.Item>
                        <Form.Item
                            label="Donor Address"
                            name="donorAddress"
                            rules={[
                            {
                                required: true,
                                message: 'Please enter the Donor Address!',
                            },
                            ]}
                        >
                            <Input placeholder="Enter Address : 0x..." />
                        </Form.Item>
                        <Divider orientation="left" >Collection Centre Details</Divider>
                        <Form.Item
                            label="Collection Centre Name"
                            name="collectionCentreName"
                            rules={[
                            {
                                required: true,
                                message: 'Please enter the Collection Centre Name!',
                            },
                            ]}
                        >
                            <Input placeholder="Enter Collection Centre Name" />
                        </Form.Item>
                        <Form.Item
                            label="Collection Centre Id"
                            name="collectionCentreId"
                            rules={[
                            {
                                required: true,
                                message: 'Please enter the Collection Centre Id!',
                            },
                            ]}
                        >
                            <Input placeholder="Enter Collection Centre Id" />
                        </Form.Item>
                        <Divider plain>Location Details</Divider>
                        {LocationAddressForm}
                        <Divider plain>Contact Details</Divider>
                        {ContactDetailsForm}            
                        <Form.Item
                            wrapperCol={{
                            offset: 8,
                            span: 16,
                            }}
                        >
                            <Button type="primary" htmlType="submit">
                            Submit
                            </Button>
                        </Form.Item>
                    </Form>
                </TabPane>
                <TabPane tab="Collected Samples" key="2">
                    <Table dataSource={allCollectedSamples} columns={collectedSamplesColumns} />;
                </TabPane>
            </Tabs> : 
            <h1>You don't have access to Collection Centre!</h1>
        }
    </> );
}
 
export default CollectionCentre;