From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 10:03:45 +0000
Message-ID: <20120312100345.GX17370@n2100.arm.linux.org.uk>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com> <CAAMvbhF7-5FyzjgtK7EjFZSJg4KBxdMdd1jnTRTLA-LnsVhKyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46119 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2CLKED (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 06:04:03 -0400
Content-Disposition: inline
In-Reply-To: <CAAMvbhF7-5FyzjgtK7EjFZSJg4KBxdMdd1jnTRTLA-LnsVhKyw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Jong-Sung Kim <neidhard.kim@lge.com>, Linus Walleij <linus.walleij@linaro.org>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Mon, Mar 12, 2012 at 09:27:28AM +0000, James Courtier-Dutton wrote:
> On 12 March 2012 08:25, Linus Walleij <linus.walleij@stericsson.com> wrote:
> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > Chanho Min reported that when the boot loader transfers
> > control to the kernel, there may be pending interrupts
> > causing the UART to lock up in an eternal loop trying to
> > pick tokens from the FIFO (since the RX interrupt flag
> > indicates there are tokens) while in practice there are
> > no tokens - in fact there is only a pending IRQ flag.
> >
> 
> I might be off base here, because I don't know this particular UART,
> but if an IRQ routine is called because the RX interrupt flag is set,
> shouldn't the IRQ routine be written in such a way that it can never
> lock up.

The problem is that there are two flags:

1. The receiver interrupt status flags
2. The fifo status flags

It appears that there's a condition where the receiver interrupt flags can
indicate that characters are pending, but the status flags say that there
are no characters pending in the receive buffer.

This occurs because it seems there's a hardware bug when switching from
FIFO mode to non-FIFO mode - this causes previously received characters
to be hidden from the FIFO status flags.
