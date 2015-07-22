From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH 2/4] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on device tree
Date: Wed, 22 Jul 2015 12:34:57 +0300
Message-ID: <1437557699-25722-3-git-send-email-noamc@ezchip.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437557699-25722-2-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437557699-25722-2-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, gregkh@linuxfoundation.org, jslaby@suse.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Add support for OF option "no-loopback-test"

use case: simulator which does not implements loopback test mode.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 .../bindings/serial/snps-dw-apb-uart.txt           |    2 ++
 drivers/tty/serial/8250/8250_dw.c                  |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
index 289c40e..5d16047 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
@@ -33,6 +33,8 @@ Optional properties:
 - ri-override : Override the RI modem status signal. This signal will always be
   reported as inactive instead of being obtained from the modem status register.
   Define this if your serial port does not use this pin.
+- no-loopback-test: set to indicate that the port does not implements loopback
+  test mode
 
 Example:
 
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index fe0b487..1a57105 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -370,6 +370,9 @@ static int dw8250_probe_of(struct uart_port *p,
 		up->dma->txconf.dst_maxburst = p->fifosize / 4;
 	}
 
+	if (of_find_property(np, "no-loopback-test", NULL))
+		p->flags |= UPF_SKIP_TEST;
+
 	if (!of_property_read_u32(np, "reg-shift", &val))
 		p->regshift = val;
 
-- 
1.7.1
