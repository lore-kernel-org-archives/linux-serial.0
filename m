From: "George G. Davis" <gdavis@mvista.com>
Subject: [RFC][PATCH] Make sure UART is powered up when dumping MCTRL status
Date: Fri, 5 May 2006 18:15:37 -0400
Message-ID: <20060505221537.GK14872@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:15657 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751795AbWEEWPk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 May 2006 18:15:40 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Greetings,

Since serial devices are powered down when not in use and some of those
devices cannot be accessed when powered down, we need to enable power
around calls to get_mcrtl() when dumping port state via uart_line_info().
This resolves hangs observed on some machines while reading serial device
registers when a port is powered off.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---

 drivers/serial/serial_core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)


Index: linux-2.6/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.orig/drivers/serial/serial_core.c
+++ linux-2.6/drivers/serial/serial_core.c
@@ -1652,6 +1652,7 @@ static const char *uart_type(struct uart
 static int uart_line_info(char *buf, struct uart_driver *drv, int i)
 {
 	struct uart_state *state = drv->state + i;
+	int pm_state;
 	struct uart_port *port = state->port;
 	char stat_buf[32];
 	unsigned int status;
@@ -1674,9 +1675,16 @@ static int uart_line_info(char *buf, str
 
 	if(capable(CAP_SYS_ADMIN))
 	{
+		mutex_lock(&state->mutex);
+		pm_state = state->pm_state;
+		if (pm_state)
+			uart_change_pm(state, 0);
 		spin_lock_irq(&port->lock);
 		status = port->ops->get_mctrl(port);
 		spin_unlock_irq(&port->lock);
+		if (pm_state)
+			uart_change_pm(state, pm_state);
+		mutex_unlock(&state->mutex);
 
 		ret += sprintf(buf + ret, " tx:%d rx:%d",
 				port->icount.tx, port->icount.rx);
@@ -2068,6 +2076,10 @@ uart_configure_port(struct uart_driver *
 
 		uart_report_port(drv, port);
 
+		/* Power up port for set_mctrl() */
+		if (!uart_console(port))
+			uart_change_pm(state, 0);
+
 		/*
 		 * Ensure that the modem control lines are de-activated.
 		 * We probably don't need a spinlock around this, but


Comments appreciated.  TIA!

--
Regards,
George
