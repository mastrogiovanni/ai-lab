FROM 691684840569.dkr.ecr.eu-west-2.amazonaws.com/elerian/torch-cuda-11.3.0:1.0.0-prod

RUN conda install -y -c conda-forge numba==0.57.1

RUN pip install transformers
RUN pip install matplotlib
RUN pip install tiktoken

# Notebook
RUN pip install notebook
RUN pip install ipywidgets

EXPOSE 8888

WORKDIR /app

CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--allow-root", "--no-browser"]



