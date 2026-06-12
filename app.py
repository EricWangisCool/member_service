from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"}), 200

@app.route('/api/v1/member/login', methods=['POST'])
def login():
    data = request.get_json() or {}
    username = data.get('username')
    password = data.get('password')
    
    # Simple mock check (username is admin, password is password123)
    if username == "admin" and password == "password123":
        return jsonify({
            "status": "success",
            "message": "Login successful",
            "token": "mock-jwt-token-12345"
        }), 200
    else:
        return jsonify({
            "status": "fail",
            "message": "Invalid username or password"
        }), 401

if __name__ == '__main__':
    print("Starting Member Microservice on http://127.0.0.1:5001")
    app.run(host="127.0.0.1", port=5001, debug=False)
