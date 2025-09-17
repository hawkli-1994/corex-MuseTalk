FROM scratch

WORKDIR /app
COPY . /app/musetalk

COPY corex/accelerate-0.34.2+corex.4.3.0-py3-none-any.whl /app/accelerate-0.34.2+corex.4.3.0-py3-none-any.whl
COPY corex/opencv-4.6.0-corex.4.3.0-linux_x86_64.tgz /app/opencv-4.6.0-corex.4.3.0-linux_x86_64.tgz
COPY corex/tensorflow-2.16.2+corex.4.3.0-cp310-cp310-linux_x86_64.whl /app/tensorflow-2.16.2+corex.4.3.0-cp310-cp310-linux_x86_64.whl