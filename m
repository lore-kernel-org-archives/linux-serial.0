From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 4/4] serial: 8250_dw: treat rpm suspend with -EBUSY if RS485 ON and RTS_AFTER_SEND
Date: Wed,  6 Jun 2018 11:51:53 +0200
Message-ID: <20180606095156.72628-3-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Ed Blake <ed.blake@sondrel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
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
2.17.1
