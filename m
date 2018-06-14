From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 0/7] add virt-dma support for imx-sdma
Date: Thu, 14 Jun 2018 22:02:55 +0800
Message-ID: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Change from v3:
  1. add two uart patches which impacted by this patchset.
  2. unlock 'vc.lock' before cyclic dma callback and lock again after
     it because some driver such as uart will call dmaengine_tx_status
     which will acquire 'vc.lock' again and dead lock comes out.
  3. remove 'Revert commit' stuff since that patch is not wrong and
     combine two patch into one patch as Sascha's comment.

Change from v2:
  1. include Sascha's patch to make the main patch easier to review.
     Thanks Sacha.
  2. remove useless 'desc'/'chan' in struct sdma_channe.

Change from v1:
  1. split v1 patch into 5 patches.
  2. remove some unnecessary condition check.
  3. remove unnecessary 'pending' list.

Robin Gong (6):
  tty: serial: imx: correct dma cookie status
  dmaengine: imx-sdma: add virt-dma support
  dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
    sdma_channel'
  dmaengine: imx-sdma: remove the maximum limitation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
  tty: serial: imx: split all dma setup operations out of 'port.lock'
    protector

Sascha Hauer (1):
  dmaengine: imx-sdma: factor out a struct sdma_desc from struct
    sdma_channel

 drivers/dma/Kconfig      |   1 +
 drivers/dma/imx-sdma.c   | 394 +++++++++++++++++++++++++++--------------------
 drivers/tty/serial/imx.c |  99 ++++++------
 3 files changed, 282 insertions(+), 212 deletions(-)

-- 
2.7.4
