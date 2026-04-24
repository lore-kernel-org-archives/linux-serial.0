Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5A31E820;
	Fri, 24 Apr 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044650; cv=none; b=SH+/vm6YeMuWvO7TLWq/pijufMWgsm+uiVuYzpNAOSoi07vvC+u9wGVp9/Jc1xCxBhEl8NbVS5JKvUjNJ1Fif+o1pVItSSkg6P0mlrLP6omVrCEVtofrjOoFGLVU5IjgbZ1GrUbJjdO9kBnb8M3RuzITbTL41ctgkcpC3ddAgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044650; c=relaxed/simple;
	bh=ByqMYAUG+OvDr+RYzgQj6WdcqFkXOs8j2KXJtNkAPDQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tFxt9GAcAUl318OLY6KSp8P+UAQypbvBmRwsBGFQeEfAwiXxiqsRKJfF1KrpF5xQ9F3t9Qttm4nVx32iZn2j/vOL1+pp/dTOXDoCzqzgwVkrPNcNw3KGqbq5CyHrR45s+sVw+q1UirPqt4nv0j3yFc40cdDIH1qYJtGrFMUwYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=D/Hq1H/A; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="D/Hq1H/A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=dtA8WTFtXgGsxzP6LANnCD3/LSeQlhp9LEMuY0Z12NM=; b=D/Hq1H/AbgQGrG4iEEbdrtqFs+
	Xrw1i0GgQi8qtPEY7uGxJmTA0ue4EM9RRdhn63EjSeoxN4ORQ7+rULEH5YzxrCOab1qQm4dacgDoK
	Ki34wT4Dh7w/pXXGKABrV7AsviH/wIxAFx20zOmepwThWuze2YqSs8Cp3sgjgUzOZ/XA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wGIUQ-000000004MP-3sHt;
	Fri, 24 Apr 2026 11:30:46 -0400
Date: Fri, 24 Apr 2026 11:30:46 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/9] serial: core: use uart_iotype_*() to simplify code
Message-Id: <20260424113046.f792a805ef0507638e95b963@hugovil.com>
In-Reply-To: <716918cf-b240-43cc-a702-9b3d94dc75d2@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
	<20260423-tty-upio-v1-2-baf82d3b86d1@dimonoff.com>
	<716918cf-b240-43cc-a702-9b3d94dc75d2@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

On Fri, 24 Apr 2026 14:13:02 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 23 Apr 2026, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
> > to simplify and improve code readability.
> >=20
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index b1cf45a8fc854cd97e349ff077d83b42e3ef8b16..fc273f8f9e75de89dca1ac1=
aca3589567bcf8a18 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -3221,23 +3221,17 @@ bool uart_match_port(const struct uart_port *po=
rt1,
> >  {
> >  	if (port1->iotype !=3D port2->iotype)
> >  		return false;
> > -
> > -	switch (port1->iotype) {
> > -	case UPIO_PORT:
> > -		return port1->iobase =3D=3D port2->iobase;
> > -	case UPIO_HUB6:
> > -		return port1->iobase =3D=3D port2->iobase &&
> > -		       port1->hub6   =3D=3D port2->hub6;
> > -	case UPIO_MEM:
> > -	case UPIO_MEM16:
> > -	case UPIO_MEM32:
> > -	case UPIO_MEM32BE:
> > -	case UPIO_AU:
> > -	case UPIO_TSI:
> > +	else if (uart_iotype_mmio(port1->iotype))
> >  		return port1->mapbase =3D=3D port2->mapbase;
> > -	default:
> > +	else if (uart_iotype_legacy_io(port1->iotype))
> > +		if (port1->iobase !=3D port2->iobase)
> > +			return false;
> > +		else if (port1->iotype =3D=3D UPIO_HUB6 && port1->hub6 !=3D port2->h=
ub6)
>=20
> I suggest placing the entire hub6 related check (including the iobase=20
> check) into own function in 8250_hub6.c and add a stub for the case when=
=20
> hub6 code is not even built into kernel into 8250.h.

Neat. I will make a separate commit for that in V2. This
simplifies uart_match_port() even more...

Thank you,
Hugo.


>=20
> > +			return false;
> > +		else
> > +			return true;
> > +	else
> >  		return false;
> > -	}
> >  }
> >  EXPORT_SYMBOL(uart_match_port);
> > =20
> >=20
> >=20
>=20
> --=20
>  i.
>=20
>=20


--=20
Hugo Villeneuve
