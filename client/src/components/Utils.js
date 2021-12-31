import React from "react";
import { Input, Select, Button, Form, InputNumber, Divider } from 'antd';


export const LocationAddressForm = <>
    <Form.Item
        label="Line 1"
        name="line1"
        >
        <Input placeholder="Enter Address Line 1"/>
    </Form.Item>
    <Form.Item
        label="Line 2"
        name="line2"
        >
        <Input placeholder="Enter Address Line 2"/>
    </Form.Item>
    <Form.Item
        label="City"
        name="city"
        >
        <Input placeholder="Enter City Name"/>
    </Form.Item>
    <Form.Item
        label="Pincode"
        name="pincode"
        >
        <Input placeholder="Enter Pincode"/>
    </Form.Item>
    <Form.Item
        label="State"
        name="state"
        >
        <Input placeholder="Enter State Code"/>
    </Form.Item>
    <Form.Item
        label="Country"
        name="country"
        >
        <Input placeholder="Enter Country"/>
    </Form.Item>
    <Form.Item
        label="Latitude"
        name="latitude"
        >
        <Input placeholder="Enter Latitude"/>
    </Form.Item>
    <Form.Item
        label="Longitude"
        name="longitude"
        >
        <Input placeholder="Enter Longitude"/>
    </Form.Item>
</>

export const ContactDetailsForm = <>
    <Form.Item
        label="Phone Number"
        name="phoneNumber"
        >
        <Input placeholder="Enter Phone Number"/>
    </Form.Item>
    <Form.Item
        label="Email"
        name="email"
        >
        <Input placeholder="Enter Email"/>
    </Form.Item>
    <Form.Item
        label="Website"
        name="website"
        >
        <Input placeholder="Enter Website"/>
    </Form.Item>
</>


export const checkRole = async (bloodBankSupplyChain, role, address) => {
    const hasRoleMethod = bloodBankSupplyChain.methods['has'+role]
    const hasRole = await hasRoleMethod(address).call()
    if (hasRole){
        return true
    }
    return false
};