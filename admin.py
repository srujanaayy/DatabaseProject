@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    # Logic to check credentials
    if authenticate_admin(username, password):
        return redirect('/admin-dashboard')
    else:
        return render_template('admin-dashboard.html', error="Invalid credentials")
