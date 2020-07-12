FROM lambci/lambda:build-python3.6

ENV VIRTUAL_ENV=venv
ENV PATH $VIRTUAL_ENV/bin:$PATH
RUN python3 -m venv $VIRTUAL_ENV

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

WORKDIR /var/task/venv/lib/python3.6/site-packages
RUN echo "Initial unzipped size: $(du -sh . | cut -f1)"

RUN python3 -O -m compileall -b .
RUN find . -name '*.py' | xargs rm
RUN find . -name '__pycache__' | xargs rm -r
RUN echo "After precompiling .py files, unzipped size: $(du -sh . | cut -f1)"

RUN pip install  --verbose pytest

COPY api api
COPY fn fn
COPY tests fn/tests
RUN python3 -O -m compileall -b .

RUN find . -type f -exec touch -at 0711171532 '{}' '+' && \
    touch -at 0711171533 /tmp/since && \
    PYTHONPATH=$PWD:$PYTHONPATH pytest -v fn/tests && \
    /var/task/venv/bin/python3 ./api/index.py && \
    find fn -type f -exec touch '{}' '+' && \
    find . -type f -not -anewer /tmp/since -print -delete

RUN /var/task/venv/bin/python3 ./api/index.py
RUN pip uninstall -y pytest && rm -r ./fn/tests

# COPY now.json .

RUN echo "Unzipped size: $(du -sh . | cut -f1)"
RUN zip -9qr lambda.zip *
RUN echo "Zipped file size: $(du -mh lambda.zip | cut -f1)"

