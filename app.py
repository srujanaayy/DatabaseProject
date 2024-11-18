from flask import Flask, render_template, request, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.secret_key = 'supersecretkey'

# Configure MySQL database connection
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:Master0508@localhost/commerceDb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Define your models
class Product(db.Model):
    __tablename__ = 'Product'
    ProductID = db.Column(db.Integer, primary_key=True)
    ProductName = db.Column(db.String(255))
    ProdDescription = db.Column(db.Text)
    Brand = db.Column(db.String(100))
    Price = db.Column(db.Numeric(10, 2))
    Category = db.Column(db.String(100))
    StockQuantity = db.Column(db.Integer)
    CreatedAt = db.Column(db.DateTime, default=db.func.current_timestamp())
    ReOrderLevel = db.Column(db.Integer)
    LastUpdated = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())
    WarehouseLocation = db.Column(db.String(255))

class Customer(db.Model):
    __tablename__ = 'Customer'
    CustomerID = db.Column(db.Integer, primary_key=True)
    FirstName = db.Column(db.String(50))
    LastName = db.Column(db.String(50))
    EmailAddress = db.Column(db.String(100))
    PhoneNumber = db.Column(db.String(15))
    CardNumber = db.Column(db.String(19), db.ForeignKey('CardInformation.CardNumber'))

class Order(db.Model):
    __tablename__ = 'Orders'
    OrderID = db.Column(db.Integer, primary_key=True)
    CustomerID = db.Column(db.Integer, db.ForeignKey('Customer.CustomerID'))
    Date = db.Column(db.DateTime, default=db.func.current_timestamp())
    OrderTime = db.Column(db.DateTime, default=db.func.current_timestamp())
    Status = db.Column(db.Enum('Pending', 'Shipped', 'Delivered'))
    ShippingAddress = db.Column(db.String(255))
class OrderedItem(db.Model):
    __tablename__ = 'OrderedItem'
    OrderID = db.Column(db.Integer, primary_key=True)
    ProductID = db.Column(db.Integer, db.ForeignKey('Product.ProductID'), primary_key=True)
    Quantity = db.Column(db.Integer, nullable=False)
    Price = db.Column(db.Numeric(10, 2), nullable=False)

def serialize_product(product): 
    return { 
        'ProductID': product.ProductID, 
        'ProductName': product.ProductName,
        'ProdDescription': product.ProdDescription, 
        'Brand': product.Brand, 
        'Price': float(product.Price), # Convert to float for JSON serialization 
        'Category': product.Category, 
        'StockQuantity': product.StockQuantity, 
        'WarehouseLocation': product.WarehouseLocation 
        }
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        role = request.form['role']
        if role == 'admin':
            return redirect(url_for('admin_login'))
        else:
            return redirect(url_for('customer_login'))
    return render_template('login.html')

@app.route('/admin-login', methods=['GET', 'POST'])
def admin_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username == 'admin' and password == 'pass123':
            session['username'] = username
            return redirect(url_for('admin_dashboard'))
        else:
            return 'Invalid credentials'
    return render_template('admin_login.html')

@app.route('/customer-login', methods=['GET', 'POST'])
def customer_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        session['username'] = username
        return redirect(url_for('customer_dashboard'))
    return render_template('customer_login.html')

@app.route('/admin-dashboard')
def admin_dashboard():
    if 'username' not in session:
        return redirect(url_for('login'))
    return render_template('admin_dashboard.html')

@app.route('/customer-dashboard')
def customer_dashboard():
    if 'username' not in session:
        return redirect(url_for('login'))
    return render_template('customer_dashboard.html')

@app.route('/inventory') 
def inventory(): 
    if 'username' not in session or session['username'] != 'admin': 
        return redirect(url_for('login')) 
    products = Product.query.all() 
    serialized_products = [serialize_product(product) for product in products] 
    return render_template('inventory.html', products=serialized_products) 
@app.route('/add-product', methods=['POST'])
def add_product():
    if 'username' not in session or session['username'] != 'admin':
        return redirect(url_for('login'))
    
    new_product = Product(
        ProductName=request.form['product_name'],
        ProdDescription=request.form['product_description'],
        Brand=request.form['brand'],
        Price=request.form['price'],
        Category=request.form['category'],
        StockQuantity=request.form['stock_quantity'],
        WarehouseLocation=request.form['warehouse_location']
    )
    db.session.add(new_product)
    db.session.commit()
    
    return redirect(url_for('inventory'))

@app.route('/edit-product', methods=['POST'])
def edit_product():
    if 'username' not in session or session['username'] != 'admin':
        return redirect(url_for('login'))
    
    product_id = request.form['product_id']
    product = Product.query.get(product_id)
    product.ProductName = request.form['product_name']
    product.ProdDescription = request.form['product_description']
    product.Brand = request.form['brand']
    product.Price = request.form['price']
    product.Category = request.form['category']
    product.StockQuantity = request.form['stock_quantity']
    product.WarehouseLocation = request.form['warehouse_location']
    
    db.session.commit()
    
    return redirect(url_for('inventory'))

@app.route('/delete-product/<int:product_id>', methods=['POST'])
def delete_product(product_id):
    if 'username' not in session or session['username'] != 'admin':
        return redirect(url_for('login'))
    
    # Delete any OrderedItem records referencing this Product
    OrderedItem.query.filter_by(ProductID=product_id).delete()
    
    # Now delete the Product
    product = Product.query.get(product_id)
    db.session.delete(product)
    db.session.commit()
    
    return redirect(url_for('inventory'))


@app.route('/orders')
def orders():
    if 'username' not in session or session['username'] != 'admin':
        return redirect(url_for('login'))
    orders = Order.query.all()
    return render_template('orders.html', orders=orders)

@app.route('/customers')
def customers():
    if 'username' not in session or session['username'] != 'admin':
        return redirect(url_for('login'))
    customers = Customer.query.all()
    return render_template('customers.html', customers=customers)

@app.route('/shopping-cart')
def shopping_cart():
    if 'username' not in session or session['username'] == 'admin':
        return redirect(url_for('login'))
    return render_template('shopping_cart.html')

@app.route('/products')
def products():
    if 'username' not in session or session['username'] == 'admin':
        return redirect(url_for('login'))
    return render_template('products.html')

@app.route('/search', methods=['GET', 'POST'])
def search():
    if 'username' not in session or session['username'] == 'admin':
        return redirect(url_for('login'))
    
    products = []
    if request.method == 'POST':
        search_query = request.form['search_query']
        products = Product.query.filter(Product.ProductName.like(f'%{search_query}%')).all()
    
    return render_template('search.html', products=products)


@app.route('/process-checkout', methods=['POST'])
def process_checkout():
    if request.method == 'POST':
        full_name = request.form['full-name']
        address = request.form['address']
        city = request.form['city']
        state = request.form['state']
        zip_code = request.form['zip']
        country = request.form['country']
        credit_card = request.form['credit-card']
        expiry = request.form['expiry']
        cvv = request.form['cvv']
        
        # Add your order processing logic here
        
        return 'Order successfully placed!'
    return redirect(url_for('checkout'))

@app.route('/logout')
def logout():
    session.pop('username', None)
    return render_template('logout.html')

if __name__ == '__main__':
    app.run(debug=True)
