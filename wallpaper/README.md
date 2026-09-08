# wallpaper

The wallpaper image itself isn't committed to this repo (binary art asset).
Fetch it with:

```
sh wallpaper/download.sh
```

This downloads Michelangelo's *The Creation of Adam* (public domain, Sistine
Chapel ceiling, ~1512) from Wikimedia Commons as `wallpaper/creation-of-adam.jpg`.

Source: https://commons.wikimedia.org/wiki/File:The_Creation_of_Adam_by_Michelangelo.JPG

For the black-and-white minimal look referenced in the i3 config, desaturate it:

```
convert wallpaper/creation-of-adam.jpg -colorspace Gray wallpaper/creation-of-adam.jpg
```

(`convert` is from ImageMagick: `sudo xbps-install -S ImageMagick`)
