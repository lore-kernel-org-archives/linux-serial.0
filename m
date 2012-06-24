From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: serial/mxs-auart: Unable to get interrupt counter from user space
Date: Sat, 23 Jun 2012 19:25:47 -0700
Message-ID: <20120624022547.GA7307@kroah.com>
References: <4FE616CC.9000709@lategoodbye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54932 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab2FXCZx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Jun 2012 22:25:53 -0400
Received: by pbbrp8 with SMTP id rp8so5109109pbb.19
        for <linux-serial@vger.kernel.org>; Sat, 23 Jun 2012 19:25:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FE616CC.9000709@lategoodbye.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefan Wahren <info@lategoodbye.de>
Cc: linux-serial@vger.kernel.org

On Sat, Jun 23, 2012 at 09:19:40PM +0200, Stefan Wahren wrote:
> Hello,
> 
> i'm using Linux 2.6.35 at ARM and i experience the following issue
> with the mxs-auart (App UART). If i transmit and receive data over
> the serial port (using mxs-auart), all the interrupt counter (RX,
> TX, frame, parity, break) accessed from user space (ioctl with
> TIOCGICOUNT or /proc/tty/driver/auart) are zero.
> 
> Here is the scenario to reproduce the problem:
> 
> 1. echoing some characters to the uart device
> 2. fetch the statistics from proc-Filesystem
> 
> Expected results: transmit counter greater than zero
> 
> Observed results: transmit counter is always zero
> 
> The same szenario on the mxs-duart (Debug UART) doesn't show this problem.
> 
> Is this a bug in mxs-auart or just not implemented?

We disabled the transmit counter from being displayed a while ago for
security reasons, perhaps that is what you are seeing?

Also, you do realize just how old 2.6.35 really is, right?

thanks,

greg k-h
