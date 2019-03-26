from flask import Flask, send_file
import networkx as nx
import matplotlib.pyplot as plt
import sys

app = Flask(__name__)

@app.route('/')
def hello_world():
   G = nx.karate_club_graph()
   nx.draw_circular(G, with_labels=True)
   plt.savefig('graph.png')
   return send_file('graph.png', mimetype='image/png')

if __name__ == '__main__':
    port=6271
    if len(sys.argv)>1:port=sys.argv[1]
    app.run(port=port,debug=True)
