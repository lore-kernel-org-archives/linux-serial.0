Return-Path: <SRS0=p7su=5L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501FAC43331
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 01:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1946A20772
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 01:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585187099;
	bh=8LbJ1rOzX1zYoBejYpdC7F7zcKGB/JvH0asXD8eYU9E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=SkV3h0XR1dGKkpfoVa9IrfaeMpzMhdeNdqfShDQr3W5R/+AAQAWW3ppqQqhc69mda
	 csw7XHknDHHE/sqanpRVjnUeQ54NkB5RjHb8DuRZ/xiGaJnW9XkWHQCLjZkiQ8lKo2
	 THTOe06ZFFWKjmy2fyP7NJrip/iMLUOdnH+rw6Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCZBo4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgCZBoz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 21:44:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1027020714;
        Thu, 26 Mar 2020 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585187094;
        bh=8LbJ1rOzX1zYoBejYpdC7F7zcKGB/JvH0asXD8eYU9E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oEs++OaVBTcEmslMsPj+RGYKdfCXHQLyvbzyViFcH0FvbwO86DXYq9nSqLVoiaSmz
         kb/33HUX8VTBtuxqpFrP/iAt11KpyvSCYr8VQ9qIXcG1uK3odHz6cjL7t7AThk7OVq
         GDwsJgi7Nl64caeYnTF2AUaC1UX1J5j+SB+Mulrc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200325171109.cohnsw3s57ckaqud@ubsrv2.baikal.int>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru> <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru> <20200323100109.k2gckdyneyzo23fb@gilmour.lan> <20200323135017.4vi5nwam2rlpepgn@ubsrv2.baikal.int> <20200324101243.GG1922688@smile.fi.intel.com> <20200325171109.cohnsw3s57ckaqud@ubsrv2.baikal.int>
Subject: Re: [PATCH v2] serial: 8250_dw: Fix common clocks usage race condition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chen-Yu Tsai <wens@csie.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Catalin Marina s <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Wed, 25 Mar 2020 18:44:53 -0700
Message-ID: <158518709322.125146.10069235641747677647@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Sergey Semin (2020-03-25 10:11:09)
> On Tue, Mar 24, 2020 at 12:12:43PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2020 at 04:50:17PM +0300, Sergey Semin wrote:
> > > On Mon, Mar 23, 2020 at 11:01:09AM +0100, Maxime Ripard wrote:
> >=20
> > > > clk_rate_exclusive_get is pretty intrusive, and due to the usual
> > > > topology of clock trees, this will lock down 3-4 parent clocks to
> > > > their current rate as well. In the Allwinner SoCs case for example,
> > > > this will lock down the same PLL than the one used by the CPU,
> > > > preventing cpufreq from running.
> > >=20
> > > Speaking about weak design of a SoC' clock tree. Our problems are not=
hing
> > > with respect to the Allwinner SoC, in which case of changing the
> > > CPU-frequency may cause the UART glitches subsequently causing data
> > > transfer artefacts.) Moreover as I can see the same issue may raise f=
or
> > > I2C, QSPI, PWM devices there.
> > >=20
> > > Anyway your concern does make sense.
> > >=20
> > > > However, the 8250 has a pretty wide range of dividers and can adapt=
 to
> > > > any reasonable parent clock rate, so we don't really need to lock t=
he
> > > > rate either, we can simply react to a parent clock rate change using
> > > > the clock notifiers, just like the SiFive UART is doing.
> > > >=20
> > > > I tried to do that, but given that I don't really have an extensive
> > > > knowledge of the 8250, I couldn't find a way to stop the TX of chars
> > > > while we change the clock rate. I'm not sure if this is a big deal =
or
> > > > not, the SiFive UART doesn't seem to care.
> > >=20
> > > Yes, your solution is also possible, but even in case of stopping Tx/=
Rx it
> > > doesn't lack drawbacks. First of all AFAIK there is no easy way to ju=
st
> > > pause the transfers. We'd have to first wait for the current transfers
> > > to be completed, then somehow lock the port usage (both Tx and Rx
> > > traffic), permit the reference clock rate change, accordingly adjust =
the
> > > UART clock divider, and finally unlock the port. While if we don't mi=
nd
> > > to occasionally have UART data glitches, we can just adjust the UART =
ref
> > > divider synchronously with ref clock rate change as you and SiFive UA=
RT
> > > driver suggest.
> > >=20
> > > So we are now at a zugzwang - a fork to three not that good solutions:
> > > 1) lock the whole clock branch and provide a glitchless interfaces. B=
ut
> > > by doing so we may (in case of Allwinner SoCs we will) lockup some ve=
ry
> > > important functionality like CPU-frequency change while the UART port=
 is
> > > started up. In this case we won't have the data glitches.
> > > 2) just adjust the UART clock divider in case of reference clock rate
> > > change (use the SiFive UART driver approach). In this case we may hav=
e the
> > > data corruption.
> > > 3) somehow implement the algo: wait for the transfers to be completed,
> > > lock UART interface (it's possible for Tx, but for Rx in case of no h=
andshake
> > > enabled it's simply impossible), permit the ref clock rate change,
> > > adjust the UART divider, then unlock the UART interface. In this case=
 the data
> > > glitches still may happen (if no modem control is available or
> > > handshakes are disabled).
> > >=20
> > > As for the cases of Baikal-T1 UARTs the first solutions is the most s=
uitable.
> > > We don't lock anything valuable, since a base PLL output isn't direct=
ly
> > > connected to any device and it's rate once setup isn't changed during=
 the
> > > system running. On the other hand I don't mind to implement the second
> > > solution, even though it's prone to data glitches. Regarding the solu=
tion
> > > 3) I won't even try. It's too complicated, I don't have time and
> > > test-infrastructure for this.
> > >=20
> > > So Andy what do you think?
> >=20
> > From Intel HW perspective the first two are okay, but since Maxime is a=
gainst
> > first, you have the only option from your list. Perhaps somebody may gi=
ve
> > option 4) here...
> >=20
>=20
> Ok then. I'll implement the option 2) in v3 if noone gives any alternativ=
es
> before that.
>=20

Sorry, I haven't really read the thread but I'll quickly reply with
this.

Maybe option 4 is to make the uart driver a clk provider that consumes
the single reference clk like it is already doing today? Then when the
rate changes up above for the clk implemented here the clk set rate op
for the newly implemented clk can go poke the uart registers to maintain
the baud or whatever?

That is close to how the notifier design would work, but it avoids
keeping the notifiers around given that the notifiers are not preferred.
It is also closer to reality, the uart has a divider or mux internally
that we don't model as a clk, but we could just as easily model as such.
