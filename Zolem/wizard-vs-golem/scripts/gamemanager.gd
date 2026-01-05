extends Node # Or whatever your main node is

# We grab our Request Robot (the HTTPRequest node) from the scene tree.
@onready var cat_fact_request: HTTPRequest = HTTPRequest.new()

# This is the address (URL) of the Magic Mailbox we want to talk to.
const CAT_FACT_URL = "https://catfact.ninja/fact"

func _ready() -> void:
	add_child(cat_fact_request)
	# 1. Connect the Robot's "Done!" signal to our function.
	# This means when the Robot comes back with the answer, it calls '_on_cat_fact_request_completed'.
	cat_fact_request.request_completed.connect(_on_cat_fact_request_completed)
	
	# Let's start the process as soon as the game starts!
	get_a_cat_fact()

## --- Function to SEND the request ---
func get_a_cat_fact() -> void:
	# The Robot asks the Mailbox for data (a "GET" request).
	print("🤖 Sending request to get a cat fact...")
	
	# We tell the Robot the URL (address). No special headers are needed for this simple API.
	var error_code = cat_fact_request.request(CAT_FACT_URL)
	
	# If error_code is 0 (OK), it means the Robot successfully left the Toy Box!
	if error_code != OK:
		print("❌ Error starting the request. Code: ", error_code)
	
## --- Function to HANDLE the response ---
# This function automatically runs when the 'request_completed' signal fires.
func _on_cat_fact_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	
	# Check 1: Did the Robot fail to leave the Toy Box (network error)?
	if result != HTTPRequest.RESULT_SUCCESS:
		print("❌ Network connection failed! Result: ", result)
		return
	
	# Check 2: Did the Magic Mailbox give us a bad code (e.g., 404 Not Found)?
	if response_code != 200:
		print("❌ API Error! HTTP Status Code: ", response_code)
		return
		
	print("✅ Request successful! Status Code: 200")
	
	# The raw answer (body) is messy data, so we turn it into a readable string.
	var response_text = body.get_string_from_utf8()
	
	# Now, we use the Decoder Ring to turn the messy JSON string into a Godot Dictionary.
	var parse_result = JSON.parse_string(response_text)
	
	if parse_result is Dictionary:
		# We got a successful Dictionary!
		var data: Dictionary = parse_result
		
		# We look inside the Dictionary for the key called "fact"
		if data.has("fact"):
			var cat_fact = data["fact"]
			print("\n🐱 Fun Cat Fact Received:")
			print("---------------------------------")
			print(cat_fact)
			print("---------------------------------")
		else:
			print("⚠️ The API sent data, but it didn't have a 'fact' key.")
	else:
		print("❌ Failed to decode the answer from the Magic Mailbox.")
