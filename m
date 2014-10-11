From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 09/12] serial: sh-sci: use dmaengine_terminate_all() API
Date: Sat, 11 Oct 2014 21:10:37 +0530
Message-ID: <1413042040-28222-9-git-send-email-vinod.koul@intel.com>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The drivers should use dmaengine_terminate_all() API instead of
accessing the device_control which will be deprecated soon

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3081e46..eb17c71 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1403,7 +1403,7 @@ static void work_fn_rx(struct work_struct *work)
 		unsigned long flags;
 		int count;
 
-		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		dmaengine_terminate_all(chan);
 		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
 			sh_desc->partial, sh_desc->cookie);
 
-- 
1.7.0.4
