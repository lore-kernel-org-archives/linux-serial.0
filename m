From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 3/6] mfd: sun6i-prcm: Add support for Allwinner A23
 PRCM
Date: Tue, 15 Jul 2014 08:11:30 +0100
Message-ID: <20140715071130.GA4282@lee--X1>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-4-git-send-email-wens@csie.org>
 <20140710093707.GC11948@lee--X1>
 <20140715065515.GE3745@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:46311 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843AbaGOHLh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2014 03:11:37 -0400
Received: by mail-ig0-f170.google.com with SMTP id h3so2524862igd.5
        for <linux-serial@vger.kernel.org>; Tue, 15 Jul 2014 00:11:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140715065515.GE3745@lukather>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Ortiz <sameo@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sunxi@googlegroups.com

On Tue, 15 Jul 2014, Maxime Ripard wrote:

> Hi Lee,
>=20
> On Thu, Jul 10, 2014 at 10:37:07AM +0100, Lee Jones wrote:
> > On Wed, 09 Jul 2014, Chen-Yu Tsai wrote:
> >=20
> > > The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> > > The differences are the AR100 clock can no longer be modified,
> > > the APB0 clock has different divisors, and some clock gates are
> > > gone.
> > >=20
> > > This patch adds a compatible with a modified subdevice list for
> > > the A23.
> > >=20
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
> > >  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++=
++++++++++++++
> > >  2 files changed, 31 insertions(+), 1 deletion(-)
> >=20
> > Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> We don't have any dependency on this driver, so it would be simpler i=
f
> you could just take it through your tree I guess.

Verll well, applied thanks.



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
