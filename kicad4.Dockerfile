# requires running 'xhost +', reset after use with 'xhost -'
# docker run -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/developer/.Xauthority --net=host --mount type=bind,source=`pwd`/git,target=/git registry.gitlab.com/juravenator/nixiepowersupply/kicad4:master-latest

FROM productize/kicad:4.0.7-18.04

RUN apt update && \
    apt install -y git curl && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/KiCad/kicad-library.git && \
    cd kicad-library/ && \
    cp -r library /usr/share/kicad && \
    cp -r modules /usr/share/kicad && \
    cd .. && \
    rm -rf kicad-library && \
    cd /usr/share/kicad/library/ && \
    ln -s Transistor.lib transistors.lib && \
    ln -s Connector.lib conn.lib && \
    ln -s Logic_74xx.lib 74xx.lib && \
    ln -s Logic_CMOS_4000.lib cmos4000.lib && \
    ln -s Display.lib display.lib && \
    ln -s Valve.lib valves.lib && \
    cd /root && \
    curl -O https://gist.githubusercontent.com/arturo182/a8c4a4b96907cfccf616a1edb59d0389/raw/2c9191c0f1fe5471db3362ccf29f71d3235af4d4/bom2grouped_csv_jlcpcb.xsl

CMD ["kicad"]
