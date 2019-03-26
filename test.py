import networkx as nx
import matplotlib.pyplot as plt

G = nx.karate_club_graph()
print(nx.betweenness_centrality(G).values())
