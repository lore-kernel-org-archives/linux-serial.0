From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/5] serial: qcom_geni_serial: Finish supporting sysrq
Date: Tue, 30 Oct 2018 15:11:03 -0700
Message-ID: <20181030221107.79758-2-dianders@chromium.org>
References: <20181030221107.79758-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181030221107.79758-1-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: dan.carpenter@oracle.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, tony@atomide.com, joel@jms.id.au, linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, jk@ozlabs.org
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
index 1515074e18fb..b83e3554bced 100644
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
