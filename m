From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 15:37:10 +0100
Message-ID: <20120921153710.220adb92@bob.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45084 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2IUOfu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 10:35:50 -0400
In-Reply-To: <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

> Device drivers should use c_[io]speed directly!
> 
> Alan Cox wrote this, so Alan: should I just ditch the use of
> uart_get_baud_rate() and program the divider directly from
> c_[io]speed?

Yes.

The functions are designed to act as helpers for old devices. In fact
we can actually probably abolish tty_termios_baud_rate at this point as
I don't think there is much if anything left which blows up fed a non
Bxxx table entry.

I will have a look at that in fact see what it involves at this point.

Alan
