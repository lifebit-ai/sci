# continuumio/miniconda3:4.8.2
FROM continuumio/miniconda3@sha256:456e3196bf3ffb13fee7c9216db4b18b5e6f4d37090b31df3e0309926e98cfe2

LABEL authors="sangram@lifebit.ai" \
      description="Docker image containing dependencies for TheJacksonLaboratory/sci"

COPY environment.yml /

RUN apt-get update && \
  apt-get install procps -y && \
  conda env create -f /environment.yml && \
  conda clean -a
ENV PATH /opt/conda/envs/sci/bin:$PATH

# install juicer
RUN git clone https://github.com/theaidenlab/juicer.git && \
  cd juicer/ && \
  ln -s CPU scripts && \
  cd scripts/common && \
  wget https://hicfiles.tc4ga.com/public/juicer/juicer_tools.1.9.9_jcuda.0.8.jar && \
  ln -s juicer_tools.1.9.9_jcuda.0.8.jar juicer_tools.jar

ENV JUICERTOOLS /juicer/scripts/common/juicer_tools.jar

# additional scripts
COPY scripts /scripts
RUN chmod +x /scripts*
ENV PATH /scripts:$PATH

COPY sci /sci
ENV PATH /sci:$PATH

WORKDIR /sci
