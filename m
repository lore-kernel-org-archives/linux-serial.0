From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/8] serial: uapi: Add support for bus termination
Date: Sat, 13 May 2017 09:29:04 +0200
Message-ID: <b10986467211e1c5b3b03f242e6601f65f4fc4b0.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

The Siemens IOT2040 comes with a RS485 interface that allows to enable
or disable bus termination via software. Add a bit to the flags field of
serial_rs485 that applications can set in order to request this feature
from the hardware. This seems generic enough to add it for everyone.
Existing driver will simply ignore it when set.

Signed-off-by: Sascha Weisenberger <sascha.weisenberger@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/uapi/linux/serial.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 5d59c3ebf459..d2667ecd54ac 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -122,6 +122,9 @@ struct serial_rs485 {
 #define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
 							   RTS pin after sent*/
 #define SER_RS485_RX_DURING_TX		(1 << 4)
+#define SER_RS485_TERMINATE_BUS		(1 << 5)	/* Enable bus
+							   termination
+							   (if supported) */
 	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
 	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
 	__u32	padding[5];		/* Memory is cheap, new structs
-- 
2.12.0
