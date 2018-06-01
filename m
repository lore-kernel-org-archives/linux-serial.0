From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 5/8] serial: 8250_dw: treat rpm suspend with -EBUSY if RS485 ON and RTS_AFTER_SEND
Date: Fri,  1 Jun 2018 14:40:18 +0200
Message-ID: <20180601124021.102970-6-giulio.benetti@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

If rs485 is on and RTS_AFTER_SEND it means that in idle state rts pin
must be asserted, othwerwise rs485 transceiver will enter tx state.
dw8250 when clocks are stopped keeps rts line de-asserted(high),
resulting in keeping rs485 transceiver in tx state when port is idle.

Check if rs485 is on with RTS_AFTER_SEND set, if so return -EBUSY in
rpm_suspend,

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 888280ff5451..6b0ee6dc8ad0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -668,6 +668,11 @@ static int dw8250_resume(struct device *dev)
 static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(data->line);
+	struct uart_port *p = &up->port;
+
+	if (p->rs485.flags & (SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND))
+		return -EBUSY;
 
 	if (!IS_ERR(data->clk))
 		clk_disable_unprepare(data->clk);
-- 
2.17.0
