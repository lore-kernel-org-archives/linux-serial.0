Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF72EA732;
	Fri, 24 Jul 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862851; cv=none; b=NqIOK9VezNBtGzAXTWrcBtzfhUFCUSjRaIrN8n2KiAblhiIOqZQhmRpVQ2iqf3upADPUxO4ulPs1GTXfTWQos+R6v3Ocs8cN72/U0np655JUD5BGBpHVD6g0KqaLeRAeFlTQSbGEhaKaPhlR1pzP8r8t742Hbo3s71FuSGFhFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862851; c=relaxed/simple;
	bh=e5+EFwze2vEniuoo+08d6MDJBlDhz74Z7aSSIgq4InE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ECERnmYYG3wOkGLu5ID7vgSqJyzO7TVfjky+5WMnY6Rdu2jW/QIqG3wGTVNuhRBHWQTJAkoXz9pA7CSJMrKL/0KsN6MU+9eJ9hwqJ1AOHxkThAre4xUWbTDiICukHnUlnJfaadQV77o664bWhGso4aVz+eJwY6xll+wdunY4WDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ke12OLcs; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ke12OLcs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=fEDzOixFSMxgkp+/f8IjI8whpd0/a5Ff7oFNAskaaEQ=; b=ke12OLcspF8AGMZgGJXnaBV7mt
	xhezH0Df/SgFu+lN9SgNtVmLG/3Lbmpd30DmXWZPFwAoYDRlaIpp+9f+3f6YhTdanXjXF3C6jAzP+
	rZJg6JVklkmHaLYY5KiR616njcidrsTGttUF84gdk67/aoxWDALZrXumiCYTbT9qio9c=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wn6MJ-000000003wj-42vM;
	Thu, 23 Jul 2026 23:14:00 -0400
Date: Thu, 23 Jul 2026 23:13:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-Id: <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
In-Reply-To: <amGYgUhPrSdR5srV@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
	<al34uIyOue73MMN0@monoceros>
	<20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
	<al6PfMCuRiYcOBQV@monoceros>
	<20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
	<amGYgUhPrSdR5srV@monoceros>
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

Hi Uwe,

On Thu, 23 Jul 2026 06:37:17 +0200
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Hugo,
>=20
> On Mon, Jul 20, 2026 at 06:53:26PM -0400, Hugo Villeneuve wrote:
> > On Mon, 20 Jul 2026 23:18:47 +0200
> > Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
> >=20
> > > On Mon, Jul 20, 2026 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> > > > Hi Uwe,
> > > >=20
> > > > On Mon, 20 Jul 2026 12:31:31 +0200
> > > > Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com>=
 wrote:
> > > >=20
> > > > > On Mon, Jul 20, 2026 at 10:08:12AM +0200, Uwe Kleine-K=F6nig (The=
 Capable Hub) wrote:
> > > > > > With CONFIG_SERIAL_8250_HUB6 configured as module
> > > > > > (CONFIG_SERIAL_8250_HUB6=3Dm) the cpp symbol CONFIG_SERIAL_8250=
_HUB6 isn't
> > > > > > defined (only CONFIG_SERIAL_8250_HUB6_MODULE is). In this case
> > > > > > hub6_match_port() is defined in drivers/tty/serial/8250/8250.h =
as static
> > > > > > inline and in drivers/tty/serial/8250/8250_hub6.c as normal fun=
ction.
> > > > > >=20
> > > > > > Use IS_ENABLED() to also handle the modular case correctly.
> > > > > >=20
> > > > > > Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> > > > > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-k=
oenig@baylibre.com>
> > > > > > ---
> > > > > >  drivers/tty/serial/8250/8250.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/seria=
l/8250/8250.h
> > > > > > index 9d1068d0489d..fb9a7117d145 100644
> > > > > > --- a/drivers/tty/serial/8250/8250.h
> > > > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > > > @@ -334,7 +334,7 @@ int fintek_8250_probe(struct uart_8250_port=
 *uart);
> > > > > >  static inline int fintek_8250_probe(struct uart_8250_port *uar=
t) { return 0; }
> > > > > >  #endif
> > > > > > =20
> > > > > > -#ifdef CONFIG_SERIAL_8250_HUB6
> > > > > > +#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
> > > > > >  bool hub6_match_port(const struct uart_port *port1, const stru=
ct uart_port *port2);
> > > > > >  #else
> > > > > >  static inline bool hub6_match_port(const struct uart_port *por=
t1, const struct uart_port *port2)
> > > > > >=20
> > > > > > base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
> > > > >=20
> > > > > There is an earlier fix already at
> > > > > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hug=
o@hugovil.com/
> > > > >=20
> > > > > It's a bit different, but essentially equivalent. So please stick=
 to
> > > > > that older patch.
> > > >=20
> > > > They are not essentially equivalent. If=20
> > > > CONFIG_SERIAL_8250=3Dy and CONFIG_SERIAL_8250_HUB6=3Dm, and using
> > > > IS_ENABLED() gives this linker error:
> > > >=20
> > > > ld: vmlinux.o: in function `uart_match_port':
> > > > (.text+0x723aac): undefined reference to `hub6_match_port'
> > > >=20
> > > > Using IS_REACHABLE() fixes this.
> > >=20
> > > Oh, I read too quickly over the dependencies, I thought
> > > SERIAL_8250_HUB6's
> > >=20
> > > 	depends on SERIAL_8250 !=3D n && ISA && SERIAL_8250_MANY_PORTS
> > >=20
> > > would prevent that. With this configuration and IS_REACHABLE I wonder=
 if
> > > it's an issue that hub6_match_port() returns false in
> > > drivers/tty/serial/serial_core.c.
> >=20
> > I forgot to mention that I temporary removed ISA in Kconfig to be able
> > to build and test it...
>=20
> I guess that means, you don't have hardware either to test here.

Correct. I meant "test it" to "test if it compiles without
warnings/errors"

=20
> For me the open question remains if the driver works in the
> configuration CONFIG_SERIAL_8250=3Dy (and thus CONFIG_SERIAL_CORE=3Dy) +
> CONFIG_SERIAL_8250_HUB6=3Dm. In this case at least commit
> 3d406299d8829747fe2e8692f4c29fe3dc1d101f +
> https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugovi=
l.com/
> introduces a logical change in uart_match_port() that isn't explained in
> the commit log.

Not sure what you mean by that logical change?

--=20
Hugo Villeneuve
