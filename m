From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 12:39:41 -0500
Message-ID: <20130614173941.GA15623@grante>
References: <kpak75$9ko$1@ger.gmane.org>
 <51BB2C2A.9050601@hurleysoftware.com>
 <kpfc5k$5u4$1@ger.gmane.org>
 <51BB3AD0.50201@hurleysoftware.com>
 <kpfgdu$nfb$1@ger.gmane.org>
 <51BB4E64.2000705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:45739 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab3FNRjt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 13:39:49 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so842764lbi.11
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 10:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51BB4E64.2000705@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org

On Fri, Jun 14, 2013 at 01:09:56PM -0400, Peter Hurley wrote:
> On 06/14/2013 12:29 PM, Grant Edwards wrote:
>
> >> Your hardware rx fifo shouldn't have stale data in it because that
> >> should generate an overrun; ie., if the flip buffers cannot accept
> >> data because they're full then the next char pushed when space
> >> becomes available should be a NUL flagged with TTY_OVERRUN.
> >
> > If flow control is enabled, there should be no rx overruns -- that's
> > what flow control is for.  In the scenario above, flow control is
> > enabled (and working).  In order to allow the UART to handle flow
> > control, the UART driver must stop reading data from the rx fifo when
> > the tty layer is "full".  The documentation for the serial core API
> > specifically states that UARTs are allowed to implement flow control
> > in hardware, and the only way that can be done is to alow the rx fifo
> > to fill up when the application stops makeing read() calls and the tty
> > layer fills up.
> >
> > I think in newer kernels instead of explicitly checking for room in
> > the tty layer before unloading the rx fifo, the UART is supposed to
> > rely on the throttle/unthrottle callbacks, but the end result is the
> > same: when the tty layer gets "full", the UART driver stops reading
> > data from the rx fifo, and the rx fifo fills up.
> 
> AFAIK, only USB serial stops reading the rx fifo on throttle;

All the drivers I maintain do that.  It's the only way to get flow
control to work.  For UART with large FIFOs (e.g. 1KB) -- espcially
those attached via USB or Ethernet -- flow control driven by code in
serial_core just doesn't work right: you've got to let the UART handle
it.

> the serial core and other tty drivers continue to empty the rx fifo
> -- throttle only shuts off the transmitter on the other end.
> 
> Without handling throttle/unthrottle, how are you determining that the
> tty layer is "full"?  Return code from tty_insert_flip_xxxx()?

I check tty->receive_room.  What are you supposed to do for kernel
versions that don't have the throttle()/unthrottle() callbacks?

-- 
Grant
