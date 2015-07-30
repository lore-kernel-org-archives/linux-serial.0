From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 0/2] serial: samsung: fix DMA for small FIFO sizes
Date: Thu, 30 Jul 2015 11:14:14 +0200
Message-ID: <1438247656-24695-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hello,

This patch set fixes bug causing serial hang in DMA mode for FIFO sizes
smaller than cache alignment. The first patch fixes DMA mode entering
condition to avoid starting with buffer smaller than cache line size.
Second patch fixes the serial hang bug, which was caused by unproper
buffer aligning algorithm which assumed that there is always enough
free space in FIFO for excessive bytes of buffer that is being alligned.

Best regards,
Robert Baldyga

Marek Szyprowski (1):
  serial: samsung: calculate min_dma_size

Robert Baldyga (1):
  serial: samsung: fix DMA for FIFO smaller than cache line size

 drivers/tty/serial/samsung.c | 47 +++++++++++++++++++++++++++++---------------
 drivers/tty/serial/samsung.h |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)

-- 
1.9.1
