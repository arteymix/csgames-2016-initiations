from flask import Flask, render_template, g, request, redirect, url_for, flash
import sqlite3

app = Flask(__name__)

app.config['SECRET_KEY'] = 'sdasdas'

@app.before_request
def create_database():
    g.db = sqlite3.connect('horaires.sqlite3')
    g.db.row_factory = sqlite3.Row

@app.after_request
def commit_database(res):
    g.db.commit()
    g.db.close()
    return res

@app.template_global()
def query(st, **params):
    return g.db.execute(st, params)

@app.route("/", methods={'GET', 'POST'})
def home():
    if request.authorization:
        users = query('select * from users where username=:username and password=:password', **request.authorization)
        if not users.fetchone():
            return redirect(url_for('login'))
    if request.method == 'POST':
        try:
            g.db.execute('insert into users_shifts values (:user_id, :shift_id)', request.form)
        except sqlite3.IntegrityError:
            flash('Vous être probablement déjà inscrit à ce shift.')
    shifts = g.db.execute('select * from shifts order by begin, day')
    return render_template("home.html", shifts=shifts)

@app.route('/register', methods={'POST'})
def register():
    try:
        g.db.execute('insert into users (username, password) values (:username, :password)', request.form)
    except sqlite3.IntegrityError:
        flash('Le nom est probablement déjà utilisé.', 'error')
    return redirect(url_for('home'))

@app.route("/login", methods={'GET'})
def login():
    if request.authorization:
        user = g.db.execute('select * from users where username=? and password=?', (request.authorization.username, request.authorization.password))
        if user.fetchone():
            flash('Bienvenue à toi, {}!'.format(request.authorization.username))
            return redirect(url_for('home'))
    return '', 401, {'WWW-Authenticate': 'Basic realm=\'\''}

@app.route("/logout")
def logout():
    flash('While HTTP does not provide a method for a web server to instruct the browser to "log out" the user (forget cached credentials), there are a number of workarounds using specific features in various browsers.')
    return redirect(url_for('home'))

@app.route("/messages/<int:user_id>", methods=['GET', 'POST'])
def messages(user_id):
    if not request.authorization:
        return redirect(url_for('login'))
    if request.method == 'POST':
        g.db.execute('insert into messages (from_id, to_id, message) values (:from_id, :to_id, :message)', request.form)
    from_id = query('select id from users where username=:username', **request.authorization).fetchone()['id']
    messages = query("""
    select * from messages
        where (to_id=:to_id and from_id=:from_id)
        or (to_id=:from_id and from_id=:to_id)
        order by sent""", from_id=from_id, to_id=user_id)
    return render_template('messages.html', messages=messages, to_id=user_id)

@app.route('/clean')
def clean():
    g.db.execute('delete from users_shifts')
    g.db.execute('delete from users')
    return redirect(url_for('home'))

app.run(debug=True)
