Received: from ocn-bld-mts-104c1.ocn.ad.jp (ocn-bld-mts-104c1.ocn.ad.jp [153.128.188.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A64756BA;
	Tue,  4 Aug 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.128.188.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852341; cv=none; b=iOzm4W1neYgZoWztLvbqD3ArHyY9W8X6B55VAYn+luvbGWC9Uf2B9+0ciegfxeGgw+Wb0XFpdYN2QEEBKemmImTNWklgWgRafZG37AeDLzKd2P9L0MBer9YUi+diWHrg7JAfwfv+TOLaZrQ40xV51WxrVPVTyQRukMs/Ekb4DbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852341; c=relaxed/simple;
	bh=Whp2NjyIGiV0j+LXfGAWIO5Gr8D/xUC9Ho9lcNnbdWY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mzHtLapJqQ7bFbc9ETfsDJqwTWxzK3RoUyMi0fJ7ikSKVh1QGWlxhtjGqjsHE7dw+R5sT/v8GyMr/4pNeaGeB6UkPm/tnNjNvZRMeh4hZo13ceoTQzohf05p9kTpt3tBlidcJ2dN2spydfFdVxsOhkz9FCWnd7Nm0VcKODLPVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp; spf=pass smtp.mailfrom=mba.ocn.ne.jp; dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b=hvO5QNN8; arc=none smtp.client-ip=153.128.188.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b="hvO5QNN8"
Received: from ocn-spm-mts-101c1.ocn.ad.jp (ocn-spm-mts-101c1.ocn.ad.jp [153.128.190.226])
	by ocn-bld-mts-104c1.ocn.ad.jp (Postfix) with ESMTP id A7FC41492;
	Tue,  4 Aug 2026 23:05:36 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mba.ocn.ne.jp;
	s=20240118; t=1785852336;
	bh=Whp2NjyIGiV0j+LXfGAWIO5Gr8D/xUC9Ho9lcNnbdWY=;
	h=Date:To:Cc:Subject:From:In-Reply-To:References:From;
	b=hvO5QNN8NbuddrS7CQZPtAzg5Ni3IKVP0oB+a7E/sT20aN55GceKojAFnY5gbl7JP
	 T1gPcvoWeO+PW7j/raDpEbG+eIRuMa9TokEMpwfvirlWXHOcT+0DyD2rb+cAw80p8+
	 KWw0fSLzXLjFFtZIFyzMKhOqtNcwJDBn5eiDWZNIc5a7qzNloPYMG1ZQwSXMd+efb+
	 h4eZV5L6+VSR/s+DBwr+s/jORCNgp4Ijbjxc8EBMOKhJQZmTj9qXaIdKFyzmSLRm19
	 zUlYxTmjFnzJqOI0D5z6d5d6SES+avbdoqCTEd33JZJ1+hrgrVX5GvX9iK1nrqGACk
	 LuyNHbSyLG6dg==
Received: from ocn-vc-mts-111c1.ocn.ad.jp ([153.149.236.164])
 by ocn-spm-mts-101c1 with ngmta
 id 77e33579-18c89f3cfec66c7b; Tue, 04 Aug 2026 23:05:36 +0900
Received: from ocn-sdpx-mts-110c1.ocn.ad.jp ([153.128.117.202])
 by ocn-vc-mts-111c1 with ngmta
 id f04fefb6-18c89f3cef137a69; Tue, 04 Aug 2026 23:05:36 +0900
Received: from localhost (p1601136-ipoe.ipoe.ocn.ne.jp [114.172.254.135])
	by ocn-sdpx-mts-110c1.ocn.ad.jp (Postfix) with ESMTPA;
	Tue,  4 Aug 2026 23:05:36 +0900 (JST)
Date: Tue, 04 Aug 2026 23:05:36 +0900 (JST)
Message-Id: <20260804.230536.670060570505120005.anemo@mba.ocn.ne.jp>
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

Please drop this patch from your series.

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

