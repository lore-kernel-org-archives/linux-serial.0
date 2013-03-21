From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] tty: serial: 8250: remove U6715 16550A auto-detection
Date: Thu, 21 Mar 2013 10:28:21 +0200
Message-ID: <20130321082821.GA2862@xps8300>
References: <1363722609-20021-1-git-send-email-philippe.langlais@st.com>
 <20130320172125.GB28605@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48238 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356Ab3CUI20 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 04:28:26 -0400
Content-Disposition: inline
In-Reply-To: <20130320172125.GB28605@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Langlais <philippe.langlais@st.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hans-Peter Oeri <hp@oeri.ch>

Hi guys,

On Wed, Mar 20, 2013 at 10:21:25AM -0700, Greg Kroah-Hartman wrote:
> On Tue, Mar 19, 2013 at 08:50:09PM +0100, Philippe Langlais wrote:
> > -	if (up->port.type == PORT_16550A && size_fifo(up) == 64) {
> > -		up->port.type = PORT_U6_16550A;
> > -		up->capabilities |= UART_CAP_AFE;
> > -	}
> 
> So you just broke this functionality for all of the other devices it
> does work properly for?  That's not nice, and not acceptable.
> 
> Please fix this properly.

Is there actually anything depending on this quirk? It looks like
U6715 support newer made it to upstream, and I believe the type
PORT_U6_16550A is designed for U6715 only.

In any case, replacing the type PORT_16550A with a type that has
custom capabilities based on fifosize alone feels dangerous to me. 64B
fifo for 16550 compatible UARTs is very common these days. 

Since we have this conditions in autoconfig_16550a(), then would it be
OK to replace it with something like:

-       /*
-        * We distinguish between 16550A and U6 16550A by counting
-        * how many bytes are in the FIFO.
-        */
-       if (up->port.type == PORT_16550A && size_fifo(up) == 64) {
-               up->port.type = PORT_U6_16550A;
-               up->capabilities |= UART_CAP_AFE;
-       }
+       if (up->port.type == PORT_16550A && size_fifo(up) == 64)
+               up->port.fifosize = 64;
+
+       if (up->port.type == PORT_16550A && size_fifo(up) == 128)
+               up->port.fifosize = 128;
 }


We set the port->up.fifosize for a few common fifo sizes, like 64 and
128, instead of replacing the type and capabilities?

Thanks,

-- 
heikki
