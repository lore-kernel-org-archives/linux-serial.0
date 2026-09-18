Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54B43499F;
	Fri, 18 Sep 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725398; cv=none; b=E9DwoQQWSsY8WpX1zr+Y+OIbj7qzPus4AY414s/3oL9AfcG0eNZEJPvKxDgiPUeEDkka1U8/wxFLTiu1T9HYbdquc9m1eSg/nS6vqBUfpCEhDYH9Ccj3AvKMW5f3l4d4tB4qgawXXjYpi+n/lAZ4OIwjtlCLzPnLyPEtFdwAZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725398; c=relaxed/simple;
	bh=CiSEb/w/hPKGx+1V5IuqF0CcPhReOR0zTYDnVEtbQJE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AAk90x56NsHWUYeXToGXCVle2ztlsNqGs5267n8FdgXmwWGXExto/LZ0+XZLoCMQObAchPTF93JTBusHV8iLJkjFqTmNgaD7gzaN5LLi4vEZk7Z17mxPYNr9aulzMlpP5zWf/6IUX9FI0/T8B08PaCh0zMJTogFdAcSxMK7DIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMrOfFAK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMrOfFAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725397; x=1821261397;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CiSEb/w/hPKGx+1V5IuqF0CcPhReOR0zTYDnVEtbQJE=;
  b=AMrOfFAKV6LhnoXrZ8wUHRqAIKlOeZ2eybCDMCcEZwPS4bzuJv15ny1H
   uHeSjOgoxhs9gA6c9fLdLnDj56nDAfG6wEgwmrmOWQYdVwtROOUxbj2Kq
   oOEK0DbeIzuZ0SDSvkA71cun3bNgY1QUPa9aetO7Olz4MV2ob0VkvzSrS
   Z/6Bba1RGccHHfS+Gjnyd+Wij+Vd7b24S5L36zGQwgCrUwiBODC5wqEpO
   r3h0+g9mxzma4JQgHPo87ilOxraZlcnQGFwl42hfkcPkGEBkHxVVKNvTU
   AyjZAQSuLasuiT/CVMVnNMWsH99H0qJKKmn4UeXvxuwWESZ0T5HjQ+JDS
   Q==;
X-CSE-ConnectionGUID: NWRiygS6TqapUKMNqCmDjg==
X-CSE-MsgGUID: r2UGSjiXR7SNgbLSxolPdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100817903"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100817903"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:56:36 -0700
X-CSE-ConnectionGUID: JmGyV9RqTd64rl9Pt6oRVg==
X-CSE-MsgGUID: LsAFugHUT72pesSc5w3tJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2547012"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:56:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Sep 2026 12:56:24 +0300 (EEST)
To: Moteen Shah <m-shah@ti.com>
cc: "Kumar, Udit" <u-kumar1@ti.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
    devicetree@vger.kernel.org, gehariprasath@ti.com, vigneshr@ti.com, 
    nm@ti.com, a-limaye@ti.com, y-abhilashchandra@ti.com
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty
 FIFO read
In-Reply-To: <307c005e-9a37-41cc-871a-6167a54d3a37@ti.com>
Message-ID: <ee666d60-1838-c54a-375b-1173b8140c01@linux.intel.com>
References: <20260916085520.2259420-1-m-shah@ti.com> <20260916085520.2259420-3-m-shah@ti.com> <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com> <5801b899-8090-4bff-b4e2-c3e8c97b0eb3@ti.com> <d82f9326-6a01-2903-a1b7-b1617ca85db9@linux.intel.com>
 <307c005e-9a37-41cc-871a-6167a54d3a37@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-980105281-1789725384=:15314"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-980105281-1789725384=:15314
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 18 Sep 2026, Moteen Shah wrote:

> Hey=C2=A0Ilpo,
>=20
> On 17/09/26 15:10, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 16 Sep 2026, Kumar, Udit wrote:
> > > On 9/16/2026 4:22 PM, Ilpo J=C3=A4rvinen wrote:
> > > > On Wed, 16 Sep 2026, Moteen Shah wrote:
> > > >=20
> > > > > dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no da=
ta
> > > > > present, to avoid an interrupt storm. The UART core also performs
> > > > > unconditional reads on the empty FIFO during startup and shutdown
> > > > > of the port. On the IP version used in TDA54, that interrupt stor=
m
> > > > > no longer occurs, but reading an empty FIFO instead triggers a da=
ta
> > > > > abort.
> > > > >=20
> > > > > Add a new capability to guard against the empty FIFO reads, avoid=
ing
> > > > > the data aborts.
> > > > >=20
> > > > > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > > > > ---
> > > > >   drivers/tty/serial/8250/8250.h      |  1 +
> > > > >   drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
> > > > >   drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
> > > > >   3 files changed, 25 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/tty/serial/8250/8250.h
> > > > > b/drivers/tty/serial/8250/8250.h
> > > > > index 77fe0588fd6b..45e13c3a8c14 100644
> > > > > --- a/drivers/tty/serial/8250/8250.h
> > > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > > @@ -86,6 +86,7 @@ struct serial8250_config {
> > > > >   =09=09=09=09=09 * STOP PARITY EPAR SPAR WLEN5
> > > > > WLEN6
> > > > >   =09=09=09=09=09 */
> > > > >   #define UART_CAP_NOTEMT=09BIT(18)=09/* UART without interrupt o=
n
> > > > > TEMT available */
> > > > > +#define UART_CAP_RXFIFO_EMPTY_READ=09BIT(19) /* UART needs LSR_D=
R
> > > > > check before RX read (TDA54) */
> > > > IMO, this define naming contradicts with the comment because you
> > > > effectively say "capable of reading Rx while receive buffer is empt=
y",
> > > > not
> > > > that it needs DR check before issuing that read on buffer (~ named
> > > > exactly
> > > > opposite of the actual meaning it is being used in the code).
> > > >=20
> > > I echo your comments; the naming should reflect that the IP does not
> > > allow reading an empty FIFO.
> > I now recalled we've also the pending RBR -> SRBR change:
> >=20
> > https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong=
@picoheart.com/#t
> >=20
> > I wonder if a similar thing would help in this case as well?
> >=20
> > I understand this patch covers more ground than the SRBR patch but can =
the
> > IP used in this case read SRBR without aborting?
>=20
> The IP that TDA54 uses does not supports the shadow registers, hence we w=
ill
> have to go through the quirk/capability path.

Fair. Thanks for confirming.

--=20
 i.

--8323328-980105281-1789725384=:15314--
