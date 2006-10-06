From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: [RFC][PATCH] Make sure UART is powered up when dumping MCTRL status
Date: Thu, 5 Oct 2006 20:30:53 -0400
Message-ID: <20061006003053.GC26318@mvista.com>
References: <20060505221537.GK14872@mvista.com> <20060510163919.GF32632@flint.arm.linux.org.uk> <20060628142346.GK9261@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:425 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751541AbWJFAcI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Oct 2006 20:32:08 -0400
Content-Disposition: inline
In-Reply-To: <20060628142346.GK9261@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

Ping,

On Wed, Jun 28, 2006 at 10:23:46AM -0400, George G. Davis wrote:
> On Wed, May 10, 2006 at 05:39:19PM +0100, Russell King wrote:
> > On Fri, May 05, 2006 at 06:15:37PM -0400, George G. Davis wrote:
> > > @@ -2068,6 +2076,10 @@ uart_configure_port(struct uart_driver *
> > >  
> > >  		uart_report_port(drv, port);
> > >  
> > > +		/* Power up port for set_mctrl() */
> > > +		if (!uart_console(port))
> > > +			uart_change_pm(state, 0);
> > > +
> > 
> > If it's possible for uarts to be powered down here, wouldn't it be a
> > good idea to ensure that the console is also powered up?
> 
> Apologies for the delay...  Here's an update which insures all serial
> ports are powered up prior to accessing device registers.
> 
> Since serial devices are powered down when not in use and some of those
> devices cannot be accessed when powered down, we need to enable power
> around calls to get_mcrtl() when dumping port state via uart_line_info().
> This resolves hangs observed on some machines while reading serial device
> registers when a port is powered off.
> 
> Signed-off-by: George G. Davis <gdavis@mvista.com>

Any chance of this getting committed?  The Freescale i.MX31 shuts off clocks
when ports are not in use and the kernel hangs without this change.  It's
likely other targets may start managing clocks in this way too.  So this
may be required for others at some point. In the meantime, it should be
harmless for those targets which don't manage device clocks, no?

TIA!

--
Regards,
George
