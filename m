From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Tue, 30 Mar 2010 09:46:37 +0100
Message-ID: <20100330094637.325d3fb9@lxorguk.ukuu.org.uk>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<1269340170-6558-1-git-send-email-chripell@fsfe.org>
	<20100329104838.49c18075@feng-i7>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	<20100329150642.4a94e78a@feng-i7>
	<cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	<20100330101445.5c64dedb@feng-i7>
	<cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41817 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755649Ab0C3In7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Mar 2010 04:43:59 -0400
In-Reply-To: <cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@fsfe.org>
Cc: Feng Tang <feng.tang@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> 1) latency on rx chars becomes very high because we can process
> incoming transfers only after a full 8 byte (or whatever the spi
> transfer dimension is). For a 9600 this is too much.

There I would partly disagree. Fixing the spi driver clearly makes sense
but the serial driver should be batching better. Is there a reason the
driver couldn't adjust the size based upon the tty speed when getting a
termios request ?

> 2) even worse is that we can do flow control decision only on such boundary.

For serial flow control it doesn't matter, its implicitly asynchronous
and if you only turn the fifo on at high speed you response time will be
reasonably bounded.

> 3) this is not reliable: think of what happens if the actual SPI
> transfer speed we get will be slower that the one we requested. We
> won't be emptying the RX buffer fastly enough even if could.

Consoles are not usually balanced for I/O. I grant you probably don't
want to be using full fifo sized blocks but I'm not sure I understand why
there is a problem below that ?

Alan
