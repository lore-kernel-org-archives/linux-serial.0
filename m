From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/7] serial: qcom_geni_serial: Finish supporting sysrq
Date: Mon, 29 Oct 2018 11:07:01 -0700
Message-ID: <20181029180707.207546-2-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

The geni serial driver already had some sysrq code in it, but since
SUPPORT_SYSRQ wasn't defined the code didn't do anything useful.
Let's make it useful by adding that define using the same formula
found in other serial drivers.

In order to prevent deadlock, we'll take a page from the
'msm_serial.c' where the spinlock is released around
uart_handle_sysrq_char().  This seemed better than copying from
'8250_port.c' where we skip locking in the console_write function
since the '8250_port.c' method can cause lockdep warnings when
dropping into kgdb.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..3c8e0202da8b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
+#if defined(CONFIG_SERIAL_QCOM_GENI_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+# define SUPPORT_SYSRQ
+#endif
+
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
@@ -495,7 +499,10 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 					continue;
 			}
 
+			spin_unlock(&uport->lock);
 			sysrq = uart_handle_sysrq_char(uport, buf[c]);
+			spin_lock(&uport->lock);
+
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
 		}
-- 
2.19.1.568.g152ad8e336-goog
