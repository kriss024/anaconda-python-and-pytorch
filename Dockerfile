FROM continuumio/anaconda3:latest

LABEL maintainer="Krzysztof Bruszewski <krzysztof.bruszewski@gmail.com>"

# Installing packages for operating system
RUN apt update -y \
&& apt -y install build-essential \
&& apt -y install graphviz \
&& apt -y install ffmpeg libsm6 libxext6

# Updating Anaconda packages
RUN conda update conda -y \
&& conda update anaconda -y \
&& conda update --all -y \
&& python -m pip install --upgrade pip

# Installing additional libraries
RUN pip install psycopg2-binary \
&& pip install --upgrade gensim \
&& pip install eli5

RUN conda install -y -c conda-forge dill \
&& conda install -y -c conda-forge python-graphviz \
&& conda install -y -c conda-forge shap \
&& conda install -y -c conda-forge imbalanced-learn=0.5.0 \
&& conda install -y -c conda-forge category_encoders \
&& conda install -y -c conda-forge pingouin \
&& conda install -y -c conda-forge tabulate \
&& conda install -y -c conda-forge pydotplus \
&& conda install -y -c conda-forge pillow \
&& conda install -y -c conda-forge opencv \
&& conda install -y -c conda-forge jellyfish \
&& conda install -y -c conda-forge spacy \
&& conda install -y -c conda-forge pyod \
&& conda install -y -c conda-forge plotly \
&& conda install -y -c conda-forge py-xgboost \
&& conda install -y -c conda-forge lightgbm \
&& conda install -y -c conda-forge theano \
&& conda install -y -c conda-forge geopy \
&& conda install -y -c conda-forge catboost \
&& conda install -y -c anaconda joblib \
&& conda install -y pytorch torchvision torchaudio cpuonly -c pytorch

# Installing extensions for Jupyter Notebooks
RUN pip install jupyter_contrib_nbextensions \
&& jupyter contrib nbextension install --system \
&& pip install jupyter_nbextensions_configurator \
&& jupyter nbextensions_configurator enable --system \
&& jupyter nbextension enable hinterland/hinterland \
&& pip install yapf \
&& pip install nbconvert==5.6.1

# Creating a directory for Jupyter Notebooks
RUN mkdir -p /home/notebooks

# Setting working directory
WORKDIR /home/notebooks

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupyter Notebooks
CMD jupyter notebook --notebook-dir=/home/notebooks --ip='*' --port 8888 --no-browser --allow-root