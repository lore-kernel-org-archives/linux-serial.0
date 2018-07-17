From: Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v5 0/11] Add basic SoC support for mt6765
Date: Tue, 17 Jul 2018 16:52:21 +0800
Message-ID: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds basic SoC support for Mediatek's new 8-core SoC,
MT6765, which is mainly for smartphone application.

Changes in V5:
1. add clk support

Changes in V4:
1. add gic's settings in reg properties
2. remove some patches about dt-bindings since GKH already took them

Changes in V3:
1. split dt-binding document patchs
2. fix mt6765.dtsi warnings with W=12
3. remove uncessary PPI affinity for timer
4. add gicc base for gic dt node

Changes in V2:
1. fix clk properties in uart dts node
2. fix typo in submit title
3. add simple-bus in mt6765.dtsi
4. use correct SPDX license format

Mars Cheng (7):
  dt-bindings: clock: mediatek: document clk bindings for Mediatek
    MT6765 SoC
  dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
  dt-bindings: mediatek: add MT6765 power dt-bindings
  soc: mediatek: add MT6765 scpsys support
  clk: mediatek: add mt6765 clock IDs
  soc: mediatek: add MT6765 subdomain support
  arm64: dts: mediatek: add mt6765 support

Owen Chen (4):
  soc: mediatek: add new flow for mtcmos power.
  clk: mediatek: fix pll setting
  clk: mediatek: add new clkmux register API
  clk: mediatek: Add MT6765 clock support

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |   1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |  27 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |   1 +
 .../bindings/arm/mediatek/mediatek,mipi0a.txt      |  23 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |   1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |   1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |   1 +
 .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |  22 +
 .../memory-controllers/mediatek,smi-common.txt     |   1 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   6 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt6765-evb.dts        |  33 +
 arch/arm64/boot/dts/mediatek/mt6765.dtsi           | 253 ++++++
 drivers/clk/mediatek/Kconfig                       |  87 ++
 drivers/clk/mediatek/Makefile                      |   9 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            | 109 +++
 drivers/clk/mediatek/clk-mt6765-cam.c              |  83 ++
 drivers/clk/mediatek/clk-mt6765-img.c              |  79 ++
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |  77 ++
 drivers/clk/mediatek/clk-mt6765-mm.c               | 105 +++
drivers/clk/mediatek/clk-mt6765-vcodec.c           |  79 ++
 drivers/clk/mediatek/clk-mt6765.c                  | 963 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |  41 +
 drivers/clk/mediatek/clk-mtk.h                     |  87 +-
 drivers/clk/mediatek/clk-mux.c                     | 236 +++++
 drivers/clk/mediatek/clk-mux.h                     |  38 +
 drivers/clk/mediatek/clk-pll.c                     |  45 +-
 drivers/soc/mediatek/Makefile                      |   2 +-
 drivers/soc/mediatek/mtk-infracfg.c                | 178 +++-
 drivers/soc/mediatek/mtk-scpsys-ext.c              | 535 ++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  | 235 ++++-
 include/dt-bindings/clock/mt6765-clk.h             | 313 +++++++
 include/dt-bindings/power/mt6765-power.h           |  14 +
 include/linux/soc/mediatek/infracfg.h              |   9 +-
 include/linux/soc/mediatek/scpsys-ext.h            |  66 ++
 37 files changed, 3681 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
 create mode 100644 drivers/clk/mediatek/clk-mt6765-audio.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-mipi0a.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765.c
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/dt-bindings/clock/mt6765-clk.h
 create mode 100644 include/dt-bindings/power/mt6765-power.h
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
