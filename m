Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578AC3DF00C;
	Tue, 30 Jun 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843522; cv=none; b=ZovMN8RuCv1ylOM593tjRE0z/ecz8RZ56whfq3Ci82RofK8Qks4/6ETIihwxdtDqeSu2uytQKUpWh8j929D8euikTtZXzgdW1QdH7uzWSVWpdqfLxIK409k/7Lgg81VeyPOt8WT0JSWlK7yk35XnEpSVdYkVoeBvl5NyoFQgH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843522; c=relaxed/simple;
	bh=xQcz5viEPxIy7Q6O2iMobZFw84gWnJVuy18+an3bi1I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lDRSYwtPAtNp85drxqIFRnQKNRgHcr57j0oLhLKQZ9ieRYb0+ygwls+Xq/GB1f1TqooCEZmoKWvFAFIJScrmLtsjfTex6copj1PUpNqgufWSN22atAImMzQgtJnrMgK5sRNRfg8bX+E1yevfWbamYxoSR2mQfD8jENX/5rShBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhy+P1H3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhy+P1H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782843521; x=1814379521;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xQcz5viEPxIy7Q6O2iMobZFw84gWnJVuy18+an3bi1I=;
  b=jhy+P1H3MAFXwC9E4xKWT1X3U6tdQrAG3LtJkzpPaW8ZIMllVD1ddhJF
   aOmbL9QD0YC77FdxWumArDTD/ZiCtEg8U9jpAvbyXA5eIIsSmuap2EdYK
   0MVxuAIOCf5Jlzc4YAcbyCiBLKjZ8mJTO+z9MD1QjK7zOMAlTeqKs5NsJ
   U21C9BELeWm+bvUtD0QdS9kbSOOX4sVoq2YWlNSSxrE8OzTOyPJ5QfdfM
   uRjCLBw2GiKrppSg1jamaPQWCKOvqKHy5OpsYplqP5ByD3llRtraSGmbS
   YBUg1Mj2YOkQU0Ix2F4KcmqpwbKAuyh/Vjk+lzU3AEz9pyoLDbj1Cfels
   g==;
X-CSE-ConnectionGUID: lxWRsXuuTwW5WokixG6GtA==
X-CSE-MsgGUID: UZBVK1XHRMy9g5HNoi3CFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83564293"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83564293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 11:18:41 -0700
X-CSE-ConnectionGUID: hTIKRTmERDCb/hiBEvLYDw==
X-CSE-MsgGUID: o9JNKwOkTgeYNybx1T1ayA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="257247532"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.230])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 11:18:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Jun 2026 21:18:33 +0300 (EEST)
To: Yicong Yang <yang.yicong@picoheart.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, geshijian@picoheart.com, 
    yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround
 if available
In-Reply-To: <877fc902-7b8d-454c-8346-de1087edcdc4@picoheart.com>
Message-ID: <c017f37a-5873-2716-96e7-3deb46eff1a8@linux.intel.com>
References: <20260629075510.32854-1-yang.yicong@picoheart.com> <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com> <877fc902-7b8d-454c-8346-de1087edcdc4@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-143634707-1782843513=:1167"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-143634707-1782843513=:1167
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 1 Jul 2026, Yicong Yang wrote:
> On 6/29/26 11:56 PM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 29 Jun 2026, Yicong Yang wrote:
> >=20
> >> The DW uart could get into the cases where a bogus RX timeout
> >> interrupt is asserted but no available data. This could be
> >> workaround by doing a bogus read.
> >>
> >> Currently the driver's using the standard RBR (receive buffer
> >> register) for this bogus read. However the reading of RBR
> >> in this case is allowed to raise a hardware error if vendor
> >> choose to implement in this way (our platform). It's also
> >> allowed to do the bogus read using SRBR (shadow RBR) for
> >> workaround which won't raise the hardware error. So change
> >> to use the SRBR to workaround the issue if it's available.
> >>
> >> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
> >>  drivers/tty/serial/8250/8250_dwlib.c |  3 +++
> >>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
> >>  3 files changed, 20 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/82=
50/8250_dw.c
> >> index 84ffba045ffa..fea7dfa30e78 100644
> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> @@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>  =09if (!up->dma && rx_timeout) {
> >>  =09=09status =3D serial_lsr_in(up);
> >> =20
> >> -=09=09if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >> -=09=09=09serial_port_in(p, UART_RX);
> >> +=09=09if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >> +=09=09=09/*
> >> +=09=09=09 * Do the bogus read from Shadow RBR (SRBR) if provided.
> >> +=09=09=09 * Both RBR and SRBR are supported ways to workaround
> >=20
> > Hi,
> >=20
> > I've not come across this being mentioned anywhere else than in kernel=
=20
> > related context, but you seem to imply there something that tells about=
=20
> > "supported ways"?
> >=20
>=20
> in fact we got this workaround method that's documented in the synopsys
> dw_uart issue report, so comment "supported" here. quote the related part
> of the workaround below:
>=20
>   [read USR[3] for the rx fifo status]
>   If the read value is '0' (indicating the RX FIFO is empty), do a dummy
>   read of the RBR or shadow RBR (SRBR) register without processing the
>   invalid read data.
>=20
>   ...Note: Reading the RBR results in a PSLVERR immediately if
>   REG_TIMEOUT_WIDTH parameter is set to '0'. Whereas, reading SRBR does
>   not result in PSLVERR.

Okay, thanks.

> > If there's no such thing, I'm bit hesitant to declare presence of SRBR=
=20
> > guarantees reading it universally solves this issue.
> >=20
> > BUT, I suppose it does on your HW since you must have hit this code pat=
h,=20
> > and thus PSLVERR, yourself to actually discover this issue so I assume=
=20
> > you've then also confirmed that this patch solves the issue in your cas=
e=20
> > which isn't entirely without merit either.
> >=20
>=20
> actually it's hard to reproduce, only once at boot time in our several
> hundreds reboot test. we locate the code line here by the backtrace of
> the system error. the issue hasn't reproduced yet on the patched kernel
> (hundred reboots so far, but still going on), and I suppose it's correct
> as provided by the IP designer.

For testing, you could have logged when this condition is actually hit=20
in the first place. I usually do that to increase my own confidence if the=
=20
problem is particularly hard to reproduce.

I don't know if it always triggers PSLVERR or if that's some % of !(status=
=20
& (UART_LSR_DR | UART_LSR_BI)) cases because RBR read is racy with Rx but=
=20
that could also be determined if similar debug is applied without the=20
patch, I guess.

But with clearly more boots and it working, that's probably enough as=20
evidence together with the issue report offering it as a workaround.

--=20
 i.

--8323328-143634707-1782843513=:1167--
