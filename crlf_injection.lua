-- Lua script for CRLF Injection Testing

-- Libraries for HTTP handling and URL manipulation
local http = require("socket.http")
local ltn12 = require("ltn12")
local url = require("socket.url")

-- Argument parsing library
local argparse = require("argparse")

-- Create argument parser
local parser = argparse()
parser:option("--url-target", "Target URL of the web application")
parser:option("--crlf-payload", "CRLF payload to inject")
parser:option("--http-method", "HTTP method (GET or POST)", "GET")
parser:flag("--use-headers", "Use custom headers")
parser:option("--headers-file", "File containing custom headers")

-- Parse command line arguments
local args = parser:parse()

-- Function to send HTTP request
local function send_http_request(url, method, headers, body)
    local response_body = {}
    local request = {
        url = url,
        method = method,
        headers = headers,
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response_body)
    }

    local res, code, response_headers = http.request(request)

    if code == 200 then
        print("Request successful. Response body:")
        print(table.concat(response_body))
    else
        print("Request failed. HTTP code:", code)
    end
end

-- Validate and construct full URL
if args.url_target and args.crlf_payload then
    local full_url = args.url_target
    local crlf_payload = args.crlf_payload

    -- Append CRLF payload to URL
    full_url = full_url .. crlf_payload

    -- Load custom headers if specified
    local headers = {}
    if args.use_headers then
        if args.headers_file then
            local file = io.open(args.headers_file, "r")
            if file then
                for line in file:lines() do
                    local header_name, header_value = line:match("([^:]+):%s*(.+)")
                    if header_name and header_value then
                        headers[header_name] = header_value
                    end
                end
                file:close()
            else
                print("Error: Failed to open headers file.")
            end
        else
            print("Error: --headers-file option required when --use-headers is specified.")
        end
    end

    -- Execute the HTTP request with the specified method and headers
    send_http_request(full_url, args.http_method, headers)
else
    print("Error: --url-target and --crlf-payload parameters are required.")
end
