From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 6/7] serial: of_serial: Support big-endian register accesses
Date: Mon, 24 Nov 2014 15:36:21 -0800
Message-ID: <1416872182-6440-7-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47132 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaKXXgh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 18:36:37 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

If the device node has a "big-endian" property and 32-bit registers, tell
the serial driver to use UPIO_MEM32BE instead of UPIO_MEM32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/of_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 56982da4..efac1dd 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -109,7 +109,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			port->iotype = UPIO_MEM;
 			break;
 		case 4:
-			port->iotype = UPIO_MEM32;
+			port->iotype = of_device_is_big_endian(np) ?
+				       UPIO_MEM32BE : UPIO_MEM32;
 			break;
 		default:
 			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
-- 
2.1.0

