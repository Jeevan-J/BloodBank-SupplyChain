import React from "react";
import { Divider, PageHeader, Input, Row, Col, Select, Button, Form, message } from 'antd';

const { Option } = Select;

const Owner = (props) => {

    const {
        web3,
        accounts,
        chainid,
        bloodBankSupplyChain
    } = props.state;
    var temp = <></>;

    const onFinish = async (values) => {
        console.log('Success:', values);
        const hasRoleMethod = bloodBankSupplyChain.methods['has'+values['role']]
        const hasRole = await hasRoleMethod(values['address']).call()
        if (!hasRole){
            const addRoleMethod = bloodBankSupplyChain.methods['add'+values['role']]
            await addRoleMethod(values['address']).send({ from: accounts[0]})
            message.success('Successfully assigned '+values['role']+' to '+values['address'], 10);
        }
        else{
            message.success(values['role'] + ' has already been assigned to '+values['address'], 10);
        }
    };
    
    const onFinishFailed = (errorInfo) => {
        message.error('Error submitting the form: '+(errorInfo), 5);
        console.log('Failed:', errorInfo);
    };

    return ( <>
        <PageHeader
            title="Manage Accounts"
            subTitle="BloodBank Supply Chain - Owner"
        />
        <Divider />
        {temp}
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