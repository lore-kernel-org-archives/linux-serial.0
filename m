From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Tue, 25 Sep 2012 20:48:22 +0200
Message-ID: <CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
	<20120921162543.1ed18775@pyramind.ukuu.org.uk>
	<CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
	<20120921205603.436a0194@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:63219 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab2IYSsY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Sep 2012 14:48:24 -0400
Received: by weyt9 with SMTP id t9so1095388wey.19
        for <linux-serial@vger.kernel.org>; Tue, 25 Sep 2012 11:48:23 -0700 (PDT)
In-Reply-To: <20120921205603.436a0194@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 9:56 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 21 Sep 2012 19:52:04 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:

>> it's the call to
>> tty_termios_encode_baud_rate() that is the problem, not how it
>> gets called. It's that function that fuzzes and "snaps" the baudrate
>> to some rough-fit speed and screws things up for me.
>
> (...)
> The intended behaviour at tty layer is
>
> Caller passes BOTHER and actual bit rate - we return BOTHER and a bit
> rate
>
> Caller does not pass BOTHER (may not be TCGETS2 aware) we snap to the
> nearest Bfoo rate if within 5% otherwise we return BOTHER based rates.

OK sorry for getting this backwards, so I was under the impression that
BOTHER was an internal detail of the TTY layer, not to be or:ed on
and passed in from the outside.

Then everything makes perfect sense, I'll try to patch the caller
instead for this "bug" and see what happens. Probably it JustWorks...

Thanks a lot Alan!
Linus Walleij
