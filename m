From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 repost] serial: sh-sci: Add device tree support for
 r8a7{778,740,3a4} and sh73a0
Date: Fri, 11 Jul 2014 11:11:08 +0200
Message-ID: <20140711091107.GA25710@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--
v2
* Added r8a73a4, r8a7740 and sh73a0 support

Repost to Greg KH.

Greg, I am hoping to get the platform side of this change included in v3.16.
As there are no code changes I think it should be safe enough. But I am
wondering if you could either merge this patch or give an Ack so that I'm
not using bindings in dts files that have not been accepted by the driver
maintainer.

---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 64fd7de..b355660 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -4,6 +4,13 @@ Required properties:
 
   - compatible: Must contain one of the following:
 
+    - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
+    - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
+    - "renesas,scifa-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFA compatible UART.
+    - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
+    - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
+    - "renesas,scifb-r8a7740" for R8A7740 (R-Mobile A1) SCIFB compatible UART.
+    - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
-- 
2.0.0.rc2

