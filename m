From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 20:56:03 +0100
Message-ID: <20120921205603.436a0194@pyramind.ukuu.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
	<20120921162543.1ed18775@pyramind.ukuu.org.uk>
	<CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39603 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab2IUTvc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 15:51:32 -0400
In-Reply-To: <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, 21 Sep 2012 19:52:04 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Sep 21, 2012 at 5:25 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Untested but I suspect the following may help
> 
> Nope it doesn't, it's not this part that goes wrong, it's the call to
> tty_termios_encode_baud_rate() that is the problem, not how it
> gets called. It's that function that fuzzes and "snaps" the baudrate
> to some rough-fit speed and screws things up for me.

It should only snap the baud rate if your caller didn't ask for a specific
speed. With the older uart_get_baud_rate code it mangled the encoding
because BOTHER got mangled by uart_get_baud_rate.

The intended behaviour at tty layer is

Caller passes BOTHER and actual bit rate - we return BOTHER and a bit
rate

Caller does not pass BOTHER (may not be TCGETS2 aware) we snap to the
nearest Bfoo rate if within 5% otherwise we return BOTHER based rates.

If you are calling TCSETS2 passing BOTHER and an actual specific speed
you should always be getting handed back the speed requested as it'll see
the BOTHER flag is present and assume the caller is smart.

So how are you setting the speed and can you see at which point it is
getting mushed ?

Alan


