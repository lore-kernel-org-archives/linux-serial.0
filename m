From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V4 5/5] serial: of_serial: Support big-endian register accesses
Date: Thu,  9 Apr 2015 13:05:18 -0700
Message-ID: <1428609918-10290-6-git-send-email-cernekee@gmail.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, peter@hurleysoftware.com, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If the device node has a "big-endian" property and 32-bit registers, tell
the serial driver to use UPIO_MEM32BE instead of UPIO_MEM32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/of_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 33fb94f78967..e15c443b2a3c 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -115,7 +115,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
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
2.2.2
