From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Fri, 21 Sep 2012 21:34:40 +0100
Message-ID: <20120921203440.GA6796@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com> <20120920190034.GB15609@n2100.arm.linux.org.uk> <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com> <20120921162543.1ed18775@pyramind.ukuu.org.uk> <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com> <20120921205603.436a0194@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37785 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288Ab2IUUfK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 16:35:10 -0400
Content-Disposition: inline
In-Reply-To: <20120921205603.436a0194@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 08:56:03PM +0100, Alan Cox wrote:
> If you are calling TCSETS2 passing BOTHER and an actual specific speed
> you should always be getting handed back the speed requested as it'll see
> the BOTHER flag is present and assume the caller is smart.

Is this something that should be handled by glibc?  If so, ARM for
whatever reason still seems to use the standard TCGETS and TCSETS
calls... at least stracing stty in ubuntu precise suggests that's
the case.
