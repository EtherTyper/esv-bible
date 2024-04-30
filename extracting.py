import tarfile

with tarfile.open('./esv-bible.tar.gz') as f:
    print(f.extractfile('Jude/Jude.html').read().decode("utf-8"))
