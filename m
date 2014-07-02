From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7778
Date: Wed,  2 Jul 2014 06:19:06 +0200
Message-ID: <1404274746-26098-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Simply document a new compat string.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 64fd7de..8a50a2e 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -4,6 +4,7 @@ Required properties:
 
   - compatible: Must contain one of the following:
 
+    - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
-- 
2.0.0.rc2

