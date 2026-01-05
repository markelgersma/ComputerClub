extends Node # Or whatever your main node is
var currentTemp = 21
# We grab our Request Robot (the HTTPRequest node) from the scene tree.
@onready var cat_fact_request: HTTPRequest = HTTPRequest.new() #$CatFactRequest

# This is the address (URL) of the Magic Mailbox we want to talk to.
const CAT_FACT_URL = "https://api.openweathermap.org/data/2.5/weather?lat=43&lon=-79&appid=8c8e0c780b7dd25867023080c97920ad"

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
		if data.has("temp"):
			var cat_fact = data["temp"]
			print("\n🐱 Weater Received:")
			print("---------------------------------")
			print(data)
			print("---------------------------------")
			currentTemp = data["temp"]
		else:
			print("⚠️ The API sent data, but it didn't have a 'fact' key.")
	else:
		currentTemp = 21
		return
		#print("❌ Failed to decode the answer from the Magic Mailbox.")
		#Data source is in JSON:
		"""{"coord":{"lon":-79,"lat":43},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":275.39,"feels_like":272.61,"temp_min":274.6,"temp_max":276.65,"pressure":1012,"humidity":72,"sea_level":1012,"grnd_level":989},"visibility":10000,"wind":{"speed":2.68,"deg":245,"gust":3.13},"clouds":{"all":100},"dt":1767646187,"sys":{"type":2,"id":19970,"country":"US","sunrise":1767617235,"sunset":1767650112},"timezone":-18000,"id":5137842,"name":"Sheenwater","cod":200}"""
