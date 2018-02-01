From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] DT: serial: renesas,sci-serial: document R8A77980 bindings
Date: Thu, 1 Feb 2018 22:36:20 +0300
Message-ID: <2182bb59-d16f-54f0-d992-65b49815ce1d@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Language: en-MW
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

R-Car V3H (R8A77980) SoC has the R-Car gen3 compatible SCIF and HSCIF ports,
so document the SoC specific bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |    2 ++
 1 file changed, 2 insertions(+)

Index: tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
===================================================================
--- tty.orig/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ tty/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -43,6 +43,8 @@ Required properties:
     - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
     - "renesas,scif-r8a77970" for R8A77970 (R-Car V3M) SCIF compatible UART.
     - "renesas,hscif-r8a77970" for R8A77970 (R-Car V3M) HSCIF compatible UART.
+    - "renesas,scif-r8a77980" for R8A77980 (R-Car V3H) SCIF compatible UART.
+    - "renesas,hscif-r8a77980" for R8A77980 (R-Car V3H) HSCIF compatible UART.
     - "renesas,scif-r8a77995" for R8A77995 (R-Car D3) SCIF compatible UART.
     - "renesas,hscif-r8a77995" for R8A77995 (R-Car D3) HSCIF compatible UART.
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
