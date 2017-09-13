pragma solidity ^0.4.16;

contract vendor {
    // contract owner
    address public creator;

    // device data
    struct device_data {
        bytes32 file_hash;
        uint index;
    }
    // map device id's to their data (one data per id)
    mapping(address => device_data) private device_logs;

    // keep a separate device id array of all received id's
    address[] private device_index;

    // check if device is seen before?
    function is_device_present (address device_id) public constant returns (bool result) {
        // return false if no device present yet!
        if(device_index.length == 0) return false;
        // return true if device exists
        return (device_index[device_logs[device_id].index] == device_id);
    }

    // push specific device data handle into the chain
    function push_device_data (address device_id, bytes32 file_hash) public returns (uint index) {
        if(is_device_present(device_id)) {
            // device exists
            device_logs[device_id].file_hash = file_hash;
            return device_logs[device_id].index;
        } else {
            // device received first time
            device_logs[device_id].file_hash = file_hash;
            device_logs[device_id].index     = device_index.push(device_id)-1;
            return device_index.length-1;
        }
    }

    // get received data for a specific device
    function get_device_data (address device_id) public constant returns (bytes32 data, uint index) {
        if(is_device_present(device_id)) revert();
        return(device_logs[device_id].file_hash, device_logs[device_id].index);
    }

    // get total device count
    function get_device_count() public constant returns (uint count) {
        return device_index.length;
    }

    // get device address from index
    function get_device_at_index (uint index) public constant returns (address device_address) {
        return device_index[index];
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
