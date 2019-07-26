From: "sudheer.v" <open.sudheer@gmail.com>
Subject: [patch v4 4/5] defconfig and MAINTAINERS updated for AST2500 DMA UART driver
Date: Fri, 26 Jul 2019 18:57:19 +0530
Message-ID: <1564147640-30753-5-git-send-email-open.sudheer@gmail.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, sudheer.veliseti@aspeedtech.com
Cc: sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

defconfig changes to add DMA based UART in AST2500
Maintainers File updated.

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes in v4:
- config name changed to CONFIG_SERIAL_AST_DMA_UART as per convention
Changes in v3:
- Added changes logs 

MAINTAINERS                          | 12 ++++++++++++
 arch/arm/configs/aspeed_g5_defconfig |  1 +
 2 files changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997e27ab492f..d814a52ecf99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1347,6 +1347,18 @@ F:	drivers/crypto/axis
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
+ARM/ASPEED DMA UART DRIVER
+M:	sudheer v <sudheer.open@gmail.com>
+R:	Joel Stanley <joel@jms.id.au>
+R:	Andrew Jeffery <andrew@aj.id.au>
+R:	Vinod Koul <vkoul@kernel.org>
+L:	dmaengine@vger.kernel.org
+L:	openbmc@lists.ozlabs.org
+L:	linux-aspeed@lists.ozlabs.org
+S:	Maintained
+F:	drivers/tty/serial/8250/8250_aspeed_uart_dma.c
+F:	Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
+
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 1849cbc161b4..fc17cc9ddc00 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -144,6 +144,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_AST_DMA_UART=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-- 
2.17.1
