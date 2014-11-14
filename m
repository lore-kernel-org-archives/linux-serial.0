From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] serial: sh-sci: Add device tree support for r7s72100
Date: Fri, 14 Nov 2014 16:59:32 +0100
Message-ID: <1415980772-13287-2-git-send-email-geert+renesas@glider.be>
References: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:44061 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965574AbaKNP7u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 10:59:50 -0500
In-Reply-To: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Simply document the new compat string (and keep the list sorted by SoC).
There appears to be no need for a driver update.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 7b87eb2c66be3131..ae73bb0e9ad9e58b 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -4,8 +4,7 @@ Required properties:
 
   - compatible: Must contain one of the following:
 
-    - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
-    - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
+    - "renesas,scif-r7s72100" for R7S72100 (RZ/A1H) SCIF compatible UART.
     - "renesas,scifa-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFA compatible UART.
     - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
     - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
@@ -24,6 +23,8 @@ Required properties:
     - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
     - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
     - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
+    - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
+    - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
1.9.1

