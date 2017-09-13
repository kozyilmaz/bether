pragma solidity ^0.4.6;

contract vendor {
    // contract owner
    address public creator;

    // device data
    struct device_data {
        bytes32 file_hash;
        uint timestamp;
        uint index;
    }
    // map device id's to their data (one data per id)
    mapping(address => device_data) private device_logs;

    // keep a separate device id array of all received id's
    address[] private device_index;

    // helper function to convert byte32 to string
    // https://ethereum.stackexchange.com/questions/2519/how-to-convert-a-bytes32-to-string
    function bytes32ToString(bytes32 x) constant returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
    
    // helper function to convert byte32 array to string
    // https://ethereum.stackexchange.com/questions/2519/how-to-convert-a-bytes32-to-string
    function bytes32ArrayToString(bytes32[] data) returns (string) {
        bytes memory bytesString = new bytes(data.length * 32);
        uint urlLength;
        for (uint i=0; i<data.length; i++) {
            for (uint j=0; j<32; j++) {
                byte char = byte(bytes32(uint(data[i]) * 2 ** (8 * j)));
                if (char != 0) {
                    bytesString[urlLength] = char;
                    urlLength += 1;
                }
            }
        }
        bytes memory bytesStringTrimmed = new bytes(urlLength);
        for (i=0; i<urlLength; i++) {
            bytesStringTrimmed[i] = bytesString[i];
        }
        return string(bytesStringTrimmed);
    }
    
    // check if device is seen before?
    function is_device_present (address device_id) public constant returns (bool result) {
        // return false if no device present yet!
        if(device_index.length == 0) return false;
        // return true if device exists
        return (device_index[device_logs[device_id].index] == device_id);
    }

    // push specific device data handle into the chain
    function set_device_data (address device_id, bytes32 file_hash) public returns (uint index) {
        if(is_device_present(device_id)) {
            // device exists
            device_logs[device_id].file_hash = file_hash;
            device_logs[device_id].timestamp = now;
            return device_logs[device_id].index;
        } else {
            // device received first time
            device_logs[device_id].file_hash = file_hash;
            device_logs[device_id].timestamp = now;
            device_logs[device_id].index     = device_index.push(device_id)-1;
            return device_index.length-1;
        }
    }

    // get received data for a specific device
    function get_device_data (address device_id) public constant returns (bytes32 hash, uint timestamp, uint index) {
        if(!is_device_present(device_id)) revert();
        return(device_logs[device_id].file_hash, device_logs[device_id].timestamp, device_logs[device_id].index);
    }

    // get received data for a specific device
    function get_device_data_string (address device_id) public constant returns (string hash, uint timestamp, uint index) {
        if(!is_device_present(device_id)) revert();
        return(bytes32ToString(device_logs[device_id].file_hash), device_logs[device_id].timestamp, device_logs[device_id].index);
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
