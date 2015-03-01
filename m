From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] serial: core: Fix iotype userspace breakage
Date: Sun,  1 Mar 2015 10:18:16 -0500
Message-ID: <1425223096-17635-1-git-send-email-peter@hurleysoftware.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Kevin Cernekee <cernekee@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

commit 3ffb1a8193bea ("serial: core: Add big-endian iotype")
re-numbered userspace-dependent values; ioctl(TIOCSSERIAL) can
assign the port iotype (which is expected to match the selected
i/o accessors), so iotype values must not be changed.

Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: <stable@vger.kernel.org> # 3.19+
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/serial_core.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a3fd182..85fdd89 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -147,9 +147,9 @@ struct uart_port {
 #define UPIO_HUB6		(1)			/* Hub6 ISA card */
 #define UPIO_MEM		(2)			/* 8b MMIO access */
 #define UPIO_MEM32		(3)			/* 32b little endian */
-#define UPIO_MEM32BE		(4)			/* 32b big endian */
-#define UPIO_AU			(5)			/* Au1x00 and RT288x type IO */
-#define UPIO_TSI		(6)			/* Tsi108/109 type IO */
+#define UPIO_AU			(4)			/* Au1x00 and RT288x type IO */
+#define UPIO_TSI		(5)			/* Tsi108/109 type IO */
+#define UPIO_MEM32BE		(6)			/* 32b big endian */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
-- 
2.3.0
