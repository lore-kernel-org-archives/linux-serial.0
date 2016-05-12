From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3/3] tty: serial: msm: Cleanup include usage
Date: Wed, 11 May 2016 18:02:28 -0700
Message-ID: <20160512010228.21548-4-sboyd@codeaurora.org>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160512010228.21548-1-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

The hrtimer include isn't used and neither is serial. Drop those
ones. The irq.h header really should be interrupt.h because this
is an interrupt user and not an interrupt chip. Finally add
wait.h for the wake_up*() usage in this driver and kernel.h for
container_of().

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index a051dc5def24..88af5a3d21dd 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -19,26 +19,26 @@
 # define SUPPORT_SYSRQ
 #endif
 
+#include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
-#include <linux/serial.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/wait.h>
 
 #define UART_MR1			0x0000
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
