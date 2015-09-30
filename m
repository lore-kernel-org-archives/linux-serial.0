From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Add device tree support for r8a7795
Date: Wed, 30 Sep 2015 11:57:33 +0200
Message-ID: <1443607053-16709-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index e84b13a8eda34a15..73f825e5e6448815 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -23,6 +23,8 @@ Required properties:
     - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
     - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
     - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
+    - "renesas,scif-r8a7795" for R8A7795 (R-Car H3) SCIF compatible UART.
+    - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
-- 
1.9.1

