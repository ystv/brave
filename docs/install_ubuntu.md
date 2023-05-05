# Installing on Ubuntu
This is instructions on how to install [Brave](../README.md), and its dependencies, on Ubuntu.

## Ubuntu version
You must use at least version 18.10, to access a recent version of GStreamer (1.14.3 or later) via Apt.

## STEP 1: Dependencies
Use `apt-get` to install the bulk of the dependencies:

```
sudo apt-get update
sudo apt-get install -y \
    gcc \
    gir1.2-gst-plugins-bad-1.0 \
    git \
    gobject-introspection \
    gstreamer1.0-libav \
    gstreamer1.0-nice \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools \
    libcairo2-dev \
    libgirepository1.0-dev \
    pkg-config \
    python-gst-1.0 \
    python3-dev \
    python3-pip
```

## STEP 2: Gstreamer dependencies

To use hardware acceleration we need to add the `nvenc` and `nvdec` plugins. Follow this [guide](https://lifestyletransfer.com/how-to-install-nvidia-gstreamer-plugins-nvenc-nvdec-on-ubuntu/) to install it.

## STEP 3: Python dependencies
Brave uses [Pyenv](https://github.com/pyenv/pyenv) and [Pipenv](https://packaging.python.org/tutorials/managing-dependencies/#managing-dependencies) to manage and isolate Python and its dependencies.

Install with:

```
curl https://pyenv.run | bash
pyenv install python 3.8.10
pyenv global 3.8.10
pip3 install -Iv pipenv==2022.4.8
export PATH="${HOME}/.local/bin:$PATH"
pipenv install --ignore-pipfile
```

If you're having difficulties, try this reference: https://xkcd.com/1987/. Gotta love Python.


## STEP 4: Installing Brave
Simply clone Brave from GitHub, and try running it:

```
git clone https://github.com/bbc/brave.git
cd brave
pipenv install
pipenv run ./brave.py
```

That's it!

## Optional: Support fort AWS Kinesis Video

If you wish to output to a Kinesis Video Stream, there are [separate instructions](./install_kvs.md) on installing the necessary GStreamer element.
