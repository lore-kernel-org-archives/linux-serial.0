Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC218E373
	for <linux-serial@vger.kernel.org>; Wed,  2 Oct 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855372; cv=none; b=HMdGzpKN3TqyOGwBWZMxFCRWIV7okoKsq77rKWD+jRQsqZVEfNZiR5HosGbPsYEyIXR75a2r7V/OSS4q+Ms9peOL6KxPEJXT9nOzzVwrkFB9W+wx8hxzI9R/8jMSv/PW6oWbOIlRg0cmQoV8Le5tXnjGEAbCOem87rv1PuQFKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855372; c=relaxed/simple;
	bh=ny35Rkgj6x1cRIF0L+bujOfp6EHQksl8+kuHx9ju7Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv5W+pmBFNj7Ep5l3OocM2UsHS7iueOCY5ZiGWJRKpLGVAMJpvKua3iw/ehH6kEqV14vwtlAl0aRwKBbC8FYO/fNeX9XKCUNU57CRll9kR1/6cH3qiGg5P8NrQzbx5ksnGwDRBoUwQCPm92burmdFQ0LG9dD/to0K75VnxV7qqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=twuk2nY+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="twuk2nY+"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso39043701fa.1
        for <linux-serial@vger.kernel.org>; Wed, 02 Oct 2024 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727855368; x=1728460168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUkoms9GunkXf+CDYoMsUkdrCLSJw6d9DPAwVs0wJ0g=;
        b=twuk2nY+Mv/+nau5fdfkXfmz0ciZQDU1Xz7IU9wQma2fQRzKgr0KEHHamAXNK+JGqR
         hwSaS+4dI8Uymg3FkkxMldwyJ8SeqBerAsM5Q39qmeouIUlIAyPlMlsh3ZoEEsOYcL7u
         vC+q7KdgWWf8xxqLkPS2SFM4tbDvID8IlUSgd7ER2gCfJsMcgrt7CddrQCPXVdPqRsHb
         /sxAhNi1yoSSllrOoZgY4jzoDmlRwmv1DVra5lFbvCjL6F1dRjwFjIdqyku7x7TuLDIN
         tdhOmssJwfC4qnJfk8gKFUkbTW87FNWmWsXG10jAqsmMSq4T/i6xbvQhFkVShnBbTDSr
         +q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855368; x=1728460168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUkoms9GunkXf+CDYoMsUkdrCLSJw6d9DPAwVs0wJ0g=;
        b=B1toLHU6LprAzNfXFYPCHlOZ0h0xCnH/MuSF/jyj8KBOUqlc3rkDzGtp32wTd3vxKH
         6YSgu6bgVLMPOiojZwpr3HDeV9RDfxRSV52BCdYbq7SjiNNABDkKffNk+BSBo+xV3Tre
         u/nHjEKfWLhVWoIoseFZsAPJXh4SzF7L1MuV7sOJTjc02zYR4HseCLOvUH2S4baRO8kX
         qS9NYsc4fHF/Rse0usYDive/2L/E+Fbig/2rcXKReJom5yzo2eE2beea2UraZAR/tiua
         luW94qwQLnnwfF9IvRYC1LZ0mHDtQOAmWksMXO70GW0WObzEzoJo6lMnBFkGn8zBDlhs
         gxXw==
X-Gm-Message-State: AOJu0YwQklhRTC4h/wUcI8USxC/kp/x2EEswJ69ZGBMirYvzuuPHUZyi
	rTLknCd0kx5TsbsVPc67wdiZ4a8AeuVPL88V7rzbfH8LReM+kAWdJIcre3/9XXE=
X-Google-Smtp-Source: AGHT+IHhrtLPCcZ1JZ7WF1hqCK+TTK1o8oRyrEf8KMZN3BCzqjZNFUb5aL/Qmd5e3+AEbRDd424k2w==
X-Received: by 2002:a05:651c:1506:b0:2f3:f441:af24 with SMTP id 38308e7fff4ca-2fae106f3f4mr13775801fa.26.1727855367944;
        Wed, 02 Oct 2024 00:49:27 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051b7sm7519272a12.7.2024.10.02.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:49:27 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:49:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-serial@vger.kernel.org, 
	Christoph Niedermaier <cniedermaier@dh-electronics.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Esben Haabendal <esben@geanix.com>, Fabio Estevam <festevam@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lino Sanfilippo <l.sanfilippo@kunbus.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Rickard x Andersson <rickaran@axis.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: imx: Update mctrl old_status on RTSD interrupt
Message-ID: <hgxxa2qsyr6c5jbzofzaarqkty4uccdtrteun5qlwyc66yqnbq@vb7xyeskjhhy>
References: <20241002041125.155643-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zzjnlicoynaleg7i"
Content-Disposition: inline
In-Reply-To: <20241002041125.155643-1-marex@denx.de>


