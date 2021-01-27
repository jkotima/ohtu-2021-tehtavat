import unittest
from statistics import Statistics
from player import Player

class StubReader():
    def get_players(self):
        return [
            Player("Semenko", "EDM", 4, 12),
            Player("Lemieux", "PIT", 45, 54),
            Player("Kurri",   "EDM", 37, 53),
            Player("Yzerman", "DET", 42, 56),
            Player("Gretzky", "EDM", 35, 89)
        ]

class TestStatistics(unittest.TestCase):
    def setUp(self):
        self.statistics = Statistics(
            StubReader()
        )

    def test_search_returns_right_player(self):
        player = self.statistics.search("Semenko")
        self.assertEqual(player.name, "Semenko")

    def test_search_returns_none_if_not_found(self):
        self.assertIsNone(self.statistics.search("Kekkonen"))

    def test_right_players_returned_of_team(self):
        players = self.statistics.team("EDM")
        player_names = map(lambda p: p.name, players)
        self.assertCountEqual(player_names, ["Semenko", "Kurri", "Gretzky"])   

    def test_right_order_of_players_in_top_scorers(self):
        players = self.statistics.top_scorers(4)
        player_names = list( map( lambda p: p.name, players ) )
        self.assertListEqual(
            player_names, 
            ['Gretzky', 'Lemieux', 'Yzerman', 'Kurri', 'Semenko']
        )