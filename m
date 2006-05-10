From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: [RFC][PATCH] Make sure UART is powered up when dumping MCTRL status
Date: Wed, 10 May 2006 13:13:34 -0400
Message-ID: <20060510171334.GP11126@mvista.com>
References: <20060505221537.GK14872@mvista.com> <20060510163919.GF32632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:33549 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964997AbWEJRNg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 May 2006 13:13:36 -0400
Content-Disposition: inline
In-Reply-To: <20060510163919.GF32632@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

On Wed, May 10, 2006 at 05:39:19PM +0100, Russell King wrote:
> On Fri, May 05, 2006 at 06:15:37PM -0400, George G. Davis wrote:
> > @@ -2068,6 +2076,10 @@ uart_configure_port(struct uart_driver *
> >  
> >  		uart_report_port(drv, port);
> >  
> > +		/* Power up port for set_mctrl() */
> > +		if (!uart_console(port))
> > +			uart_change_pm(state, 0);
> > +
> 
> If it's possible for uarts to be powered down here, wouldn't it be a
> good idea to ensure that the console is also powered up?

Hrm, yes.  The above !uart_console(port) merely assumed that the device
is already powered up if it's the selected console.  In that way we only
call uart_change_pm() to power it up once, earlier but I haven't verified
that it was indeed done properly.  That check can be removed I guess.

Thanks!

--
Regards,
George
