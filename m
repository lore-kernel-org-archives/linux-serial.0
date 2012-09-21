From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 15:58:03 +0100
Message-ID: <20120921145803.GF15609@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com> <20120920190034.GB15609@n2100.arm.linux.org.uk> <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com> <20120921153710.220adb92@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37462 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab2IUO6W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 10:58:22 -0400
Content-Disposition: inline
In-Reply-To: <20120921153710.220adb92@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 03:37:10PM +0100, Alan Cox wrote:
> > Device drivers should use c_[io]speed directly!
> > 
> > Alan Cox wrote this, so Alan: should I just ditch the use of
> > uart_get_baud_rate() and program the divider directly from
> > c_[io]speed?
> 
> Yes.
> 
> The functions are designed to act as helpers for old devices. In fact
> we can actually probably abolish tty_termios_baud_rate at this point as
> I don't think there is much if anything left which blows up fed a non
> Bxxx table entry.
> 
> I will have a look at that in fact see what it involves at this point.

Alan - the only issue that remains is handling the invalid baud rate
situation - if left to individual drivers to do this, we will see them
doing stuff (as was the case with this very patch - and was the case
prior to serial_core) such as using dev_err() to print an error and
merely returning from their set_termios function, or clamping to some
speed and not feeding back to userspace what they're actually doing.
