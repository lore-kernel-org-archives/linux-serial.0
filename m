Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E443EE1E5;
	Wed,  1 Jul 2026 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895548; cv=none; b=QDsSLenoOe/4XkqtbITXZovSWRasjGc0Vjp/Y+0iUh7nbPT6kzRIXwBlSxnl/dNG1O7Bzbkj3rPoRHeSriinYpBmIZTMU6UzY/Tao3aAkyq3jJY8Lm0Soxhfjsr8yqOdmNeFAJ4OOduUfjd8uc0uyKizdjyUZ2ZtgDA5JZ/ucYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895548; c=relaxed/simple;
	bh=lwIFlky8V5kGuhtzYibJrn4AW0XqSEsGyBIjxN8J6FM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qZbsuvweq/8LX2UzoDkrthhnIz7P6S/JLAh+WQVVZ+lwVt31TJB4gPGFu7sBMnUkzrCkY2PmD7ZRY9FQHfiV7c5JNZ5ldRDpNJcWoGParzizXF116bMA7gHm2nhW4OgKwqemK5IWY/9rWcr/JW4MV8e4w4oY7Mw1lnyryYNPB+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY+8nVGl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY+8nVGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782895541; x=1814431541;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lwIFlky8V5kGuhtzYibJrn4AW0XqSEsGyBIjxN8J6FM=;
  b=YY+8nVGldqzhXI4hyMhbxzKlFpS2ndV5e1vjzFCbYM8P/FJqQhWcuILO
   silZ5ykAfoVuc2UN6gjMqZjxGEMRBDoLp09iyqwZ9XbxA8tJ4nKiNorjT
   IVQyo8mOG/sO6ppsQQNPEAibTf4V83s31PMmtbjj8HAw2Iji1CLSeCUgf
   VR0ZnauPgkb2lwkDyRxmjfEzmN8N1Hu7uWE/FhF2+XLQWUf1y9gjvVSTC
   u0Z1drM92unlRLKW0VADpKP5ByM1bgV8yVJwM6UPem4f3rIaAPMyunPmR
   IIK52GPOxy+Viu7/pzQVhVyMfHIET9VDOhUi+44F5TIZC8K4hHF9dCh28
   g==;
X-CSE-ConnectionGUID: w4F4nEsTQwWo5kS6uSSKgw==
X-CSE-MsgGUID: DTKzoca7Rky65ZuvcMci+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83707485"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="83707485"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:45:40 -0700
X-CSE-ConnectionGUID: z1pw/2CdTESOuRBOcbxtTw==
X-CSE-MsgGUID: efiweooqTjqpNDtRVQ+C1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="275730792"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:45:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 1 Jul 2026 11:45:32 +0300 (EEST)
To: Yicong Yang <yang.yicong@picoheart.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, geshijian@picoheart.com, 
    yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround
 if available
In-Reply-To: <b175fd37-e998-40b1-99c3-491e3d6f7e04@picoheart.com>
Message-ID: <ce31a5fe-8b6e-62af-038b-4e65cb94493d@linux.intel.com>
References: <20260629075510.32854-1-yang.yicong@picoheart.com> <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com> <877fc902-7b8d-454c-8346-de1087edcdc4@picoheart.com> <c017f37a-5873-2716-96e7-3deb46eff1a8@linux.intel.com>
 <b175fd37-e998-40b1-99c3-491e3d6f7e04@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1984840293-1782895532=:7215"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1984840293-1782895532=:7215
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 1 Jul 2026, Yicong Yang wrote:

