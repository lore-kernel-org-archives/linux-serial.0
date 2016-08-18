From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 12:22:08 +0200
Message-ID: <20160818102208.GA20476@kroah.com>
References: <20160818011445.22726-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160818011445.22726-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
> Currently, devices attached via a UART are not well supported in the
> kernel. The problem is the device support is done in tty line disciplines,
> various platform drivers to handle some sideband, and in userspace with
> utilities such as hciattach.
> 
> There have been several attempts to improve support, but they suffer from
> still being tied into the tty layer and/or abusing the platform bus. This
> is a prototype to show creating a proper UART bus for UART devices. It is
> tied into the serial core (really struct uart_port) below the tty layer
> in order to use existing serial drivers.
> 
> This is functional with minimal testing using the loopback driver and
> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
> device). It still needs lots of work and polish.
> 
> TODOs:
> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
>   hoping all that complexity is from the tty layer and not needed here.

It should be.

> - Split out the controller for uart_ports into separate driver. Do we see
>   a need for controller drivers that are not standard serial drivers?

What do you mean by "controller" drivers here?  I didn't understand them
in the code.

> - Implement/test the removal paths
> - Fix the receive callbacks for more than character at a time (i.e. DMA)
> - Need better receive buffering than just a simple circular buffer or
>   perhaps a different receive interface (e.g. direct to client buffer)?

Why?  Is the code as-is slow?

> - Test with other UART drivers
> - Convert a real driver/line discipline over to UART bus.

That's going to be the real test, I recommend trying that as soon as
possible as it will show where the real pain points are :)

> Before I spend more time on this, I'm looking mainly for feedback on the
> general direction and structure (the interface with the existing serial
> drivers in particular).

Yes, I like the idea (minor nit, you still have SPMI in a lot of places
instead of UART), so I recommend keeping going with it.

>  drivers/uart/Kconfig             |  17 ++
>  drivers/uart/Makefile            |   3 +
>  drivers/uart/core.c              | 458 +++++++++++++++++++++++++++++++++++++++
>  drivers/uart/loopback.c          |  72 ++++++

Why not just put this in drivers/tty/uart/ ?

thanks,

greg k-h
