From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] tty: pl011: fix earlycon work-around for QDF2400 erratum 44
Date: Fri, 31 Mar 2017 17:05:02 -0500
Message-ID: <1490997902-4894-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shanker Donthineni <shankerd@codeaurora.org>, Christopher Covington <cov@mykolab.com>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, yousaf.kaukab@suse.com, agraf@suse.de, mbrugger@suse.com
List-Id: linux-serial@vger.kernel.org

The work-around for the Qualcomm Datacenter Technologies QDF2400
erratum 44 sets the "qdf2400_e44_present" global variable if the
work-around is needed.  However, this check does not happen until after
earlycon is initialized, which means the work-around is not
used, and the console hangs as soon as it displays one character.

Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 56f92d7..b0a3777 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2452,18 +2452,37 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
+/*
+ * On non-ACPI systems, earlycon is enabled by specifying
+ * "earlycon=pl011,<address>" on the kernel command line.
+ *
+ * On ACPI ARM64 systems, an "early" console is enabled via the SPCR table,
+ * by specifying only "earlycon" on the command line.  Because it requires
+ * SPCR, the console starts after ACPI is parsed, which is later than a
+ * traditional early console.
+ *
+ * To get the traditional early console that starts before ACPI is parsed,
+ * specify the full "earlycon=pl011,<address>" option.
+ */
 static int __init pl011_early_console_setup(struct earlycon_device *device,
 					    const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = qdf2400_e44_present ?
-				qdf2400_e44_early_write : pl011_early_write;
+	/* On QDF2400 SOCs affected by Erratum 44, the "qdf2400_e44" must
+	 * also be specified, e.g. "earlycon=pl011,<address>,qdf2400_e44".
+	 */
+	if (!strcmp(device->options, "qdf2400_e44"))
+		device->con->write = qdf2400_e44_early_write;
+	else
+		device->con->write = pl011_early_write;
+
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
+EARLYCON_DECLARE(qdf2400_e44, pl011_early_console_setup);
 
 #else
 #define AMBA_CONSOLE	NULL
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
