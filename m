From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] ARM: add serial.h and set BASE_BAUD to 0
Date: Thu, 20 Sep 2018 22:13:57 +0200
Message-ID: <20180920201357.16426-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
List-Id: linux-serial@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

For years arm has been using serial.h from asm-generic which sets
BASE_BAUD value to the (1843200 / 16). This is incorrect as:
1) This value obviously isn't correct for all devices
2) There are no device specific serial.h with CONFIG_ARCH_MULTIPLATFORM

That value breaks early serial console e.g. on Broadcom Northstar boards
(CONFIG_ARCH_BCM_5301X) which need BASE_BAUD = (99532800 / 16).

The problem remained unnoticed until 4.14 and the commit 31cb9a8575ca0
("earlycon: initialise baud field of earlycon device structure").

Above commit started filling "baud" in the "struct earlycon_device" (it
seems to be a correct behavior) and changed behavior of the 8250/16550
early console driver. Starting with 4.14 kernel's 8250_early.c sets UART
divisor if both: "uartclk" and "baud" are set. Having wrong value for
BASE_BAUD (and so "uartclk") results in broken console setup.

Solution to that has been introduced in commit 0ff3ab701963 ("serial:
8250_early: Only set divisor if valid clk & baud") and requires setting
BASE_BAUD (and so "uartclk") to 0.

A change similar to this action has been pushed for MIPS in the commit
c8ec2041f549 ("MIPS: Add custom serial.h with BASE_BAUD override for
generic kernel"). Another platform using 0 for BASE_BAUD is s390.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This problem has been originally reported by me in the e-mail:
ns16550 earlycon baud broken on BCM5301X since commit 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon device structure")
https://www.spinics.net/lists/arm-kernel/msg644295.html
---
 arch/arm/include/asm/serial.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/arm/include/asm/serial.h

diff --git a/arch/arm/include/asm/serial.h b/arch/arm/include/asm/serial.h
new file mode 100644
index 000000000000..e12f262290ad
--- /dev/null
+++ b/arch/arm/include/asm/serial.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM_SERIAL_H
+#define _ASM_ARM_SERIAL_H
+
+/* ARM kernels support multiple devices so there isn't a single valid value. */
+#define BASE_BAUD 0
+
+#endif /* _ASM_ARM_SERIAL_H */
-- 
2.13.7
