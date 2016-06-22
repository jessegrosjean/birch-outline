function encode(lookup, number) {
    var loopCounter = 0;
    var done;

    var str = '';

    while (!done) {
        str = str + lookup( ( (number >> (4 * loopCounter)) & 0x0f ) | (Math.floor((Math.random() * 256)) & 0x30)  );
        done = number < (Math.pow(16, loopCounter + 1 )  );
        loopCounter++;
    }
    return str;
}

module.exports = encode;