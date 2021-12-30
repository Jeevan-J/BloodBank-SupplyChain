import React from "react";
import { Divider, PageHeader, Input, Row, Col, Select, Button, Form } from 'antd';

const { Option } = Select;

const Owner = (props) => {

    const {
        web3,
        accounts,
        chainid,
        bloodBankSupplyChain
    } = props.state;

    const onFinish = async (values) => {
        console.log('Success:', values);
        if (values['role']==="CollectionCentreRole"){
            await bloodBankSupplyChain.methods.addCollectionCentreRole(values['address']).send({ from: accounts[0]})
        }
        
    };
    
    const onFinishFailed = (errorInfo) => {
        console.log('Failed:', errorInfo);

    };

    return ( <>
        <PageHeader
            title="Manage Accounts"
            subTitle="BloodBank Supply Chain - Owner"
        />
        <Divider />
        <Form
            name="basic"
            labelCol={{span: 4,}}
            wrapperCol={{span: 8,}}
            initialValues={{remember: true,}}
            onFinish={onFinish}
            onFinishFailed={onFinishFailed}
            autoComplete="off"
            >
            <Form.Item
                label="Role"
                name="role"
                rules={[
                {
                    required: true,
                    message: 'Please select a Role!',
                },
                ]}
            >
                <Select style={{ width: '100%' }} >
                    <Option value="CollectionCentreRole">Collection Centre Role</Option>
                    <Option value="TestingCentreRole">Testing Centre Role</Option>
                    <Option value="BloodBankRole">Blood Bank Role</Option>
                    <Option value="HospitalRole">Hospital Role</Option>
                </Select>
            </Form.Item>

            <Form.Item
                label="Address"
                name="address"
                rules={[
                {
                    required: true,
                    message: 'Please enter the Address!',
                },
                ]}
            >
                <Input placeholder="Enter Address : 0x..." />
            </Form.Item>

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
    </> );
}
 
export default Owner;