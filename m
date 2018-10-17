From: "sudheer.v" <open.sudheer@gmail.com>
Subject: [[PATCH] 4/9] Documentation-DTbindings-DMA-controller-of-AST2500
Date: Wed, 17 Oct 2018 09:41:01 +0530
Message-ID: <1539749466-3912-5-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Moese <mmoese@suse.de>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.orglinux
Cc: "sudheer.v" <open.sudheer@gmail.com>, Sudheer V <sudheer.veliseti@aspeedtech.com>, ShivahShankar Shakarnarayan rao <shivahshankar.shankarnarayanrao@aspeedtech.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 .../devicetree/bindings/dma/ast-uart-sdma.txt      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ast-uart-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt b/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
new file mode 100644
index 0000000..e770df2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
@@ -0,0 +1,23 @@
+* Aspeed Direct Memory Access (DMA) Controller for AST25XX
+
+
+* DMA controller
+
+Required properties:
+- compatible : Should be "aspeed,ast-uart-sdma"
+- reg : Should contain SDMA registers location and length
+- interrupts : Should contain SDMA interrupt
+- dma-channels: number of DMA channels in DMA controller
+
+Optional properties:
+
+Example
+                        ast_uart_sdma: uart_sdma@1e79e000 {
+                                compatible = "aspeed,ast-uart-sdma";
+                                reg = <0x1e79e000 0x400>;
+                                interrupts = <50>;
+                                #dma-cells = <1>;
+                                dma-channels = <8>;
+                                status = "disabled";
+                        };
+
-- 
1.9.1
