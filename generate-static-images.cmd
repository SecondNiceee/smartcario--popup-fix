if not exist public\images mkdir public\images

for %%F in (
    src-images\*.png src-images\*.jpg
    ) do (
        rem Copy the original file to public\images so the <img> fallback
        rem (e.g. /images/deviceWithCase.png) always resolves. Old browsers that
        rem don't support WebP request this fallback and would 404 otherwise.
        copy /Y "%%F" "public\images\%%~nxF"
        for %%W in (3840) do (
            mkdir public\images\r\%%W
            start /B magick.exe %%F -resize %%Wx -quality 97 -define webp:image-hint=photo -define webp:method=6 -define webp:pass=10 -define webp:auto-filter=true public\images\r\%%W\%%~nF.webp
        )
        for %%W in (1560 1440 1200 1140 1024 768 576 480 360) do (
            mkdir public\images\r\%%W
            magick.exe %%F -resize %%Wx -quality 99 -define webp:image-hint=photo -define webp:method=6 -define webp:pass=10 -define webp:auto-filter=true public\images\r\%%W\%%~nF.webp
        )
)
