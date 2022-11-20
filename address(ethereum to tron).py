import base58


def hex_to_base58(hex_string):
    if hex_string[:2] in ["0x", "0X"]:
        hex_string = "41" + hex_string[2:]
    bytes_str = bytes.fromhex(hex_string)
    base58_str = base58.b58encode_check(bytes_str)
    return base58_str.decode("UTF-8")


def base58_to_hex(base58_string):
    asc_string = base58.b58decode_check(base58_string)
    return asc_string.hex()


def base58_to_ethereumaddress(base58_string):
    asc_string = base58_to_hex(base58_string)
    return "0x" + asc_string[2:]


etheraddress = "0x6278a1e803a76796a3a1f7f6344fe874ebfe94b2"

address = hex_to_base58(etheraddress)
print("tron address:" + address)
# TJwsjYijRMZB88nmwexuiAQ3MJGct2s4wQ

tron_address = "TJwsjYijRMZB88nmwexuiAQ3MJGct2s4wQ"
print(base58_to_ethereumaddress(tron_address))
# 0x6278a1e803a76796a3a1f7f6344fe874ebfe94b2
