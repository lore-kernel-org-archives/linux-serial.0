From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: 8250_exar: Adjust IOT2000 matching
Date: Thu, 18 Apr 2019 11:15:04 +0200
Message-ID: <ac8f8999-44b9-e364-4582-3b0ee735f6a8@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Su Bao Cheng <baocheng.su@siemens.com>
List-Id: linux-serial@vger.kernel.org

From: Su Bao Cheng <baocheng.su@siemens.com>

Since there are more IOT2040 variants with identical hardware but
different asset tags, the asset tag matching should be adjusted to
support them.

As only the IOT2040 variants have the Exar chip on board, matching on
their board name is enough. In the future there will be no other devices
with the "SIMATIC IOT2000" DMI board name but different hardware.

Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 0089aa305ef9..edd6dfe055bf 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -361,12 +361,15 @@ static const struct exar8250_platform iot2040_platform = {
 	.register_gpio = iot2040_register_gpio,
 };
 
+/*
+ * For SIMATIC IOT2000, only IOT2040 and its variants have the Exar device,
+ * IOT2020 doesn't have. Therefore it is sufficient to match on the common
+ * board name after the device was found.
+ */
 static const struct dmi_system_id exar_platforms[] = {
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
-			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
-					"6ES7647-0AA00-1YA2"),
 		},
 		.driver_data = (void *)&iot2040_platform,
 	},
-- 
2.16.4
