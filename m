From: Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] dt-bindings: serial: Move renesas,rzn1-uart into the snps-dw-apb-uart binding
Date: Thu, 10 Jan 2019 16:20:17 -0600
Message-ID: <20190110222017.6390-2-robh@kernel.org>
References: <20190110222017.6390-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110222017.6390-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The renesas,rzn1-uart binding only differs in compatible string from the
snps-dw-apb-uart binding. Move it there, converting it to json-schema in
the process.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/renesas,rzn1-uart.txt   | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt b/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
deleted file mode 100644
index 8b9e0d4dc2e4..000000000000
--- a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Renesas RZ/N1 UART
-
-This controller is based on the Synopsys DesignWare ABP UART and inherits all
-properties defined in snps-dw-apb-uart.txt except for the compatible property.
-
-Required properties:
-- compatible : The device specific string followed by the generic RZ/N1 string.
-   Therefore it must be one of:
-   "renesas,r9a06g032-uart", "renesas,rzn1-uart"
-   "renesas,r9a06g033-uart", "renesas,rzn1-uart"
-- 
2.19.1
