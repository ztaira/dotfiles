from utils.json_tables import Table

def test_table():
    """main"""
    entries = [
        {
            "name": "Have you heard the tragedy of Darth Plagueis the wise?",
            "description": "Darth Plagueis was a Dark Lord of the Sith so powerful and so wise, he could use the Force to influence the midi-chlorians to create life. He had such a knowledge of the dark side, he could even keep the ones he cared about from dying.",
            "notes": "Lorem ipsum is boring",
        },
        {
            "name": "I have the high ground",
            "description": "And I feel not just a sense of accomplishment, but accomplishwoment and accomplishchildrent too",
            "notes": "These aren't the memes you're looking for",
        },
    ]

    table = Table.from_dict(entries)
    table.cells[1].width = 40

    with open("tests/reference_jt.txt", "r") as readfile:
        assert table.as_ascii() == readfile.read()

    with open("tests/reference_jt.txt", "w") as writefile:
        writefile.write(table.as_ascii())

if __name__ == "__main__":
    test_table()
