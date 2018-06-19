From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] dt-bindings: serial: 8250_omap: Add compatible for AM654 UART controller
Date: Tue, 19 Jun 2018 14:44:49 -0500
Message-ID: <20180619194450.6353-2-nm@ti.com>
References: <20180619194450.6353-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619194450.6353-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>, Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-serial@vger.kernel.org

AM654 uses a UART controller that is only partially compatible with
existing 8250 UART. UART DMA integration is substantially different
and even a match against standard 8250 or omap4 would result in
non-working UART once DMA is enabled by default.

Introduce a specific compatible to help build up the differences in
follow on patches.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since RFC:
* DT binding has been split out as it's own patch and commit message elaborated

RFC: https://patchwork.kernel.org/patch/10447641/

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 4b0f05adb228..c35d5ece1156 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -1,6 +1,7 @@
 OMAP UART controller
 
 Required properties:
+- compatible : should be "ti,am654-uart" for AM654 controllers
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
 - compatible : should be "ti,omap4-uart" for OMAP4 controllers
-- 
2.15.1
