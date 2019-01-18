From: Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v10 0/3] add uart DMA function
Date: Fri, 18 Jan 2019 11:10:13 +0800
Message-ID: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Zhenbao Liu <zhenbao.liu@mediatek.com>, devicetree@vger.kernel.org, YT Shen <yt.shen@mediatek.com>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma/mediatek.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DMA

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

Long Cheng (3):
  dmaengine: 8250_mtk_dma: add MediaTek uart DMA support
  arm: dts: mt2712: add uart APDMA to device tree
  dt-bindings: dma: uart: rename binding

 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 -
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   33 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   51 ++
 drivers/dma/mediatek/Kconfig                       |   11 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-uart-apdma.c              |  669 ++++++++++++++++++++
 6 files changed, 765 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-uart-apdma.c

-- 
1.7.9.5
