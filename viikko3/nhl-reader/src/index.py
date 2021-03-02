import requests
from player import Player

def main():
    url = "https://nhlstatisticsforohtu.herokuapp.com/players"
    response = requests.get(url).json()

    #print("JSON-muotoinen vastaus:")
    #print(response)

    players = []

    for player_dict in response:
        player = Player(
            player_dict['name'],
            player_dict['team'],
            player_dict['goals'],
            player_dict['assists'],
            player_dict['nationality']
        )
        players.append(player)

    print("Players:")

    finnish_players = list(filter(lambda p: p.nationality == "FIN", players))
    finnish_players_by_points = sorted(
        finnish_players,
        key = lambda p: p.goals + p.assists,
        reverse=True
    )
    

    for player in finnish_players_by_points:
        print(player)

if __name__ == "__main__":
    main()
