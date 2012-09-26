From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Wed, 26 Sep 2012 10:06:04 +0200
Message-ID: <CACRpkda5rwpsiu4+wuXOCwHjnKZpAywGNJNRmPHtBHrcRUUzXg@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
	<20120921162543.1ed18775@pyramind.ukuu.org.uk>
	<CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
	<20120921205603.436a0194@pyramind.ukuu.org.uk>
	<CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:65093 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2IZIGF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 04:06:05 -0400
Received: by wgbdr13 with SMTP id dr13so279004wgb.1
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 01:06:04 -0700 (PDT)
In-Reply-To: <CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Tue, Sep 25, 2012 at 8:48 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 21, 2012 at 9:56 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>> Caller passes BOTHER and actual bit rate - we return BOTHER and a bit
>> rate
>>
>> Caller does not pass BOTHER (may not be TCGETS2 aware) we snap to the
>> nearest Bfoo rate if within 5% otherwise we return BOTHER based rates.
>
> OK sorry for getting this backwards, so I was under the impression that
> BOTHER was an internal detail of the TTY layer, not to be or:ed on
> and passed in from the outside.

OK not I got it working thusly:

/*
 * Make sure the core will not snap baudrate to something
 * "close to" requested rate by setting the BOTHER
 * (baud rate other) flag.
 */
tty->termios->c_cflag &= ~CBAUD;
tty->termios->c_cflag |= BOTHER | (BOTHER >> IBSHIFT);
tty_encode_baud_rate(tty, baud, baud);

There are no in-kernel consumers doing this wicked thing so
mailing it here for reference.

Hope I got it right now...

Yours,
Linus Walleij
