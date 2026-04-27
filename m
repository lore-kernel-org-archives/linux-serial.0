Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68521386C31;
	Mon, 27 Apr 2026 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299380; cv=none; b=tCykARvxmc+ounDXS3bJCgUVvCh2/+GiGbCZEpRJ+dNmssNvS7p8LmcTNppzhYw/asZlTTugar+KrYS1mF2abx0jFdfUmBN2JSoABTqTB0LfXAjn9FO2tVbrwGw4nTY4xwXuMe4QYXHt/yXCyViTI+sa5epFFflzzlh85NejlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299380; c=relaxed/simple;
	bh=8cNFVH6Qkijl05w8wP3IzU0XRMf45PNVMAGGOwYpidI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WQg/K/N1HxFSNMaJrQ1s9RSY81yDZxubIcX+k+m32bIxy+oJO3os05qARdF4MGXqiCwvlEw4r3NXm4Cwo+DH5Xc6EpaqxFctR4nrU6P5ab4sah0JRB3g8oYougNDzZ2Ry0VnvR+KdTpWyPW4kxwJTbHr3u3GjfBUCpBa5JiqrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHa7f8Zv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHa7f8Zv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777299379; x=1808835379;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8cNFVH6Qkijl05w8wP3IzU0XRMf45PNVMAGGOwYpidI=;
  b=WHa7f8ZvZha086k6M6L7BeoW4EcEolpiKk4kWQSdgBU+jwutkFFxiyiN
   IeivAy+XBasj3Fem3qNBPEnSB8WJ+u9DbEoizL6bO+hYpU5LdGHoqrBca
   4y3efab8x8V0rvtSQhUsH1kIJnTB6MK20TIpV0NlRzmXDqeUuwqy88afL
   4hQYgsbf0Wt1nOHfssKdt9nKrHYE4gLxYyG9xURF6JD8FpQrE+SVf1LHN
   4jogZDOFJcTZ3UYr090Z2WV61S7kdxoE5LPOqvmDrL2LIzSbACpsb8pGc
   a9MmQwY4m0pIwgG963j6GqixZ05tCclwocd7wkyJWYqhUz4NhsIv5tkDM
   Q==;
X-CSE-ConnectionGUID: L5U79Ac4RXSdfrBo+wksKw==
X-CSE-MsgGUID: CtkhJ6WqRbOHwqk29NCopg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77214238"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77214238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:16:18 -0700
X-CSE-ConnectionGUID: KYUYqTB7Tu68DyejJZHw9Q==
X-CSE-MsgGUID: 8WGt6uICSOmp+KdRruh8Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="256958958"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:16:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Apr 2026 17:16:11 +0300 (EEST)
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/9] serial: core: use uart_iotype_*() to simplify code
In-Reply-To: <20260427094639.73a7e27709e466fda2356a4d@hugovil.com>
Message-ID: <abe6c6b3-7e9a-b9bc-80e9-2f5294f2095c@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com> <20260423-tty-upio-v1-2-baf82d3b86d1@dimonoff.com> <716918cf-b240-43cc-a702-9b3d94dc75d2@linux.intel.com> <20260424113046.f792a805ef0507638e95b963@hugovil.com>
 <20260427094639.73a7e27709e466fda2356a4d@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-247529593-1777299371=:1301"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-247529593-1777299371=:1301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 27 Apr 2026, Hugo Villeneuve wrote:

> On Fri, 24 Apr 2026 11:30:46 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
>=20
> > On Fri, 24 Apr 2026 14:13:02 +0300 (EEST)
> > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >=20
> > > On Thu, 23 Apr 2026, Hugo Villeneuve wrote:
> > >=20
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >=20
> > > > Make use of new functions uart_iotype_mmio() and uart_iotype_legacy=
_io()
> > > > to simplify and improve code readability.
> > > >=20
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >  drivers/tty/serial/serial_core.c | 24 +++++++++---------------
> > > >  1 file changed, 9 insertions(+), 15 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/=
serial_core.c
> > > > index b1cf45a8fc854cd97e349ff077d83b42e3ef8b16..fc273f8f9e75de89dca=
1ac1aca3589567bcf8a18 100644
> > > > --- a/drivers/tty/serial/serial_core.c
> > > > +++ b/drivers/tty/serial/serial_core.c
> > > > @@ -3221,23 +3221,17 @@ bool uart_match_port(const struct uart_port=
 *port1,
> > > >  {
> > > >  =09if (port1->iotype !=3D port2->iotype)
> > > >  =09=09return false;
> > > > -
> > > > -=09switch (port1->iotype) {
> > > > -=09case UPIO_PORT:
> > > > -=09=09return port1->iobase =3D=3D port2->iobase;
> > > > -=09case UPIO_HUB6:
> > > > -=09=09return port1->iobase =3D=3D port2->iobase &&
> > > > -=09=09       port1->hub6   =3D=3D port2->hub6;
> > > > -=09case UPIO_MEM:
> > > > -=09case UPIO_MEM16:
> > > > -=09case UPIO_MEM32:
> > > > -=09case UPIO_MEM32BE:
> > > > -=09case UPIO_AU:
> > > > -=09case UPIO_TSI:
> > > > +=09else if (uart_iotype_mmio(port1->iotype))
> > > >  =09=09return port1->mapbase =3D=3D port2->mapbase;
> > > > -=09default:
> > > > +=09else if (uart_iotype_legacy_io(port1->iotype))
> > > > +=09=09if (port1->iobase !=3D port2->iobase)
> > > > +=09=09=09return false;
> > > > +=09=09else if (port1->iotype =3D=3D UPIO_HUB6 && port1->hub6 !=3D =
port2->hub6)
> > >=20
> > > I suggest placing the entire hub6 related check (including the iobase=
=20
> > > check) into own function in 8250_hub6.c and add a stub for the case w=
hen=20
> > > hub6 code is not even built into kernel into 8250.h.
> >=20
> > Neat. I will make a separate commit for that in V2. This
> > simplifies uart_match_port() even more...
>=20
> I implemented it, the only thing I am not sure about is the include of
> "8250/8250.h" in serial_core.c?

I'd just include it and add comment before it that it's included because=20
of UPIO_HUB6 port matching.

The more generic alternative would be to make the matcher a callback but=20
that feels overkill for some legacy iotype trick, IMO.

--=20
 i.

--8323328-247529593-1777299371=:1301--
