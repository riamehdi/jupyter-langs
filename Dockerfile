FROM buildpack-deps:stretch

MAINTAINER HeRoMo

ENV NOTEBOOK_DIR=/notebooks \
    JUPYTER_DIR=/opt/juypter

RUN apt-get update && \
    apt-get install -y --no-install-recommends
RUN wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh && \
    chmod 755 ./Anaconda3-4.4.0-Linux-x86_64.sh && \
    ./Anaconda3-4.4.0-Linux-x86_64.sh -b
ENV PATH=/root/anaconda3/bin:$PATH
RUN conda install -y jupyter notebook pandas bokeh matplotlib && \
    conda install -y -c conda-forge jupyterlab
RUN wget https://github.com/adobe-fonts/source-han-code-jp/archive/2.000R.tar.gz && \
    tar -xzf 2.000R.tar.gz source-han-code-jp-2.000R/OTC/SourceHanCodeJP.ttc && \
    mv source-han-code-jp-2.000R/OTC/SourceHanCodeJP.ttc /usr/share/fonts/truetype/ && \
    fc-cache && \
    rm -rf 2.000R.tar.gz source-han-code-jp-2.000R

RUN mkdir -p $NOTEBOOK_DIR
WORKDIR JUPYTER_DIR
ADD matplotlib ${JUPYTER_DIR}/
EXPOSE 8888
#CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir=/mnt/notebooks"]
CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir=${NOTEBOOK_DIR}"]
