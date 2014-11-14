From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] serial: sh-sci: Add device tree support for r8a7794
Date: Fri, 14 Nov 2014 16:59:31 +0100
Message-ID: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60624 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965288AbaKNP7r (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 10:59:47 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Simply document the new compat string.
There appears to be no need for a driver update.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[geert: Reworded to match previous commits]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index b3556609a06fb8b9..7b87eb2c66be3131 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -20,6 +20,10 @@ Required properties:
     - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
     - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
     - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
+    - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
+    - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
+    - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
1.9.1

