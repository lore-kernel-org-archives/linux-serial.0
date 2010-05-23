From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4 v2] serial: add a new port type, found on some sh-mobile
 SoCs
Date: Sun, 23 May 2010 18:39:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Such ports are found, e.g., on SH7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

rebased onto the current (sh-2.6/master) HEAD, where two more new port 
types have been registered.

 include/linux/serial_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f10db6e..5228320 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -186,6 +186,9 @@
 #define PORT_ALTERA_JTAGUART	91
 #define PORT_ALTERA_UART	92
 
+/* SH-SCI */
+#define PORT_SCIFB	93
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
-- 
1.6.2.4

