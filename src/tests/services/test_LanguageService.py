# Services
from src.services.LanguageService import LanguageService


def test_get_languages_not_none():
    languages = LanguageService.get_languages()
    assert languages != None


def test_get_languages_has_elements():
    languages = LanguageService.get_languages()
    assert len(languages) > 0


def test_get_languages_check_elements_length():
    languages = LanguageService.get_languages()
    for language in languages:
        assert len(language) > 0
