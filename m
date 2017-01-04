From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 1/4] doc: DT: Add ti,da830-uart to serial/8250 bindings
Date: Wed,  4 Jan 2017 14:30:11 -0600
Message-ID: <1483561814-21953-2-git-send-email-david@lechnology.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483561814-21953-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: David Lechner <david@lechnology.com>, Franklin S Cooper Jr <fcooper@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This adds the ti,da830-uart compatible string to serial 8250 UART bindings.

Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Rob Herring <robh@kernel.org>
---

v2 changes:
* picked up Acked-by:

 Documentation/devicetree/bindings/serial/8250.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index f86bb06..10276a4 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -19,6 +19,7 @@ Required properties:
 	- "altr,16550-FIFO128"
 	- "fsl,16550-FIFO64"
 	- "fsl,ns16550"
+	- "ti,da830-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
-- 
2.7.4
