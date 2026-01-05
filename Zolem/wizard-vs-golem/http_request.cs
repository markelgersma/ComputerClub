using Godot;
using System;

public partial class http_request : Node
{
	using HttpClient client = new HttpClient();
	string url = "https://example.com";
	HttpResponseMessage response = await client.GetAsync(url);
	// Ensure request was successful
	response.EnsureSuccessStatusCode();
	// Read response as string
	string responseData = await response.Content.ReadAsStringAsync();
}
