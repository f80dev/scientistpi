import networkx as nx
G = nx.karate_club_graph()
print(nx.betweenness_centrality(G).values())
