import toml
from urllib import request
from project import Project

class ProjectReader:
    def __init__(self, url):
        self._url = url

    def get_project(self):
        # tiedoston merkkijonomuotoinen sisältö
        content = request.urlopen(self._url).read().decode("utf-8")
        
        # deserialisoi TOML-formaatissa oleva merkkijono    
        parsed_toml = toml.loads(content)

        name = parsed_toml["tool"]["poetry"]["name"]
        description = parsed_toml["tool"]["poetry"]["description"]
        dependencies = parsed_toml["tool"]["poetry"]["dependencies"]
        dev_dependencies = parsed_toml["tool"]["poetry"]["dev-dependencies"]

        # Muodosta Project-olio sen tietojen perusteella
        return Project(name, description, dependencies, dev_dependencies)
