from os import listdir
from sys import argv
from PIL import Image

path = str(argv[1]).replace("/", "//")

imagelist= listdir(path)
for fichier in imagelist[:]: 
    if not(fichier.endswith(".jpg")):
        imagelist.remove(fichier)

imagelist.sort()

initialImage = Image.open(path + imagelist[0]).convert('RGB')

convertedImages = []
imagelist.pop(0)
for image in imagelist:
    convertedImages.append(Image.open(path + image).convert('RGB'))

initialImage.save(path + "PdfCap.pdf", "PDF", resolution=100.0, save_all=True, append_images=convertedImages)