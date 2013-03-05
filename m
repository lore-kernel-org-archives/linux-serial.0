From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3] serial: sh-sci: Add OF support
Date: Tue, 5 Mar 2013 19:26:25 +0000
Message-ID: <201303051926.25655.arnd@arndb.de>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com> <5345836.ZO7uU35cQD@wuerfel> <CABYn4sxYRbmEe27WKE-FbTZ3_SM+APaYqHJ1=Zrk8_a5czxZaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60715 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143Ab3CET0f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 14:26:35 -0500
In-Reply-To: <CABYn4sxYRbmEe27WKE-FbTZ3_SM+APaYqHJ1=Zrk8_a5czxZaQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

On Tuesday 05 March 2013, Bastian Hecht wrote:
> 2013/3/4 Arnd Bergmann <arnd@arndb.de>:
> > On Monday 04 March 2013 17:20:52 Bastian Hecht wrote:
> >> +- reg : Address and length of the register set for the device
> >> +- interrupts : Should contain the following IRQs: ERI, RXI, TXI and BRI.
> >
> > You probably want to require the "interrupt-names" property as well
> > then.
> 
> I added the interrupt-names property but still enforce the ordering in
> the binding specs.

Yes, that is the correct approach.

> Don't know if we want the extra overhead to scan for strings or just
> take a certain order for granted.
> If we want to change it to parsing, it would be better to switch
> completely to platform_get_irq_byname() and change all the current
> platform code, else we will produce code overhead.

Right, there is no need to change the code for that, but I think it
makes sense to do the binding the way you describe, in case someone
later wants to move to platform_get_irq_byname. A lot of people prefer
that for some reason, although I think the traditional numbering is
just as good.

> >> +- renesas,scbrr-algo-id : Algorithm ID for the Bit Rate Register
> >> +  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
> >> +  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
> >> +  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
> >> +  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
> >> +  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
> >
> > Maybe replace this with a "clock-frequency" property? This may
> > be what the registers contain, but it is not very readable.
> 
> Hmm... do you want a frequency in absolute terms? And then calculate
> the best SCBRR value for it?
> I'm unsure about this, either you must exactly hit it or accept
> tolerances? As something in between I renamed the property to
> "renesas,clock-algorithm", but I don't know if this is what you want.

I meant the absolute frequency in HZ, since that is what we do
for the 8250 uart and other devices, but only if that is sufficient
for your device.

	Arnd
