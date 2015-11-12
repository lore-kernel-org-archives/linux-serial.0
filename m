From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag for struct serial_rs485
Date: Thu, 12 Nov 2015 17:33:53 +0300
Message-ID: <1447338836-8785-3-git-send-email-matwey@sai.msu.ru>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This flag is supposed to be used by uart drivers using software rs485 direction control.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 include/uapi/linux/serial.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 25331f9..95b15ca 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -121,6 +121,9 @@ struct serial_rs485 {
 #define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
 							   RTS pin after sent*/
 #define SER_RS485_RX_DURING_TX		(1 << 4)
+#define SER_RS485_SOFTWARE		(1 << 5)	/* Software
+							   implementation is
+							   being used */
 	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
 	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
 	__u32	padding[5];		/* Memory is cheap, new structs
-- 
2.6.2
