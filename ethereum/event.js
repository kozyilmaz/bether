var log_action = browser_vendor_sol_vendor.log_action();
log_action.watch(function(error, result){
    if (!error) {
        console.log("DEV[" + result.args.device_id + "] INDEX[" + result.args.index + "] TIME[" + result.args.timestamp + "] HASH[" + result.args.filehash + "]");
    }
});
