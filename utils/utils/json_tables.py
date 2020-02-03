"""Helper library to convert dictionaries into ascii tables"""
from dataclasses import dataclass
from typing import Dict
from typing import List
import copy


class WordTooLongError(Exception):
    """Raised when a word is too long to fit into the table"""


@dataclass
class Cell:
    """A class to represent a cell in a table"""

    name: str
    width: int = 20


@dataclass
class Table:
    """Dataclass to represent a table"""

    cells: List[Cell]
    data: List[Dict]
    top_border: str = "-"
    title_border: str = "="
    row_border: str = "-"
    bottom_border: str = "-"
    middle_separator: str = "|"
    outer_separator: str = "|"
    intersection_point: str = "+"

    def as_ascii(self) -> str:
        """Return the table data as an ascii string"""
        return_str = ""
        return_str += self.print_row_border(self.top_border)
        return_str += self.print_row({cell.name: cell.name for cell in self.cells})
        return_str += self.print_row_border(self.title_border)
        for row in self.data:
            return_str += self.print_row(row)
            return_str += self.print_row_border(self.row_border)
        return return_str

    def print_row_border(self, separator: str):
        """Prints a horizontal border"""
        format_string = f"{self.intersection_point}".join(
            [f"{separator * (cell.width)}" for index, cell in enumerate(self.cells)]
        )
        return f"{self.intersection_point}{format_string}{self.intersection_point}\n"

    @classmethod
    def pop_words(cls, cell: Cell, row_data: List) -> str:
        """Smartly split row data so that it fits in a cell"""
        return_str = ""
        if row_data and len(row_data[0]) > cell.width - 2:
            raise WordTooLongError(row_data[0])
        while len(return_str) < cell.width:
            if row_data and len(return_str + row_data[0]) + 1 < cell.width:
                return_str += f" {row_data.pop(0)}"
            else:
                break
        return return_str

    def print_row(self, row: Dict) -> str:
        """Prints a single row in the table"""
        row_words = {key: val.split() for key, val in row.items()}
        return_str = ""
        format_string = f"{self.middle_separator}".join(
            [f"{{{index}: <{cell.width}}}" for index, cell in enumerate(self.cells)]
        )
        while any(row_words.values()):
            strs = [self.pop_words(cell, row_words[cell.name]) for cell in self.cells]
            return_str += f"{self.outer_separator}{format_string.format(*strs)}{self.outer_separator}\n"
        return return_str

    @classmethod
    def from_dict(cls, rows: List[Dict]):
        """Load in a message from the dict"""
        all_keys: List = []
        # thonking emoji
        for row in rows:
            for key in row.keys():
                if key not in all_keys:
                    all_keys.append(key)
        data = copy.deepcopy(rows)
        cells = [Cell(name=key) for key in all_keys]
        return cls(data=data, cells=cells)
