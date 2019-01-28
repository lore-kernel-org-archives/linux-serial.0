From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH v2 2/2] Serial: Ingenic: Add X1000 suppor for the UART driver.
Date: Mon, 28 Jan 2019 21:57:01 +0800
Message-ID: <1548683821-120924-3-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-serial@vger.kernel.org

Add support for probing the 8250_ingenic driver on the
X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index c3c6406..24ed876 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -6,7 +6,8 @@ Required properties:
   - "ingenic,jz4760-uart",
   - "ingenic,jz4770-uart",
   - "ingenic,jz4775-uart",
-  - "ingenic,jz4780-uart".
+  - "ingenic,jz4780-uart",
+  - "ingenic,x1000-uart".
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
 - clocks : phandles to the module & baud clocks.
-- 
2.7.4
