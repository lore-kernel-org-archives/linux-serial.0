Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE23D333E;
	Mon, 27 Apr 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299486; cv=none; b=P9QoO5fxur1WShlJAT1MWoFXrc1d2D03lLjNWh3tHwepmnMavjgOt+YxMG/dr0mWT2yVC1uOBepYhfyRqvVqRP9ABqGLWqn6DK3yBlhj22StzPmtdowotWGinAS/skjOQJzgQGAVd21sXdb/R3CeOFaxkckqXbxvI7mRjWmX9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299486; c=relaxed/simple;
	bh=sgY5aEJJ3v5d+Mq0nCfd0fbMxXlwsVz9Ah3lGaHEXBY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fi1NG+RH7+pOaDQA+HgXhC/jlfipPw8ojkogYaHqHhCSupyC+Ymmj4t33uT/EgPYiIfLihvLHlzensuOyLYRdtDFoMOwohB+iKxzF8INIzDpEX/i+rdwTzeooYZFW4wXvv1VIqRpvVjhGsYistC2XxAlSIm1cMR4Xfu7qZcuBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=W+SFCBIY; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="W+SFCBIY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=TY056H8mtdbDch+SCcPASDWVOy+uPCBnhCeT6u102UM=; b=W+SFCBIYV0T8adN3AWjMZULIjA
	Cn1uHmQ6nYIr31jqolooxCdWEvN4DDc2aunATFnk/CoaWO7mAftAjfEtweR9F9dcTz0Z+e7OHLusI
	mYJT7MpvPJDSKTIzHZrXdHnApkoKLGrPa4U6/5xZ40aqGjEBox0VAhCb3Xv5cdfjCfuo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHMmh-000000002xe-19lN;
	Mon, 27 Apr 2026 10:18:03 -0400
Date: Mon, 27 Apr 2026 10:18:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/9] serial: core: use uart_iotype_*() to simplify code
Message-Id: <20260427101802.fa669437afaa38619cde3ac2@hugovil.com>
In-Reply-To: <abe6c6b3-7e9a-b9bc-80e9-2f5294f2095c@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
	<20260423-tty-upio-v1-2-baf82d3b86d1@dimonoff.com>
	<716918cf-b240-43cc-a702-9b3d94dc75d2@linux.intel.com>
	<20260424113046.f792a805ef0507638e95b963@hugovil.com>
	<20260427094639.73a7e27709e466fda2356a4d@hugovil.com>
	<abe6c6b3-7e9a-b9bc-80e9-2f5294f2095c@linux.intel.com>
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

On Mon, 27 Apr 2026 17:16:11 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Mon, 27 Apr 2026, Hugo Villeneuve wrote:
>=20
> > On Fri, 24 Apr 2026 11:30:46 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> >=20
> > > On Fri, 24 Apr 2026 14:13:02 +0300 (EEST)
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >=20
> > > > On Thu, 23 Apr 2026, Hugo Villeneuve wrote:
> > > >=20
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > >=20
> > > > > Make use of new functions uart_iotype_mmio() and uart_iotype_lega=
cy_io()
> > > > > to simplify and improve code readability.
> > > > >=20
> > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > ---
> > > > >  drivers/tty/serial/serial_core.c | 24 +++++++++---------------
> > > > >  1 file changed, 9 insertions(+), 15 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/seria=
l/serial_core.c
> > > > > index b1cf45a8fc854cd97e349ff077d83b42e3ef8b16..fc273f8f9e75de89d=
ca1ac1aca3589567bcf8a18 100644
> > > > > --- a/drivers/tty/serial/serial_core.c
> > > > > +++ b/drivers/tty/serial/serial_core.c
> > > > > @@ -3221,23 +3221,17 @@ bool uart_match_port(const struct uart_po=
rt *port1,
> > > > >  {
> > > > >  	if (port1->iotype !=3D port2->iotype)
> > > > >  		return false;
> > > > > -
> > > > > -	switch (port1->iotype) {
> > > > > -	case UPIO_PORT:
> > > > > -		return port1->iobase =3D=3D port2->iobase;
> > > > > -	case UPIO_HUB6:
> > > > > -		return port1->iobase =3D=3D port2->iobase &&
> > > > > -		       port1->hub6   =3D=3D port2->hub6;
> > > > > -	case UPIO_MEM:
> > > > > -	case UPIO_MEM16:
> > > > > -	case UPIO_MEM32:
> > > > > -	case UPIO_MEM32BE:
> > > > > -	case UPIO_AU:
> > > > > -	case UPIO_TSI:
> > > > > +	else if (uart_iotype_mmio(port1->iotype))
> > > > >  		return port1->mapbase =3D=3D port2->mapbase;
> > > > > -	default:
> > > > > +	else if (uart_iotype_legacy_io(port1->iotype))
> > > > > +		if (port1->iobase !=3D port2->iobase)
> > > > > +			return false;
> > > > > +		else if (port1->iotype =3D=3D UPIO_HUB6 && port1->hub6 !=3D po=
rt2->hub6)
> > > >=20
> > > > I suggest placing the entire hub6 related check (including the ioba=
se=20
> > > > check) into own function in 8250_hub6.c and add a stub for the case=
 when=20
> > > > hub6 code is not even built into kernel into 8250.h.
> > >=20
> > > Neat. I will make a separate commit for that in V2. This
> > > simplifies uart_match_port() even more...
> >=20
> > I implemented it, the only thing I am not sure about is the include of
> > "8250/8250.h" in serial_core.c?
>=20
> I'd just include it and add comment before it that it's included because=
=20
> of UPIO_HUB6 port matching.
>=20
> The more generic alternative would be to make the matcher a callback but=
=20
> that feels overkill for some legacy iotype trick, IMO.

Great, I will submit v2 then with the include and the associated
comment.

Thank you,
Hugo.
