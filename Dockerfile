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
#RUN ln -sf /opt/conda/envs/sci/bin/python3.9 /opt/conda/bin/python

COPY scripts /scripts
COPY sci /sci
RUN chmod +x /scripts*

ENV PATH /sci:$PATH
ENV PATH /scripts:$PATH

WORKDIR /sci

ENTRYPOINT ["/opt/conda/envs/sci/bin/python2.7", "-m", "sci"]
