From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v12 0/4] add uart DMA function
Date: Sat, 27 Apr 2019 11:36:29 +0800
Message-ID: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>, Long Cheng <long.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma/mediatek.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DMA

Changes compared to v11
-modify TX/RX
-pause function by software
Changes compared to v10
-modify DMA tx status function
-modify 8250_mtk for DMA rx
-add notes to binding Document.
Changes compared to v9
-rename dt-bindings file
-remove direction from device_config
-simplified code
Changes compared to v8
-revise missing items
Changes compared to v7:
-modify apdma uart tx
Changes compared to v6:
-Correct spelling
Changes compared to v5:
-move 'requst irqs' to alloc channel
-remove tasklet.
Changes compared to v4:
-modify Kconfig depends on.
Changes compared to v3:
-fix CONFIG_PM, will cause build fail
Changes compared to v2:
-remove unimportant parameters
-instead of cookie, use APIs of virtual channel.
-use of_dma_xlate_by_chan_id.
Changes compared to v1:
-mian revised file, 8250_mtk_dma.c
--parameters renamed for standard
--remove atomic operation

Long Cheng (4):
  dmaengine: mediatek: Add MediaTek UART APDMA support
  arm: dts: mt2712: add uart APDMA to device tree
  dt-bindings: dma: uart: rename binding
  serial: 8250-mtk: modify uart DMA rx

 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 -
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   55 ++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   51 ++
 drivers/dma/mediatek/Kconfig                       |   11 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-uart-apdma.c              |  666 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_mtk.c                 |   53 +-
 7 files changed, 807 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-uart-apdma.c

-- 
1.7.9.5
