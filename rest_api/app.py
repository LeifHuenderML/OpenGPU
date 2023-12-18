from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/hello', methods=['GET'])
def get_hello():
    return jsonify({'message': 'hello'})

if __name__ == '__main__':
    app.run(debug=True)
