pragma solidity ^0.4.6;

contract vendor {
    // contract owner
    address public creator;

    // device data
    struct device_data {
        uint index;
        uint[] timestamps;
        mapping(uint => string) filehashes;
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
    function set_device_data (address device_id, string filehash) public returns (uint index, uint timestamp) {
        uint ts;
        if(is_device_present(device_id)) {
            // device exists
            ts = now;
            // TODO check if data is associated with that timestamp
            device_logs[device_id].timestamps.push(ts);
            device_logs[device_id].filehashes[ts] = filehash;
            return(device_logs[device_id].index, ts);
        } else {
            // device received first time
            ts = now;
            device_logs[device_id].timestamps.push(ts);
            device_logs[device_id].filehashes[ts] = filehash;
            device_logs[device_id].index = device_index.push(device_id)-1;
            return(device_index.length-1, ts);
        }
    }

    // get received data at a certain timestamp for a specific device
    function get_device_data (address device_id, uint timestamp) public constant returns (string hash) {
        if(!is_device_present(device_id)) revert();
        return device_logs[device_id].filehashes[timestamp];
    }
    
    // get all data timestamps for a specific device
    function get_device_timestamps (address device_id) public constant returns (uint[] timestamp) {
        if(!is_device_present(device_id)) revert();
        return device_logs[device_id].timestamps;
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
