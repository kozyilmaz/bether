pragma solidity ^0.4.0;

contract vendor {
    // contract owner
    address public creator;

    // device data
    struct device_data {
        bytes32 payload;
        uint index;
    }
    // map device id's to their data (one data per id)
    mapping(address => device_data) private logs;
    // keep a separate device id array
    address[] private device_index;

    // is this device seen before?
    function is_device(address dev_id) public constant returns(bool result) {
        if(device_index.length == 0) return false;
        return (device_index[logs[dev_id].index] == dev_id);
    }
    // push specific device data into the chain
    function insert_data(address dev_id, bytes32 dev_payload) public returns(uint index) {
        //if(is_device(dev_id)) throw;
        logs[dev_id].payload = dev_payload;
        logs[dev_id].index = device_index.push(dev_id)-1;
        return device_index.length-1;
    }
    // get received data for a specific device
    function get_data(address dev_id) public constant returns(bytes32 data, uint index) {
        //if(is_device(dev_id)) throw;
        return(logs[dev_id].payload, logs[dev_id].index);
    }
    // constructor
    function vendor() {
        creator = msg.sender;
    }
    // kills contract and sends remaining funds back to creator
    function kill() {
        if (msg.sender == creator) {
            selfdestruct(creator);
        }
    }
}
