From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] serial: 8250_uniphier: add auto-flow-control support
Date: Wed, 19 Sep 2018 14:28:13 +0900
Message-ID: <1537334893-26079-4-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dai Okamura <okamura.dai@socionext.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Dai Okamura <okamura.dai@socionext.com>

Add selective auto-flow-control support for UniPhier serial driver.

Signed-off-by: Dai Okamura <okamura.dai@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/serial/uniphier-uart.txt | 3 +++
 drivers/tty/serial/8250/8250_uniphier.c                    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
index 811c479..7a1bf02 100644
--- a/Documentation/devicetree/bindings/serial/uniphier-uart.txt
+++ b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
@@ -6,6 +6,9 @@ Required properties:
 - interrupts: a single interrupt specifier.
 - clocks: phandle to the input clock.
 
+Optional properties:
+-auto-flow-control: enable automatic flow control support.
+
 Example:
 	aliases {
 		serial0 = &serial0;
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 1028c02..164ba13 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -222,6 +222,9 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	up.capabilities = UART_CAP_FIFO;
 
+	if (of_property_read_bool(dev->of_node, "auto-flow-control"))
+		up.capabilities |= UART_CAP_AFE;
+
 	up.port.serial_in = uniphier_serial_in;
 	up.port.serial_out = uniphier_serial_out;
 	up.dl_read = uniphier_serial_dl_read;
-- 
2.7.4
