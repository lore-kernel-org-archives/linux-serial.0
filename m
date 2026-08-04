Received: from ocn-bld-mts-104c1.ocn.ad.jp (ocn-bld-mts-104c1.ocn.ad.jp [153.128.188.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81546DFEA;
	Tue,  4 Aug 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.128.188.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852512; cv=none; b=CV80kwmxvuV3ZZYoB6gVsmXw747rMmvAAtB1cEC1ipUhsKb3FLPbLOReSlpC6oaoutsokfZddvgj0NPsdbwAerg5rkHNA5NqOSFBPy3i0QGy64rCilIqksk3qSEcHI6s1KXrWqiivywWr1iZkZ5NW+9uJg/RFWFq1ptq8cpcJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852512; c=relaxed/simple;
	bh=pHkE5dyd2pOBTmeKCU2oVevCEaxGsiU+oXGiEQRRnbo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dDhcEHfynqt6iYpGBigEAcx3gax17cDBJ29JSXujZOMMgfHdimbuD1n2Bd0j5d8unoFaSlT12UGD9uBFjkocpARDrb1sEqLROKBCyAo1mS5JOXtkbw1y20rADaybh2P9jBwzNs/xFmwIMq09ARwhZw+H6pqnVhl/TdIGuEHnm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp; spf=pass smtp.mailfrom=mba.ocn.ne.jp; dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b=bIZJSXOt; arc=none smtp.client-ip=153.128.188.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b="bIZJSXOt"
Received: from ocn-spm-mts-105c1.ocn.ad.jp (ocn-spm-mts-105c1.ocn.ad.jp [153.128.190.234])
	by ocn-bld-mts-104c1.ocn.ad.jp (Postfix) with ESMTP id ABF052430;
	Tue,  4 Aug 2026 23:00:59 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mba.ocn.ne.jp;
	s=20240118; t=1785852059;
	bh=pHkE5dyd2pOBTmeKCU2oVevCEaxGsiU+oXGiEQRRnbo=;
	h=Date:To:Cc:Subject:From:In-Reply-To:References:From;
	b=bIZJSXOtmrC4V2mtK47JAWRrOiK8eL5pWLdE8yx366fbPcu99nmZ0FFqhld9uuKAW
	 FI8qLa+LvfgMUgbMY89GS2qahBSlk/+8AbTJwUnz4KxzmDZ+68pBOc7oMnQHxGzxuC
	 aJ3FZFnGHswgkeE2O0VqGkGbiWyNECvxzjP6CifWVeJpuna7Y+RceVritWvmT5qg9B
	 JCK4vYjMOu4M+zIiz1dF+5zdHnBKKRK5aapOH+JGsnl786aSfGaxLiDpIADPMuFdi6
	 5E0EFBuP4xIaxvsWAr82NRnh0hN+jBk4hjwSlpEK2TeDwKATQ/cT0IR1wUf0ieAv7j
	 UJKUrm8aJZpeA==
Received: from ocn-vc-mts-111c1.ocn.ad.jp ([153.149.236.164])
 by ocn-spm-mts-105c1 with ngmta
 id fe2e7efb-18c89efc80c0f6d6; Tue, 04 Aug 2026 23:00:59 +0900
Received: from ocn-sdpx-mts-108c1.ocn.ad.jp ([153.128.117.196])
 by ocn-vc-mts-111c1 with ngmta
 id e762416d-18c89efc6f0251d5; Tue, 04 Aug 2026 23:00:59 +0900
Received: from localhost (p1601136-ipoe.ipoe.ocn.ne.jp [114.172.254.135])
	by ocn-sdpx-mts-108c1.ocn.ad.jp (Postfix) with ESMTPA;
	Tue,  4 Aug 2026 23:00:59 +0900 (JST)
Date: Tue, 04 Aug 2026 23:00:58 +0900 (JST)
Message-Id: <20260804.230058.2181811588216184828.anemo@mba.ocn.ne.jp>
To: u.kleine-koenig@baylibre.com
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 hvilleneuve@dimonoff.com, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/8] serial: txx9: Simplify knowing that .iotype is
 always UPIO_PORT
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <b90344819432e493f54d557ec06e734e3392724f.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
	<b90344819432e493f54d557ec06e734e3392724f.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 30.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue,  4 Aug 2026 10:57:54 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> After the previous commit it's obvious that .iotype is always UPIO_PO=
RT.
> Simplify some functions accordingly.

No, .iotype can be UPIO_MEM if early_serial_txx9_setup() was called fro=
m
arch/mips/txx9/generic/setup.c.

---
Atsushi Nemoto

On Tue,  4 Aug 2026 10:57:54 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> After the previous commit it's obvious that .iotype is always UPIO_PO=
RT.
> Simplify some functions accordingly.
> =

> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/linux-serial/01a84877-9cc7-8136-d5a8-e3=
68a36cda93@linux.intel.com
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> ---
>  drivers/tty/serial/serial_txx9.c | 69 ++++--------------------------=
--
>  1 file changed, 7 insertions(+), 62 deletions(-)
> =

> diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/se=
rial_txx9.c
> index ef56979321b9..bda7f7527b8d 100644
> --- a/drivers/tty/serial/serial_txx9.c
> +++ b/drivers/tty/serial/serial_txx9.c
> @@ -158,25 +158,13 @@
>  =

>  static inline unsigned int sio_in(struct uart_port *up, int offset)
>  {
> -	switch (up->iotype) {
> -	default:
> -		return __raw_readl(up->membase + offset);
> -	case UPIO_PORT:
> -		return inl(up->iobase + offset);
> -	}
> +	return inl(up->iobase + offset);
>  }
>  =

>  static inline void
>  sio_out(struct uart_port *up, int offset, int value)
>  {
> -	switch (up->iotype) {
> -	default:
> -		__raw_writel(value, up->membase + offset);
> -		break;
> -	case UPIO_PORT:
> -		outl(value, up->iobase + offset);
> -		break;
> -	}
> +	outl(value, up->iobase + offset);
>  }
>  =

>  static inline void
> @@ -698,57 +686,15 @@ serial_txx9_pm(struct uart_port *port, unsigned=
 int state,
>  =

>  static int serial_txx9_request_resource(struct uart_port *up)
>  {
> -	unsigned int size =3D TXX9_REGION_SIZE;
> -	int ret =3D 0;
> +	if (!request_region(up->iobase, TXX9_REGION_SIZE, "serial_txx9"))
> +		return -EBUSY;
>  =

> -	switch (up->iotype) {
> -	default:
> -		if (!up->mapbase)
> -			break;
> -
> -		if (!request_mem_region(up->mapbase, size, "serial_txx9")) {
> -			ret =3D -EBUSY;
> -			break;
> -		}
> -
> -		if (up->flags & UPF_IOREMAP) {
> -			up->membase =3D ioremap(up->mapbase, size);
> -			if (!up->membase) {
> -				release_mem_region(up->mapbase, size);
> -				ret =3D -ENOMEM;
> -			}
> -		}
> -		break;
> -
> -	case UPIO_PORT:
> -		if (!request_region(up->iobase, size, "serial_txx9"))
> -			ret =3D -EBUSY;
> -		break;
> -	}
> -	return ret;
> +	return 0;
>  }
>  =

>  static void serial_txx9_release_resource(struct uart_port *up)
>  {
> -	unsigned int size =3D TXX9_REGION_SIZE;
> -
> -	switch (up->iotype) {
> -	default:
> -		if (!up->mapbase)
> -			break;
> -
> -		if (up->flags & UPF_IOREMAP) {
> -			iounmap(up->membase);
> -			up->membase =3D NULL;
> -		}
> -
> -		release_mem_region(up->mapbase, size);
> -		break;
> -
> -	case UPIO_PORT:
> -		release_region(up->iobase, size);
> -		break;
> -	}
> +	release_region(up->iobase, TXX9_REGION_SIZE);
>  }
>  =

>  static void serial_txx9_release_port(struct uart_port *up)
> @@ -983,7 +929,7 @@ static int serial_txx9_register_port(struct uart_=
port *port)
>  		uart->membase =3D port->membase;
>  		uart->irq      =3D port->irq;
>  		uart->uartclk  =3D port->uartclk;
> -		uart->iotype   =3D port->iotype;
> +		uart->iotype   =3D UPIO_PORT;
>  		uart->flags    =3D port->flags
>  			| UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
>  		uart->mapbase  =3D port->mapbase;
> @@ -1081,7 +1027,6 @@ pciserial_txx9_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *ent)
>  	port.flags |=3D UPF_TXX9_HAVE_CTS_LINE;
>  	port.uartclk =3D 66670000;
>  	port.irq =3D dev->irq;
> -	port.iotype =3D UPIO_PORT;
>  	port.iobase =3D pci_resource_start(dev, 1);
>  	port.dev =3D &dev->dev;
>  	line =3D serial_txx9_register_port(&port);
> -- =

> 2.55.0.11.g153666a7d9bb
> =

> =

