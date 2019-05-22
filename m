From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/6] dt-bindings: serial: 8250_omap: Add compatible for J721E UART controller
Date: Wed, 22 May 2019 11:19:17 -0500
Message-ID: <20190522161921.20750-3-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-serial@vger.kernel.org

J721e uses a UART controller that is compatible with AM654 UART.
Introduce a specific compatible to help handle the differences if
necessary.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
NOTE:
 - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
   else, I can spawn it off the series into it's own patch, but it
   seemed better in a logical order.

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 0a9b5444f4e6..dcba86b0a0d0 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -1,6 +1,7 @@
 OMAP UART controller
 
 Required properties:
+- compatible : should be "ti,j721e-uart", "ti,am654-uart" for J721E controllers
 - compatible : should be "ti,am654-uart" for AM654 controllers
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
-- 
2.21.0.777.g83232e38648b
