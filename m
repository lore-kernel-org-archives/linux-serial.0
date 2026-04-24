Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4123D524C;
	Fri, 24 Apr 2026 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040700; cv=none; b=HSI99R0L64nxmPmSAmmQluCb8TVj+F+xZYDZg85HgItOQCOR4n1gyazFPA/suB1P+pFOZwhk1rFj23zF852meSYAVNV7Ctc7PGeQM3oXl13LU50O8M+lwTYoDsmCQerB6OmzfdlZlr2gz0j1agloqt2nHESEakSfpjRuuUQa8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040700; c=relaxed/simple;
	bh=3tHaQlrRJzcCbsfyXKWFqdGmJHB7E+owM+IS00mnRBw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TCSHgjmk71DN7Ek98l5sV7/EoFfHeV1noVVSJO9zp21tXjxyJfBmz/9i1Hd1cVsHevF0VIwC+SzLGy2jiQ4Z0ZO7vdABXgiiatlU7lLFTPVIFxso0EWT7iv9OwcTHIEnMKWqGeyfc39mP2CgSueI7/xJoApb114VVqSLsHTfkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=HDmf/0sH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="HDmf/0sH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=MImHFePeKxiiJkzu43c6fNucMjdnzWcR7RTqMLyJy7w=; b=HDmf/0sHaEKW3XcPfLJa+K1Oqz
	CWJTMlM3spmV8KZcrepjXQ8EwvT5jUyj750gFUUZdmb29cRRlFUfY+6wJ6eizhFPR/OqZ8JVPRO+V
	amgRXdQou/lj9d66lZTqDWJOjL1VOqYd69/HZGZCcT/Wc0inT8YpbapRWKZvgjLWDPvI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wGHSi-000000006Qk-0j0h;
	Fri, 24 Apr 2026 10:24:56 -0400
Date: Fri, 24 Apr 2026 10:24:55 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 6/9] serial: core: prevent irrelevant I/O infos display
 for UPIO_BUS
Message-Id: <20260424102455.9f1c60ba937c6899bc1b9056@hugovil.com>
In-Reply-To: <96429741-16d0-3e4b-b42f-d273a2adfba7@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
	<20260423-tty-upio-v1-6-baf82d3b86d1@dimonoff.com>
	<96429741-16d0-3e4b-b42f-d273a2adfba7@linux.intel.com>
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

On Fri, 24 Apr 2026 13:51:52 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 23 Apr 2026, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > It doesn't make sense to display irrelevant MMIO or legacy I/O informat=
ion
> > for serial devices on I2C or SPI busses. Now that we have a separate I/O
> > type for these types of devices, prevent display of I/O information for
> > them. Using uart_iotype_*() functions to do so also addresses the now
> > invalid check for "iotype >=3D UPIO_MEM".
> >=20
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 50 ++++++++++++++++++--------------=
--------
> >  1 file changed, 22 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 0bfdb69817e4259681fbc4658c9a68200aa2b65f..42559eda6fc134de77c3a7b=
850d565ebdc89e216 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2011,13 +2011,18 @@ static void uart_line_info(struct seq_file *m, =
struct uart_state *state)
> >  	if (!uport)
> >  		return;
> > =20
> > -	mmio =3D uport->iotype >=3D UPIO_MEM;
> > -	seq_printf(m, "%u: uart:%s %s%08llX irq:%u",
> > -			uport->line, uart_type(uport),
> > -			mmio ? "mmio:0x" : "port:",
> > -			mmio ? (unsigned long long)uport->mapbase
> > -			     : (unsigned long long)uport->iobase,
> > -			uport->irq);
> > +	seq_printf(m, "%u: uart:%s", uport->line, uart_type(uport));
> > +
> > +	mmio =3D uart_iotype_mmio(uport->iotype);
> > +
> > +	if (mmio || uart_iotype_legacy_io(uport->iotype)) {
> > +		seq_printf(m, " %s%08llX",
> > +			   mmio ? "mmio:0x" : "port:",
> > +			   mmio ? (unsigned long long)uport->mapbase
> > +			   : (unsigned long long)uport->iobase);
>=20
> This should align to ?

Ok, my auto-indent is not working for that.

Will change it to:
    seq_printf(m, " %s%08llX", mmio ? "mmio:0x" : "port:",
               mmio ? (unsigned long long)uport->mapbase
                    : (unsigned long long)uport->iobase);

>=20
> > +	}
> > +
> > +	seq_printf(m, "irq:%u", uport->irq);
> > =20
> >  	if (uport->type =3D=3D PORT_UNKNOWN) {
> >  		seq_putc(m, '\n');
> > @@ -2482,31 +2487,20 @@ EXPORT_SYMBOL(uart_resume_port);
> >  static inline void
> >  uart_report_port(struct uart_driver *drv, struct uart_port *port)
> >  {
> > -	char address[64];
> > +	char address[64] =3D "";
> > =20
> > -	switch (port->iotype) {
> > -	case UPIO_PORT:
> > -		snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
> > -		break;
> > -	case UPIO_HUB6:
> > +	if (uart_iotype_mmio(port->iotype))
> >  		snprintf(address, sizeof(address),
> > -			 "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
> > -		break;
> > -	case UPIO_MEM:
> > -	case UPIO_MEM16:
> > -	case UPIO_MEM32:
> > -	case UPIO_MEM32BE:
> > -	case UPIO_AU:
> > -	case UPIO_TSI:
> > -		snprintf(address, sizeof(address),
> > -			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
> > -		break;
> > -	default:
> > -		strscpy(address, "*unknown*", sizeof(address));
> > -		break;
> > +			 " at MMIO 0x%llx", (unsigned long long)port->mapbase);
> > +	else if (uart_iotype_legacy_io(port->iotype)) {
> > +		if (port->iotype =3D=3D UPIO_PORT)
> > +			snprintf(address, sizeof(address), " at I/O 0x%lx", port->iobase);
> > +		else if (port->iotype =3D=3D UPIO_HUB6)
> > +			snprintf(address, sizeof(address),
> > +				 " at I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
>=20
> Please use scnprintf() so we could perhaps one day get rid of snprintf()=
=20
> entirely.

Ok will do.

>=20
> >  	}
> > =20
> > -	pr_info("%s%s%s at %s (irq =3D %u, base_baud =3D %u) is a %s\n",
> > +	pr_info("%s%s%s%s (irq =3D %u, base_baud =3D %u) is a %s\n",
> >  		port->dev ? dev_name(port->dev) : "",
> >  		port->dev ? ": " : "",
> >  		port->name,
> >=20
> >=20
>=20
> --=20
>  i.
>=20
>=20


--=20
Hugo Villeneuve
