From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 2/6] serial: uartps: Use octal permission for module_param()
Date: Wed, 12 Jun 2019 13:14:39 +0200
Message-ID: <159139864be4ab81e75f20f7fdad604ce270f8cf.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: johan@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Octal permission is preffered compare to symbolic one.

This patch fixes checkpatch warnings:
Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal
permissions '0444'.

Fixes: 85baf542d54e ("tty: xuartps: support 64 byte FIFO size")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Fixes second S_IRUGO usage
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9dcc4d855ddd..c84db82bdaab 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -35,12 +35,12 @@
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
 static int uartps_major;
-module_param(rx_trigger_level, uint, S_IRUGO);
+module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
 /* Rx Timeout */
 static int rx_timeout = 10;
-module_param(rx_timeout, uint, S_IRUGO);
+module_param(rx_timeout, uint, 0444);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
 /* Register offsets for the UART. */
-- 
2.17.1
