From: Heiko Schocher <hs@denx.de>
Subject: [PATCH] tty: 8250_of: Use software emulated RS485 direction control
Date: Fri, 13 Sep 2019 07:01:05 +0200
Message-ID: <20190913050105.1132080-1-hs@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, John Garry <john.garry@huawei.com>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use software emulated RS485 direction control to provide RS485 API

Currently it is not possible to use rs485 as pointer to
rs485_config struct in struct uart_port is NULL in case we
configure the port through device tree.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
Patch is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
commit:
505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"

checkpatch output:
$ ./scripts/checkpatch.pl 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch
total: 0 errors, 0 warnings, 43 lines checked

0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch has no obvious style problems and is ready for submission.

 drivers/tty/serial/8250/8250_of.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0826cfdbd4063..92fbf46ce3bd9 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -48,6 +48,36 @@ static inline void tegra_serial_handle_break(struct uart_port *port)
 }
 #endif
 
+static int of_8250_rs485_config(struct uart_port *port,
+				  struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	/* Clamp the delays to [0, 100ms] */
+	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
+	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
+
+	port->rs485 = *rs485;
+
+	/*
+	 * Both serial8250_em485_init and serial8250_em485_destroy
+	 * are idempotent
+	 */
+	if (rs485->flags & SER_RS485_ENABLED) {
+		int ret = serial8250_em485_init(up);
+
+		if (ret) {
+			rs485->flags &= ~SER_RS485_ENABLED;
+			port->rs485.flags &= ~SER_RS485_ENABLED;
+		}
+		return ret;
+	}
+
+	serial8250_em485_destroy(up);
+
+	return 0;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -178,6 +208,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->flags |= UPF_SKIP_TEST;
 
 	port->dev = &ofdev->dev;
+	port->rs485_config = of_8250_rs485_config;
 
 	switch (type) {
 	case PORT_TEGRA:
-- 
2.21.0
