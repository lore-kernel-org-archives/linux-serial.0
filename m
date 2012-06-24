From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: serial/mxs-auart: Unable to get interrupt counter from user space
Date: Sun, 24 Jun 2012 10:53:07 -0700
Message-ID: <20120624175307.GB29455@kroah.com>
References: <4FE616CC.9000709@lategoodbye.de>
 <20120624022547.GA7307@kroah.com>
 <4FE6DA89.50503@lategoodbye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65199 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab2FXRxM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Jun 2012 13:53:12 -0400
Received: by dady13 with SMTP id y13so4362264dad.19
        for <linux-serial@vger.kernel.org>; Sun, 24 Jun 2012 10:53:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FE6DA89.50503@lategoodbye.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefan Wahren <info@lategoodbye.de>
Cc: linux-serial@vger.kernel.org

On Sun, Jun 24, 2012 at 11:14:49AM +0200, Stefan Wahren wrote:
> Hi,
> 
> Am 24.06.2012 04:25, schrieb Greg KH:
> >On Sat, Jun 23, 2012 at 09:19:40PM +0200, Stefan Wahren wrote:
> >>Hello,
> >>
> >>i'm using Linux 2.6.35 at ARM and i experience the following issue
> >>with the mxs-auart (App UART). If i transmit and receive data over
> >>the serial port (using mxs-auart), all the interrupt counter (RX,
> >>TX, frame, parity, break) accessed from user space (ioctl with
> >>TIOCGICOUNT or /proc/tty/driver/auart) are zero.
> >>
> >>Here is the scenario to reproduce the problem:
> >>
> >>1. echoing some characters to the uart device
> >>2. fetch the statistics from proc-Filesystem
> >>
> >>Expected results: transmit counter greater than zero
> >>
> >>Observed results: transmit counter is always zero
> >>
> >>The same szenario on the mxs-duart (Debug UART) doesn't show this problem.
> >>
> >>Is this a bug in mxs-auart or just not implemented?
> >
> >We disabled the transmit counter from being displayed a while ago for
> >security reasons, perhaps that is what you are seeing?
> 
> Does this security fix affect serial_core or only mxs-auart?

I do not recall, sorry.

> Prevent this security fix from reading all counter (TX, RX, frame
> erros, parity errors, breaks)?
> 
> Do you mean this security issue (
> https://bugzilla.redhat.com/show_bug.cgi?id=648660 ) ?

Nope, a different one.

> >Also, you do realize just how old 2.6.35 really is, right?
> 
> Unfortunaley yes, Freescale the vendor delivers the Board Support
> Package only with 2.6.35.

I suggest you contact Freescale for support for this issue then, as
there's nothing we can do about that old kernel version, sorry.

good luck,

greg k-h
