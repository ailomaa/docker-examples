import flask
from werkzeug.middleware.proxy_fix import ProxyFix

app = flask.Flask(__name__)

# proxy fix
app.wsgi_app = ProxyFix(
    app.wsgi_app,
    x_for=1,
    x_proto=1,
    x_host=1,
    x_prefix=1
)

@app.route("/")
def hello_world():
    return '<h1>Home</h1><a href="/about>About</a>'

@app.route("/about")
def about():
    return '<h1>About</h1>'
