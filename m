From: Shmulik Ladkani <shmulik@jungo.com>
Subject: Re: [PATCH] serial: copy UART properties of UPF_FIXED_TYPE ports
 provisioned  using early_serial_setup
Date: Tue, 27 Oct 2009 13:52:05 +0200
Message-ID: <20091027135205.74bbf5f7@pixies.home.jungo.com>
References: <dzvMe-7Mg-3@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754034AbZJ0LwL@vger.kernel.org>
In-Reply-To: <dzvMe-7Mg-3@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: shmulik@jungo.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 26 Oct 2009 12:20:02 +0100 Shmulik Ladkani <shmulik@jungo.com> wrote:
> Augment the UPF_FIXED_TYPE logic, which currently applies to UART ports 
> provisioned using platform_device_register.
> 
> The suggested patch applies same logic into 'serial8250_register_ports', 
> making UART ports provisioned using early_serial_setup inherit their 
> properties from the uart_config entry.
> 
> The patch applies to linux-2.6.32-rc5

Re-submit (previous mailer messed-up whitespace).

Signed-off-by: Shmulik Ladkani <shmulik@jungo.com>
---
diff -upr linux-2.6.32-rc5.clean/drivers/serial/8250.c linux-2.6.32-rc5/drivers/serial/8250.c
--- linux-2.6.32-rc5.clean/drivers/serial/8250.c	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/drivers/serial/8250.c	2009-10-26 11:36:09.000000000 +0200
@@ -2704,6 +2704,14 @@ serial8250_register_ports(struct uart_dr
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		up->port.dev = dev;
+
+		if (up->port.flags & UPF_FIXED_TYPE) {
+			up->port.fifosize =
+				uart_config[up->port.type].fifo_size;
+			up->capabilities = uart_config[up->port.type].flags;
+			up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+		}
+
 		uart_add_one_port(drv, &up->port);
 	}
 }
-- 
Shmulik Ladkani		Jungo Ltd.
