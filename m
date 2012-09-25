From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Tue, 25 Sep 2012 20:00:12 +0100
Message-ID: <20120925200012.6576167f@pyramind.ukuu.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
	<20120920190034.GB15609@n2100.arm.linux.org.uk>
	<CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
	<20120921162543.1ed18775@pyramind.ukuu.org.uk>
	<CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
	<20120921205603.436a0194@pyramind.ukuu.org.uk>
	<CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43871 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab2IYSz5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Sep 2012 14:55:57 -0400
In-Reply-To: <CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

> OK sorry for getting this backwards, so I was under the impression that
> BOTHER was an internal detail of the TTY layer, not to be or:ed on
> and passed in from the outside.

BOTHER is a speed setting like the other Bxxx values - it's an external
API.

> 
> Then everything makes perfect sense, I'll try to patch the caller
> instead for this "bug" and see what happens. Probably it JustWorks...

Cool
