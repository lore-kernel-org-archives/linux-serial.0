From: Shmulik Ladkani <jungoshmulik@gmail.com>
Subject: Re: [PATCH] serial: copy UART properties of UPF_FIXED_TYPE ports
 provisioned using early_serial_setup
Date: Thu, 29 Oct 2009 19:07:32 +0200
Message-ID: <20091029190732.4907b97d@pixies.home.jungo.com>
References: <4AE57EDF.3040607@jungo.com>
	<20091028224737.ac4279e7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:48049 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbZJ2RHh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Oct 2009 13:07:37 -0400
In-Reply-To: <20091028224737.ac4279e7.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, shmulik@jungo.com

On Wed, 28 Oct 2009 22:47:37 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 26 Oct 2009 12:50:07 +0200 Shmulik Ladkani <shmulik@jungo.com> wrote:
> 
> > @@ -2704,6 +2704,14 @@ serial8250_register_ports(struct uart_dr
> >   		struct uart_8250_port *up = &serial8250_ports[i];
> > 
> >   		up->port.dev = dev;
> > +
> > +		if (up->port.flags & UPF_FIXED_TYPE) {
> > +			up->port.fifosize =
> > +				uart_config[up->port.type].fifo_size;
> > +			up->capabilities = uart_config[up->port.type].flags;
> > +			up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
> > +		}
> > +
> >   		uart_add_one_port(drv, &up->port);
> >   	}
> >   }
> 
> Why don't we also initialise up->port.type here?
In the original place (serial8250_register_port) there's a new uart port
instance to be registered (the function's argument).
This new instance *replaces* one of the matched/unused ports in the
serial8250_ports array - hence, the port's type must be properly assigned.

However, in 'serial8250_register_ports' there's no new port to replace an
existing port; but still, the uart port instance has uninitialized
capabilities/tx_loadsz fields that must be set in the UPF_FIXED_TYPE case.
The up->port.type was already initialized by early_serial_setup, and the patch
uses this type as the index to the uart_config array.

An alternative apprach is to move the UPF_FIXED_TYPE initialization code
into early_serial_setup. Do you think it is better?

> Perhaps it would be neater to write a little function to do this rather
> than copy-n-paste?
Yep, I guess it would be. Re-submitting a neater version of the patch.

Signed-off-by: Shmulik Ladkani <shmulik@jungo.com>
---
diff -upr linux-2.6.32-rc5.clean/drivers/serial/8250.c linux-2.6.32-rc5/drivers/serial/8250.c
--- linux-2.6.32-rc5.clean/drivers/serial/8250.c	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/drivers/serial/8250.c	2009-10-29 18:33:50.000000000 +0200
@@ -2688,6 +2688,15 @@ static void __init serial8250_isa_init_p
 	}
 }
 
+static void
+serial8250_init_fixed_type_port(struct uart_8250_port *up, unsigned int type)
+{
+	up->port.type = type;
+	up->port.fifosize = uart_config[type].fifo_size;
+	up->capabilities = uart_config[type].flags;
+	up->tx_loadsz = uart_config[type].tx_loadsz;
+}
+
 static void __init
 serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 {
@@ -2704,6 +2713,10 @@ serial8250_register_ports(struct uart_dr
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		up->port.dev = dev;
+
+		if (up->port.flags & UPF_FIXED_TYPE)
+			serial8250_init_fixed_type_port(up, up->port.type);
+
 		uart_add_one_port(drv, &up->port);
 	}
 }
@@ -3114,12 +3127,8 @@ int serial8250_register_port(struct uart
 		if (port->dev)
 			uart->port.dev = port->dev;
 
-		if (port->flags & UPF_FIXED_TYPE) {
-			uart->port.type = port->type;
-			uart->port.fifosize = uart_config[port->type].fifo_size;
-			uart->capabilities = uart_config[port->type].flags;
-			uart->tx_loadsz = uart_config[port->type].tx_loadsz;
-		}
+		if (port->flags & UPF_FIXED_TYPE)
+			serial8250_init_fixed_type_port(uart, port->type);
 
 		set_io_from_upio(&uart->port);
 		/* Possibly override default I/O functions.  */

-- 
Shmulik Ladkani		Jungo Ltd.