> On 7/1/26 2:18 AM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 1 Jul 2026, Yicong Yang wrote:
> >> On 6/29/26 11:56 PM, Ilpo J=C3=A4rvinen wrote:
> >>> On Mon, 29 Jun 2026, Yicong Yang wrote:
> >>>
> >>>> The DW uart could get into the cases where a bogus RX timeout
> >>>> interrupt is asserted but no available data. This could be
> >>>> workaround by doing a bogus read.
> >>>>
> >>>> Currently the driver's using the standard RBR (receive buffer
> >>>> register) for this bogus read. However the reading of RBR
> >>>> in this case is allowed to raise a hardware error if vendor
> >>>> choose to implement in this way (our platform). It's also
> >>>> allowed to do the bogus read using SRBR (shadow RBR) for
> >>>> workaround which won't raise the hardware error. So change
> >>>> to use the SRBR to workaround the issue if it's available.
> >>>>
> >>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> >>>> ---
> >>>>  drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
> >>>>  drivers/tty/serial/8250/8250_dwlib.c |  3 +++
> >>>>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
> >>>>  3 files changed, 20 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/=
8250/8250_dw.c
> >>>> index 84ffba045ffa..fea7dfa30e78 100644
> >>>> --- a/drivers/tty/serial/8250/8250_dw.c
> >>>> +++ b/drivers/tty/serial/8250/8250_dw.c
> >>>> @@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *=
p)
> >>>>  =09if (!up->dma && rx_timeout) {
> >>>>  =09=09status =3D serial_lsr_in(up);
> >>>> =20
> >>>> -=09=09if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >>>> -=09=09=09serial_port_in(p, UART_RX);
> >>>> +=09=09if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >>>> +=09=09=09/*
> >>>> +=09=09=09 * Do the bogus read from Shadow RBR (SRBR) if provided.
> >>>> +=09=09=09 * Both RBR and SRBR are supported ways to workaround
> >>>
> >>> Hi,
> >>>
> >>> I've not come across this being mentioned anywhere else than in kerne=
l=20
> >>> related context, but you seem to imply there something that tells abo=
ut=20
> >>> "supported ways"?
> >>>
> >>
> >> in fact we got this workaround method that's documented in the synopsy=
s
> >> dw_uart issue report, so comment "supported" here. quote the related p=
art
> >> of the workaround below:
> >>
> >>   [read USR[3] for the rx fifo status]
> >>   If the read value is '0' (indicating the RX FIFO is empty), do a dum=
my
> >>   read of the RBR or shadow RBR (SRBR) register without processing the
> >>   invalid read data.
> >>
> >>   ...Note: Reading the RBR results in a PSLVERR immediately if
> >>   REG_TIMEOUT_WIDTH parameter is set to '0'. Whereas, reading SRBR doe=
s
> >>   not result in PSLVERR.
> >=20
> > Okay, thanks.
> >=20
> >>> If there's no such thing, I'm bit hesitant to declare presence of SRB=
R=20
> >>> guarantees reading it universally solves this issue.
> >>>
> >>> BUT, I suppose it does on your HW since you must have hit this code p=
ath,=20
> >>> and thus PSLVERR, yourself to actually discover this issue so I assum=
e=20
> >>> you've then also confirmed that this patch solves the issue in your c=
ase=20
> >>> which isn't entirely without merit either.
> >>>
> >>
> >> actually it's hard to reproduce, only once at boot time in our several
> >> hundreds reboot test. we locate the code line here by the backtrace of
> >> the system error. the issue hasn't reproduced yet on the patched kerne=
l
> >> (hundred reboots so far, but still going on), and I suppose it's corre=
ct
> >> as provided by the IP designer.
> >=20
> > For testing, you could have logged when this condition is actually hit=
=20
> > in the first place. I usually do that to increase my own confidence if =
the=20
> > problem is particularly hard to reproduce.
>=20
> thanks for the kind and useful guidance :) did add a log message in the
> workaround branch so we'll know if the issue hits.
>=20
> >=20
> > I don't know if it always triggers PSLVERR or if that's some % of !(sta=
tus=20
> > & (UART_LSR_DR | UART_LSR_BI)) cases because RBR read is racy with Rx b=
ut=20
> > that could also be determined if similar debug is applied without the=
=20
> > patch, I guess.
>=20
> as the PSLVERR is caused by the reading of RBR so even in the latter case
> we should still using the SRBR here if availabe to avoid the PSLVERR as
> long as we enter this branch, I suppose this should be the safest way.

I was not commenting on how to fix it, but about probabilty of hitting=20
PSLVERR when taking this branch.

Rx coming in (it's racing with the driver's code) may make the read not=20
result in PSLVERR even when this branch is taken. It could be this does no=
=20
matter and taking this branch in practice always results in PSLVERR if RBR=
=20
is read, which means even any hit of this branch confirms SRBR does indeed=
=20
work.

But if RBR reads do not always lead to PSLVERR because incoming Rx makes=20
RBR read "safe" it's less clear how many times the branch should be taken=
=20
before confidently declaring the fix works.

> > But with clearly more boots and it working, that's probably enough as=
=20
> > evidence together with the issue report offering it as a workaround.
> >=20
>=20
> sure, will wait a bit and try to catch the condition.
>=20
> thanks.
>=20

--=20
 i.

--8323328-1984840293-1782895532=:7215--
