From: John Crispin <blogic@openwrt.org>
Subject: [PATCH] serial: of_serial: add "ralink,rt2880-uart" to the binding documentation
Date: Thu, 16 Oct 2014 22:43:27 +0200
Message-ID: <1413492207-57324-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:52607
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752925AbaJPUnj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 16:43:39 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 Documentation/devicetree/bindings/serial/of-serial.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
index 7705477..67a5b3c 100644
--- a/Documentation/devicetree/bindings/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/serial/of-serial.txt
@@ -10,6 +10,7 @@ Required properties:
 	- "ns16850"
 	- "nvidia,tegra20-uart"
 	- "nxp,lpc3220-uart"
+	- "ralink,rt2880-uart"
 	- "ibm,qpace-nwp-serial"
 	- "altr,16550-FIFO32"
 	- "altr,16550-FIFO64"
-- 
1.7.10.4