--zzjnlicoynaleg7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 06:11:16AM +0200, Marek Vasut wrote:
> When sending data using DMA at high baudrate (4 Mbdps in local test case)=
 to
> a device with small RX buffer which keeps asserting RTS after every recei=
ved
> byte, it is possible that the iMX UART driver would not recognize the fal=
ling
> edge of RTS input signal and get stuck, unable to transmit any more data.
>=20
> This condition happens when the following sequence of events occur:
> - imx_uart_mctrl_check() is called at some point and takes a snapshot of =
UART
>   control signal status into sport->old_status using imx_uart_get_hwmctrl=
().
>   The RTSS/TIOCM_CTS bit is of interest here (*).
> - DMA transfer occurs, the remote device asserts RTS signal after each by=
te.
>   The i.MX UART driver recognizes each such RTS signal change, raises an
>   interrupt with USR1 register RTSD bit set, which leads to invocation of
>   __imx_uart_rtsint(), which calls uart_handle_cts_change().
>   - If the RTS signal is deasserted, uart_handle_cts_change() clears
>     port->hw_stopped and unblocks the port for further data transfers.
>   - If the RTS is asserted, uart_handle_cts_change() sets port->hw_stopped
>     and blocks the port for further data transfers. This may occur as the
>     last interrupt of a transfer, which means port->hw_stopped remains set
>     and the port remains blocked (**).
> - Any further data transfer attempts will trigger imx_uart_mctrl_check(),
>   which will read current status of UART control signals by calling
>   imx_uart_get_hwmctrl() (***) and compare it with sport->old_status .
>   - If current status differs from sport->old_status for RTS signal,
>     uart_handle_cts_change() is called and possibly unblocks the port
>     by clearing port->hw_stopped .
>   - If current status does not differ from sport->old_status for RTS
>     signal, no action occurs. This may occur in case prior snapshot (*)
>     was taken before any transfer so the RTS is deasserted, current
>     snapshot (***) was taken after a transfer and therefore RTS is
>     deasserted again, which means current status and sport->old_status
>     are identical. In case (**) triggered when RTS got asserted, and
>     made port->hw_stopped set, the port->hw_stopped will remain set
>     because no change on RTS line is recognized by this driver and
>     uart_handle_cts_change() is not called from here to unblock the
>     port->hw_stopped.
>=20
> Update sport->old_status in __imx_uart_rtsint() accordingly to make
> imx_uart_mctrl_check() detect such RTS change. Note that TIOCM_CAR
> and TIOCM_RI bits in sport->old_status do not suffer from this problem.

Why is that? Just because these don't stop transmission?

> Fixes: ceca629e0b48 ("[ARM] 2971/1: i.MX uart handle rts irq")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  drivers/tty/serial/imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 67d4a72eda770..3ad7f42790ef9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -762,6 +762,10 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *=
dev_id)
> =20
>  	imx_uart_writel(sport, USR1_RTSD, USR1);
>  	usr1 =3D imx_uart_readl(sport, USR1) & USR1_RTSS;
> +	if (usr1 & USR1_RTSS)
> +		sport->old_status |=3D TIOCM_CTS;
> +	else
> +		sport->old_status &=3D ~TIOCM_CTS;
>  	uart_handle_cts_change(&sport->port, usr1);
>  	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);

I didn't grab the whole picture, but I think this deserves a code
comment.=20

Would it make sense to replace the current code in __imx_uart_rtsint by
a call to imx_uart_mctrl_check()?

Best regards
Uwe

--zzjnlicoynaleg7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb8+wMACgkQj4D7WH0S
/k6JPgf/X0lFgjo1W2cM0ZYo6CYuetQUBi7TTOyedIgx8wtQoU0SEwO18PPsCyR0
RKxmW8UkGVCHGM/pyRShmqt8EonQ/5YuReN+JAbWT+4dRTGMO6/t87xEDuAcBEa1
IbbRhrLUHc8ShnIMm/r4WHmwtOHR3fwUgwRlIKWgtXntCgLFKObd6Hqh3ZMRxcom
2OFcn7XO7r1dGZN7qWK1Pdb8zBk4mUTVsA4jo4F8o5dPYkXyn+cUNyQ1tyTZK31L
RaBQAyyzOONZ1UttBAY7h0czpfypCh9+fKrmWy6CFtykqWCLrgGY+d847OsgCgxg
Y5t+fgsVLJEohfJeyGReyEPLhPYtBQ==
=Afex
-----END PGP SIGNATURE-----

--zzjnlicoynaleg7i--
