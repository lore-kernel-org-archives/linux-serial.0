From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 0/2] serial: samsung: fix DMA for small FIFO sizes
Date: Fri, 31 Jul 2015 10:58:26 +0200
Message-ID: <1438333108-25822-1-git-send-email-r.baldyga@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, kmpark@infradead.org, stable@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>
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

Changelog:

v2:
- Add CC to stable
- Add Reported-by: Krzysztof Kozlowski
- Change title of the first patch to more relevant

v1: http://permalink.gmane.org/gmane.linux.kernel/2008281

Marek Szyprowski (1):
  serial: samsung: fix DMA mode enter condition for small FIFO sizes

Robert Baldyga (1):
  serial: samsung: fix DMA for FIFO smaller than cache line size

 drivers/tty/serial/samsung.c | 47 +++++++++++++++++++++++++++++---------------
 drivers/tty/serial/samsung.h |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)

-- 
1.9.1
