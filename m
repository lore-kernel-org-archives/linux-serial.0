From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] dmaengine: urgent fix to prevent regression in UART
Date: Wed,  4 May 2016 22:29:38 +0300
Message-ID: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

There are two patches, first of which is an urgent fix to prevent a regression
when UART driver can't acquire DMA channel due to DMA engine which doesn't
support DMA_CYCLIC.

Andy Shevchenko (2):
  dmaengine: slave means at least one of DMA_SLAVE, DMA_CYCLIC
  dmaengine: rename cmd_pause to cmd_suspend

 drivers/dma/dmaengine.c               | 8 ++++----
 drivers/tty/serial/8250/8250_dma.c    | 2 +-
 include/linux/dmaengine.h             | 4 ++--
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.8.1
