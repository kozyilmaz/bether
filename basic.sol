contract vendor {
    // device data
    struct device_data {
        string payload;
        uint index;
    }
    // map device id's to their data (one data per id)
    mapping(uint => device_data) private logs;
    // keep a separate device id array
    uint [] private device_index;

    // push specific device data into the chain
    function insert_data(uint dev_id, string dev_payload) public returns(uint index) {
        //if(is_device(dev_id)) throw;
        logs[dev_id].payload = dev_payload;
        logs[dev_id].index = device_index.push(dev_id)-1;
        return device_index.length-1;
    }
    // get received data for a specific device
    function get_data(uint dev_id) public constant returns(string data) {
        //if(is_device(dev_id)) throw;
        return(logs[dev_id].payload);
    }
}
