From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date: Thu, 13 Nov 2014 10:42:06 +0100
Message-ID: <4606459.kh8mb8TEgZ@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <3356477.HitZEsNa4H@wuerfel> <CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59946 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbaKMJm2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Nov 2014 04:42:28 -0500
In-Reply-To: <CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, tushar.behera@linaro.org, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wednesday 12 November 2014 01:19:24 Kevin Cernekee wrote:
> On Wed, Nov 12, 2014 at 1:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 12 November 2014 00:46:30 Kevin Cernekee wrote:
> >> Remove the platform dependency in Kconfig and add an appropriate
> >> compatible string.  Note that BCM7401 has one 16550A-compatible UART
> >> in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
> >> clock domain.  This driver handles the former one.
> >>
> >> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> >
> > Can you explain why you are using the PXA serial driver instead of the
> > 8250 driver, if this is 16550A compatible? I don't know the history
> > why PXA is using a separate driver.
> 
> I wasn't able to get serial8250 to work in any situation where another
> driver tried to claim "ttyS"/4/64.
> 
> serial8250 calls uart_add_one_port() in its module_init function, even
> if the system doesn't have any ports.  Setting nr_uarts
> (CONFIG_SERIAL_8250_RUNTIME_UARTS) to 0 doesn't help because
> serial8250_find_match_or_unused() will just return NULL.
> 
> I guess I could try to rework that logic but several cases would need
> to be retested, going back to PCs with ISA buses and PCI add-in cards.
> And the differences may be visible to userspace.
> 
> The PXA driver seemed like a much cleaner starting point, even if it
> was intended for a different SoC.

Hmm, I've seen you already posted v2 of the series, but I'm not sure
that this is what Greg had in mind when he suggested using /dev/ttyS*
for the other driver.

TTY naming is a mess today, and you seem to be caught in the middle
of it trying to work around the inherent problems. Extending the PXA
driver is an interesting approach since as you say it's a very nice
clean subset of the 8250 driver, but that doesn't mean that it's
a good long-term strategy, as we will likely have more chips with
8250 variants.

Some of the ways forward that I can see are:

- (your approach) use and extend the pxa serial driver for new SoCs,
  possibly migrate some of the existing users of 8250 to use that
  and leave 8250 alone.

- fix the problem you see in a different way, and get the 8250 driver
  to solve your problem. Possibly integrate the pxa driver back into
  8250 in eventually, as we did with the omap driver.

- Do a fresh start for a general-purpose soc-type 8250 driver, using
  tty_port instead of uart_port as the abstraction layer. Use that for
  all new socs instead of extending the 8250 driver more, possibly
  migrating some of the existing 8250 users.

- split out the /dev/ttyS number allocation from the 8250 driver and
  make it usable by arbitrary drivers.

Greg, Jiri, do you have some guidance, or possibly other ideas?

	Arnd


