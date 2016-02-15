From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 2/3] serial: xuartps: Enable OF earlycon support
Date: Mon, 15 Feb 2016 17:05:18 +0100
Message-ID: <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
In-Reply-To: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, monstr@monstr.eu, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Support early console setup via DT for all listed compatible strings.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 009e0dbc12d2..6f5657766815 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1094,6 +1094,9 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 EARLYCON_DECLARE(cdns, cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns_a, "xlnx,xuartps", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns_b, "cdns,uart-r1p8", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns_c, "cdns,uart-r1p12", cdns_early_console_setup);
 
 /**
  * cdns_uart_console_write - perform write operation
-- 
1.9.1
