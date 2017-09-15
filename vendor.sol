pragma solidity ^0.4.6;

contract vendor {
    // contract owner
    address public creator;

    // device data
    struct device_data {
        uint index;
        uint timestamp;
        string filehash;
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
    function set_device_data (address device_id, string filehash) public returns (uint index) {
        if(is_device_present(device_id)) {
            // device exists
            device_logs[device_id].filehash = filehash;
            device_logs[device_id].timestamp = now;
            return device_logs[device_id].index;
        } else {
            // device received first time
            device_logs[device_id].filehash  = filehash;
            device_logs[device_id].timestamp = now;
            device_logs[device_id].index     = device_index.push(device_id)-1;
            return device_index.length-1;
        }
    }

    // get received data for a specific device
    function get_device_data (address device_id) public constant returns (string hash, uint timestamp, uint index) {
        if(!is_device_present(device_id)) revert();
        return(device_logs[device_id].filehash, device_logs[device_id].timestamp, device_logs[device_id].index);
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
