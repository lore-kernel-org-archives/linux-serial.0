From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v2 0/4] add uart DMA function
Date: Wed, 5 Dec 2018 16:42:56 +0800
Message-ID: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, Long Cheng <long.cheng@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DM

Changes compared to v1:
-mian revised file, 8250_mtk_dma.c
--parameters renamed for standard
--remove atomic operation

Long Cheng (4):
  dt-bindings: dma: uart: add uart dma bindings
  dmaengine: mtk_uart_dma: add Mediatek uart DMA support
  serial: 8250-mtk: add uart DMA support
  arm: dts: mt2701: add uart APDMA to device tree

 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   50 ++
 drivers/dma/mediatek/8250_mtk_dma.c                |  894 ++++++++++++++++++++
 drivers/dma/mediatek/Kconfig                       |   11 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/tty/serial/8250/8250_mtk.c                 |  210 ++++-
 6 files changed, 1198 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 drivers/dma/mediatek/8250_mtk_dma.c
