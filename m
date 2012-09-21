From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 16:36:50 +0100
Message-ID: <20120921163650.0c5966e3@pyramind.ukuu.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
	<20120921153710.220adb92@bob.linux.org.uk>
	<20120921145803.GF15609@n2100.arm.linux.org.uk>
	<20120921160503.53736fee@pyramind.ukuu.org.uk>
	<20120921150656.GG15609@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39249 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab2IUPcL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 11:32:11 -0400
In-Reply-To: <20120921150656.GG15609@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

> Sorry Alan, I don't think you really understand what I'm saying.

I'm taking about getting rid of the tty_termios_baud_rate() helper not
the uart_get_baud_rate() helper. The tty one has no real purpose any more
because we always set c_ospeed.

The uart layer one just needs some bug fixing I think.

Alan
