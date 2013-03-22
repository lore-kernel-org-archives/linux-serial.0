From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 2/2] serial: of_serial: Handle fifosize property
Date: Fri, 22 Mar 2013 11:32:18 +0800
Message-ID: <1363923138.2289.14.camel@leyfoon-vm>
References: <20130321104651.GC2862@xps8300>
	 <1363862880-17295-1-git-send-email-heikki.krogerus@linux.intel.com>
	 <1363866099.2289.8.camel@leyfoon-vm> <20130321132415.GA2902@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:50868 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752515Ab3CVDcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 23:32:31 -0400
In-Reply-To: <20130321132415.GA2902@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, 2013-03-21 at 15:24 +0200, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, Mar 21, 2013 at 07:41:39PM +0800, Ley Foon Tan wrote:
> > On Thu, 2013-03-21 at 12:48 +0200, Heikki Krogerus wrote:
> > > +	/* Check for fifo size */
> > > +	if (of_property_read_u32(np, "fifosize", &prop) == 0)
> > > +		port->fifosize = prop;
> > > +
> > Suggest to use "fifo-size" for the device tree property, to align with
> > other DT properties.
> 
> I was going to, but then I noticed that in some .dtsi files "fifosize"
> is used with uarts. Should I still change it?
I just make the grep for "fifosize" in arch/. It is used by other serial
drivers (not of_serial.c). So, you are safe to change it to "fifo-size".

> 
> > >  	port->irq = irq_of_parse_and_map(np, 0);
> > >  	port->iotype = UPIO_MEM;
> > >  	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> > 
> > I think you need to remove the UPF_FIXED_TYPE from port-flags as well to
> > use the fifo size from device tree. Otherwise, it will get from the
> > static array in 8250.c.
> 
> No, it's the other way around. It is picked from the array
> conditionally, only in case it was not already set. However, if
> UPF_FIXED_TYPE is removed then autoconfig() will override it.
> 
> Thanks,
> 
Okay, I got what you means now. I think someone updated the 8250.c
recently, previously it is always take from static array.
Thanks.



