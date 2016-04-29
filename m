From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Fri, 29 Apr 2016 09:10:06 +0100
Message-ID: <20160429081006.GD3826@redhat.com>
References: <1461881913-23967-1-git-send-email-rjones@redhat.com>
 <1461881913-23967-2-git-send-email-rjones@redhat.com>
 <20160428225633.GA9134@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160428225633.GA9134@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, matwey@sai.msu.ru, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 28, 2016 at 03:56:33PM -0700, Greg KH wrote:
> On Thu, Apr 28, 2016 at 11:18:33PM +0100, Richard W.M. Jones wrote:
> > Currently autoconf spends 25ms (on my laptop) testing if the UART
> > exported to it by KVM is an 8250 without FIFO and/or with strange
> > quirks, which it obviously isn't.  Assume it is exported to us by a
> > hypervisor, it's a normal, working 16550A.
> > 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 00ad2637..de19924 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1171,6 +1171,13 @@ static void autoconfig(struct uart_8250_port *up)
> >  	if (!port->iobase && !port->mapbase && !port->membase)
> >  		return;
> >  
> > +	/* Hypervisors always export working 16550A devices. */
> > +	if (cpu_has_hypervisor) {
> > +		up->port.type = PORT_16550A;
> > +		up->capabilities |= UART_CAP_FIFO;
> > +		return;
> > +	}
> 
> Have you audited vmware, virtualbox, and everyone else that provides a
> virtual uart device that it will work properly here?
> 
> qemu isn't all the world :)

Attached below is a slightly different approach.  If the user passes a
special flag on the kernel command line then we force 16550A and avoid
the 25ms delay.  Since the user chooses the flag, any concerns about
the behaviour of the hypervisor or use of VFIO should be moot.

Rich.

>From 5694addf0e05de9c842274be8392ebce5dc24280 Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu, 28 Apr 2016 23:08:54 +0100
Subject: [PATCH] 8250: Allow user to force 16550A UART and avoid probing.

Currently autoconf spends 25ms (on my laptop) testing the UART.

Allow the user to avoid this delay if they know that all serial ports
(eg on a virtual machine) are ordinary 16550A.  The user does this by
passing '8250_base.really_16550a' on the command line.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 00ad2637..ac92f55 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -53,6 +53,10 @@
 #define DEBUG_AUTOCONF(fmt...)	do { } while (0)
 #endif
 
+static bool really_16550a;
+module_param(really_16550a, bool, 0644);
+MODULE_PARM_DESC(really_16550a, "Don't probe, assume 16550A");
+
 #define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
 
 /*
@@ -1171,6 +1175,12 @@ static void autoconfig(struct uart_8250_port *up)
 	if (!port->iobase && !port->mapbase && !port->membase)
 		return;
 
+	if (really_16550a) {
+		up->port.type = PORT_16550A;
+		up->capabilities |= UART_CAP_FIFO;
+		return;
+	}
+
 	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04lx, 0x%p): ",
 		       serial_index(port), port->iobase, port->membase);
 
-- 
2.7.4



-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
