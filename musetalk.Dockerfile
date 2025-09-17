FROM ghcr.io/hawkli-1994/corex-musetalk:main as REPO
FROM corex:4.3.0


WORKDIR /app

# conda
RUN apt-get update && apt-get install -y wget bzip2 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py310_24.7.1-0-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    chmod +x /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:$PATH"


# RUN conda install -y tensorflow==2.12.0 tensorboard==2.12.0 opencv-python=4.9.0.80 librosa==0.11.0
COPY --from=REPO /app/* /app/
# COPY --from=REPO /app/corex/accelerate-0.34.2+corex.4.3.0-py3-none-any.whl /app/accelerate-0.34.2+corex.4.3.0-py3-none-any.whl
# COPY --from=REPO /app/corex/opencv-4.6.0-corex.4.3.0-linux_x86_64.tgz /app/opencv-4.6.0-corex.4.3.0-linux_x86_64.tgz
# COPY --from=REPO /app/corex/tensorflow-2.16.2+corex.4.3.0-cp310-cp310-linux_x86_64.whl /app/tensorflow-2.16.2+corex.4.3.0-cp310-cp310-linux_x86_64.whl

# tar 解压opencv-4.6.0-corex.4.3.0-linux_x86_64.tgz 到/app目录下，然后把bin目录加入到PATH
RUN tar -zxvf /app/corex/opencv-4.6.0-corex.4.3.0-linux_x86_64.tgz -C /app && \
    export PATH=$PATH:/app/opencv-4.6.0-corex.4.3.0-linux_x86_64/bin 

# 删除无用的文件

RUN pip install accelerate-0.34.2+corex.4.3.0-py3-none-any.whl
RUN pip install tensorflow-2.16.2+corex.4.3.0-cp310-cp310-linux_x86_64.whl


RUN pip install --upgrade pip
RUN pip install -r corex_requirements.txt --upgrade --upgrade-strategy only-if-needed --no-deps  


RUN rm -rf /app/corex
RUN rm *.tgz *.whl
RUN sh ./download_weights.sh
