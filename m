From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 16:06:56 +0100
Message-ID: <20120921150656.GG15609@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com> <20120920190034.GB15609@n2100.arm.linux.org.uk> <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com> <20120921153710.220adb92@bob.linux.org.uk> <20120921145803.GF15609@n2100.arm.linux.org.uk> <20120921160503.53736fee@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37490 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab2IUPHQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 11:07:16 -0400
Content-Disposition: inline
In-Reply-To: <20120921160503.53736fee@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 04:05:03PM +0100, Alan Cox wrote:
> > Alan - the only issue that remains is handling the invalid baud rate
> > situation - if left to individual drivers to do this, we will see them
> > doing stuff (as was the case with this very patch - and was the case
> > prior to serial_core) such as using dev_err() to print an error and
> > merely returning from their set_termios function, or clamping to some
> > speed and not feeding back to userspace what they're actually doing.
> 
> They've had years to adapt. It's time they got with the program or just
> broke horribly.

Sorry Alan, I don't think you really understand what I'm saying.

In the old days, lots of serial drivers just ignored termios settings
that they didn't support, or baud rates that they didn't know about -
so when userspace requests, eg 4Mbps on a UART port, the ioctl didn't
fail, and getting the termios back reported 4Mbps.

That is in violation of the POSIX general terminal interface standard,
and is something that I fixed with the uart baud rate functions - which
most serial_core using drivers are using.

Now you're pushing that logic back down into drivers, where driver authors
have to understand these details again, and that's precisely the reverse
of what should be happening.  We should be helping driver authors get
things right by providing helpers to do that, which is exactly what has
been done.

We need helper functions so we don't end up with 10s of buggy
implementations of the same calculation of baud rate quotient, which
each do their own range checking, and then go on to set some random
unreported-back-to-userspace baud rate.
