From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 4/4] serial: sh-sci: add r8a7778/9 HSCIF DT bindings
Date: Wed, 16 Mar 2016 18:10:10 +0100
Message-ID: <1458148210-21800-5-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 528c3b9..61d6adc 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -10,7 +10,9 @@ Required properties:
     - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
     - "renesas,scifb-r8a7740" for R8A7740 (R-Mobile A1) SCIFB compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
+    - "renesas,hscif-r8a7778" for R8A7778 (R-Car M1) HSCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
+    - "renesas,hscif-r8a7779" for R8A7779 (R-Car H1) HSCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
     - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
-- 
2.6.4
