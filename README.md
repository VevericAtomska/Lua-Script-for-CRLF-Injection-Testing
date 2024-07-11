Lua Script for CRLF Injection Testing
This Lua script is designed to test for CRLF Injection vulnerabilities in web applications. It includes functionalities to simulate various attacks and scenarios related to CRLF injection.

--------------------------------------------------------------------------------
Requirements
Lua interpreter (tested with Lua 5.3)
LuaSocket library (socket.http)
LuaSocket URL library (socket.url)
LuaSocket ltn12 library (ltn12)
Lua argparse library for command-line parsing (argparse)
Installation
Install Lua Interpreter:
--------------------------------------------------------------------------------
Download and install Lua interpreter from Lua.org.
Install LuaSocket and argparse Libraries:
--------------------------------------------------------------------------------
Use LuaRocks to install required libraries:
--------------------------------------------------------------------------------
luarocks install luasocket
--------------------------------------------------------------------------------
luarocks install argparse
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Usage
Command-line Options
The script supports the following command-line options:

--url-target <URL>: Specify the target URL of the web application.
--crlf-payload <PAYLOAD>: Specify the CRLF payload to inject.
--http-method <METHOD>: (Optional) Choose HTTP method (GET or POST). Default is GET.
--use-headers: (Optional) Use custom headers in the HTTP request.
--headers-file <FILE>: (Required if --use-headers is set) Specify a file containing custom headers.
--------------------------------------------------------------------------------
Example Usage
Basic Usage:
--------------------------------------------------------------------------------
lua crlf_injection.lua --url-target "http://example.com/vulnerable_script.php" --crlf-payload "%0D%0AInjected-Header: EvilHeader"
--------------------------------------------------------------------------------
Advanced Usage with Custom Headers:
--------------------------------------------------------------------------------
lua crlf_injection.lua --url-target "http://example.com/vulnerable_script.php" --crlf-payload "%0D%0AInjected-Header: EvilHeader" --http-method "POST" --use-headers --headers-file "custom_headers.txt"
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Attacks Supported
HTTP Header Injection: Injects CRLF characters to manipulate HTTP headers.
Response Splitting: Manipulates HTTP responses to inject malicious content.
Session Fixation via Header Injection: Attempts to set headers to fixate session IDs.
--------------------------------------------------------------------------------
Additional Notes
Ensure that the provided --url-target points to the root URL of the web application.
Use this script responsibly and only on systems you have permission to test.
Customize payload and attack parameters based on specific testing scenarios and requirements.
--------------------------------------------------------------------------------
