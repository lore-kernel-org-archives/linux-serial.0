Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58F1A9FBA;
	Mon, 16 Mar 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660141; cv=none; b=QrPLSAe2GsRQ6xobdiOU+nNqrR3KWCvxdGR5WMoHdferTVxvKzCGGjxooYYDVmmiTss4DHXrCPg/gkPoFEee4GEDWIM5/94DtJhm5Ss4bL3kMkU6A5cEIpcxInQ3MID3pSZFf2q9ehHweTIRGLfXJDIMuO96UORvOQOBDbRSHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660141; c=relaxed/simple;
	bh=hZ7HCxXZH+KCGvedYMF3TeE2GVqJXuozWkiILmg+dJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF4POcZYNkuqVtXW8OksYjpeiDX86IH38stmarYk/grdDeUbUBDGYjXTQ/hFX7ezcULPM2Q2f01aupGyffV24RlJZ2SqZVBpLIahqzF3Je8ntFAwYdwFH/3vIvz420rO64NX2QrMU7MTfGudA6rjCrmHZdmet9Jx7IXL3MJZKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTLVCK+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTLVCK+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A30C19421;
	Mon, 16 Mar 2026 11:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773660141;
	bh=hZ7HCxXZH+KCGvedYMF3TeE2GVqJXuozWkiILmg+dJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTLVCK+CdnGJygYTinaAMAF+FIIYL1H+vkvjx8oYuQMjaVC+XjhnpZuf0TKwRPYnp
	 EMQuwlvUtIOb2UNxDoZABKAQch6s07FeBfppJPxUZPmzGRqVpHKqGmTY1Rzuqk7Xpo
	 uAjB17JcB4VVqReeg+d+nj2pQ2HWKBSSSMD9VFG7kqkwFxN3pniM7EsbGrWcegbw2/
	 yJ7XW6MH65V4cSG+kN2ei+u2NoWi7l8ql/GGjh9KVbMftwNBvhCYMRHCXm1AUINn0J
	 UW+8CozvVuszS0aKonYx7vohj6tRK/BnnPklcg2Ugjv+5JXh6pmbQrcrFPOWXAYSOA
	 eG87AInFdt4lA==
Date: Mon, 16 Mar 2026 11:22:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH 1/2] riscv: ultrarisc: 8250_dw: support DP1000 uart
Message-ID: <20260316-frayed-pretended-eba059554dcc@spud>
References: <20260316-ultrarisc-serial-v1-0-c464f3e933a5@ultrarisc.com>
 <20260316-ultrarisc-serial-v1-1-c464f3e933a5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1+Bm8qKmqRdbiva4"
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-serial-v1-1-c464f3e933a5@ultrarisc.com>


--1+Bm8qKmqRdbiva4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 09:36:18AM +0800, Jia Wang wrote:
> From: Zhang Xincheng <zhangxincheng@ultrarisc.com>
>=20
> The UART of DP1000 does not support automatic detection of
> buffer size. skip_autocfg needs to be set to true
>=20
> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

$subject: riscv: ultrarisc: 8250_dw: support DP1000 uart

Please update this to match other modifications to this file.
"riscv: ultrariscv" doesn't belong at the start.

> ---
>  drivers/tty/serial/8250/8250_dw.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index db73b2ae17fa..6a2acf173331 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -56,6 +56,7 @@
>  #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
>  #define DW_UART_QUIRK_APMC0D08		BIT(4)
>  #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
> +#define DW_UART_QUIRK_FIXED_TYPE	BIT(6)
> =20
>  struct dw8250_platform_data {
>  	u8 usr_reg;
> @@ -514,6 +515,11 @@ static void dw8250_quirks(struct uart_port *p, struc=
t dw8250_data *data)
>  		data->data.dma.prepare_tx_dma =3D dw8250_prepare_tx_dma;
>  		data->data.dma.prepare_rx_dma =3D dw8250_prepare_rx_dma;
>  	}
> +	if (quirks & DW_UART_QUIRK_FIXED_TYPE) {
> +		p->flags |=3D UPF_FIXED_TYPE;
> +		p->type =3D PORT_16550A;
> +		data->skip_autocfg =3D true;
> +	}
>  	if (quirks & DW_UART_QUIRK_APMC0D08) {
>  		p->iotype =3D UPIO_MEM32;
>  		p->regshift =3D 2;
> @@ -789,6 +795,11 @@ static const struct dw8250_platform_data dw8250_skip=
_set_rate_data =3D {
>  	.quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
>  };
> =20
> +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data =
=3D {
> +	.usr_reg =3D DW_UART_USR,
> +	.quirks =3D DW_UART_QUIRK_FIXED_TYPE,
> +};
> +
>  static const struct of_device_id dw8250_of_match[] =3D {
>  	{ .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
>  	{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_octeon_3=
860_data },
> @@ -796,6 +807,7 @@ static const struct of_device_id dw8250_of_match[] =
=3D {
>  	{ .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_rzn1_d=
ata },
>  	{ .compatible =3D "sophgo,sg2044-uart", .data =3D &dw8250_skip_set_rate=
_data },
>  	{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_skip_set_ra=
te_data },
> +	{ .compatible =3D "ultrarisc,dp1000-uart", .data =3D &dw8250_ultrarisc_=
dp1000_data },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, dw8250_of_match);
>=20
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--1+Bm8qKmqRdbiva4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabfn5wAKCRB4tDGHoIJi
0v45AQD3hFtUbi/xAvY2OzMR5EdszsS2CzI9H3nNfQnqWUuVywD8CJ+C7OenjQXS
FCfdsrcoF8ZN3KYfs+EfK29lh/SHYgs=
=8Hwm
-----END PGP SIGNATURE-----

--1+Bm8qKmqRdbiva4--
