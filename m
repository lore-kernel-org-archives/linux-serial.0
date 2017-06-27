From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
Date: Tue, 27 Jun 2017 02:55:18 +0200
Message-ID: <20170627005520.23731-5-afaerber@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170627005520.23731-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, service@rdamicro.com, zhao_steven@263.net, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add an initial binding for the RDA8810PL UART.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
new file mode 100644
index 000000000000..6840a8aee035
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
@@ -0,0 +1,13 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL
+- reg        :  Offset and length of the register set for the device.
+
+
+Example:
+
+		uart3: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+		};
-- 
2.12.3
