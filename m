From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH v2 resend 2/2] dt-bindings: serial: sh-sci: Document r8a774c0 bindings
Date: Wed, 19 Dec 2018 10:06:25 +0000
Message-ID: <1545213985-30341-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1545213985-30341-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545213985-30341-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
HSCIF ports, so document the SoC specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>

---
v1->v2:
* Fixed title according to Geert's comment

 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 21526e8..20232ad 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -26,6 +26,8 @@ Required properties:
     - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
     - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART.
     - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UART.
+    - "renesas,scif-r8a774c0" for R8A774C0 (RZ/G2E) SCIF compatible UART.
+    - "renesas,hscif-r8a774c0" for R8A774C0 (RZ/G2E) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
-- 
2.7.4
