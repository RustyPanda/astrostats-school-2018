FROM continuumio/anaconda3

RUN apt-get update
RUN apt-get install -y r-base r-base-dev

RUN conda update -n base conda
#RUN conda install -c r r

ADD requirements.txt .
RUN conda install --yes --file requirements.txt

RUN mkdir notebooks
#VOLUME notebooks

# Magic to make jupyter run properly
# See https://towardsdatascience.com/docker-for-data-science-9c0ce73e8263

# Configuring access to Jupyter
RUN jupyter notebook --generate-config --allow-root
#RUN echo "c.NotebookApp.password = docker >> /root/.jupyter/jupyter_notebook_config.py

ADD start.sh .
RUN ["chmod", "+x", "start.sh"]

# See https://github.com/matplotlib/matplotlib/issues/8929
# matplotlib config (used by benchmark)
RUN mkdir -p /root/.config/matplotlib
RUN echo "backend : Agg" > /root/.config/matplotlib/matplotlibrc

EXPOSE 8888

# Run Jupyter notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--ip='*'", "--port=8888", "--no-browser", "--notebook-dir=notebooks"]