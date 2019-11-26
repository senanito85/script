#/usr/bin/python3

import os
import sqlite3

con = sqlite3.connect('/root/example.db')
c = con.cursor()

#c.execute("SELECT * FROM Cars")

print("")
print("Cars")

for row in c.execute('SELECT * FROM Cars'):
        print(row)

print("")
print("Customerss")
#print("")

for r in c.execute('SELECT * FROM Customers'):
        print(r)
print("")
print("Orders")
#print("")

for s in c.execute('SELECT * FROM Orders'):
        print(s)
print("")

# Save (commit) the changes
con.commit()

# We can also close the connection if we are done with it.
# Just be sure any changes have been committed or they will be lost.
con.close()
