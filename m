From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2] serial: xuartps: Enable OF earlycon support
Date: Thu, 18 Feb 2016 08:57:20 +0100
Message-ID: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, peter@hurleysoftware.com
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, monstr@monstr.eu, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Support early console setup via DT for all listed compatible strings.
Remove EARLYCON_DECLARE which was done by:
"Use common framework for earlycon declarations"
(sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
when OF_EARLYCON_DECLARE is defined.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Separate serial patch from others
- Remove EARLYCON_DECLARE and use the same earlycon name with different
  compatible string as was pointed by Peter Hurley
- Extend commit message

 drivers/tty/serial/xilinx_uartps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 131a3117fbbb..cd46e64c4255 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1077,7 +1077,9 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 
 	return 0;
 }
-EARLYCON_DECLARE(cdns, cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "xlnx,xuartps", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);
 
 /**
  * cdns_uart_console_write - perform write operation
-- 
1.9.1
