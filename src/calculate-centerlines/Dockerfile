FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
      gdal-bin \
      libgdal-dev \
      python \
      python-pip \
      python-dev \
      python-gdal \
      git \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
      python-scipy \
      python-shapely \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
RUN git clone https://github.com/ungarj/label_centerlines.git /usr/src/app
RUN pip install networkx>=1.11 Fiona>=1.7.0

CMD ["./create_centerlines.py", "--output_driver", "GeoJSON", "/data/osm_lake_polygon.shp", "/data/osm_lake_centerline.geojson"]
