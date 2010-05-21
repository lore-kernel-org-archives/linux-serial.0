From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4] serial: add a new port type, found on some sh-mobile
 SoCs
Date: Fri, 21 May 2010 17:49:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005211733430.8450@axis700.grange>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Such ports are found, e.g., on SH7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/serial_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 78dd1e7..5b0fbb2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -182,6 +182,9 @@
 /* Aeroflex Gaisler GRLIB APBUART */
 #define PORT_APBUART    90
 
+/* SH-SCI */
+#define PORT_SCIFB	91
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
-- 
1.6.2.4

