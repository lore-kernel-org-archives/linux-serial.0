Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B14130ADC
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833165; cv=none; b=ucUGVw9OMbGjbHl8KWzjD9Ys4cXK6mNKx0t2+XrxvMNhAxdcjOk70dk+BRnazOr18MUzkp17PHhiR0zrCuVcrEqCWBsgU9FLTtWLbbvhxogDs/YJNe1x65ZF2oVtVYJxWklUe5ugUcfofF/Y33Q9JdRV9mH96J0AvqYyhS373U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833165; c=relaxed/simple;
	bh=EXKFh35gS8V+J1+Go5gS5JEIT1Jvmz68gYCN4Q0+iyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWFD4BwGE0I2LOV+y3bhdG159kMGcKZpCS/p2TiN0Xjq5kly1Tu42NAQhawsfe/7jVxo0thpFR6YDLNmac2sNjKz+mPjfvN1V+pihUMHsyBZRm8ntvVNLgeCIfBY3kfCWTqAnwEmmJIpp10bPInvlYVngJfirxvBWdDPL3DlDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMbGK8jO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMbGK8jO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6EAC433F1;
	Thu,  7 Mar 2024 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833165;
	bh=EXKFh35gS8V+J1+Go5gS5JEIT1Jvmz68gYCN4Q0+iyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMbGK8jO2syJIVKZdvt51rA8YJUDtOe33AIMbaPpDXAudDqJwaagVHYLByHG7sizj
	 Vo+/KQtbXGgIX3//5+YPoBil7yop8mSFYxI5nIu4xTdeWh0f5Mx8MdoPkjMQY4d3Pv
	 K3S9x+cfOrGFGkMt/qXE3BKWWbtqoHCaVQDAaKV/wuqCGUy/JFvC2PsHPFvonHOnM1
	 kag2BMei2Vg5ZyaHqgcdiy1lg/YPcyYtleUVFUt1gDOa7Mj4hcZ41MlywrIq5pBYNy
	 o6/zMV5pmYdRTS+WE96ElArACQwtNBzPsQyNnMAAzT6N4nuNgs7JE0PgZimw+OsyH+
	 MhPVrld/vAylg==
Date: Thu, 7 Mar 2024 17:39:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: sifive: Remove 0 from fu540-c000-uart0 binding.
Message-ID: <20240307-sacrifice-dares-09c91fc8fefe@spud>
References: <20240304105947.SJcVAdr1@linutronix.de>
 <20240304-whomever-gladly-d43da7ad2fe6@spud>
 <229b34c1-5419-93ae-0a6f-a21cf4e4a276@sifive.com>
 <20240307090950.eLELkuyK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CLdB+aCot+C/VZ9x"
Content-Disposition: inline
In-Reply-To: <20240307090950.eLELkuyK@linutronix.de>


--CLdB+aCot+C/VZ9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 10:09:50AM +0100, Sebastian Andrzej Siewior wrote:
> The driver is using "sifive,fu540-c000-uart0" as a binding. The device
> tree and documentation states "sifive,fu540-c000-uart" instead. This
> means the binding is not matched and not used.
>=20
> This did not cause any problems because the alternative binding, used in
> the device tree, "sifive,uart0" is not handling the hardware any
> different.
>=20
> Align the binding in the driver with the documentation.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2024-03-06 18:48:13 [-0800], Paul Walmsley wrote:
> > On Mon, 4 Mar 2024, Conor Dooley wrote:
> > > I suspect that the driver is what's incorrect, given there's little
> > > value in putting the IP version in the SoC-specific compatible as it's
> > > a fixed implementation. I'd change the driver to match the bindings.
> >=20
> > Agreed
>=20

> I didn't add any stable/ fixes tags as I guess there is no point in
> backporting this.

Every documented device falls back to "sifive,uart0", as you mention
above, so I think that's reasonable.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> > - Paul
>=20
>  drivers/tty/serial/sifive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 0670fd9f84967..cbfce65c9d221 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -761,7 +761,7 @@ static int __init early_sifive_serial_setup(struct ea=
rlycon_device *dev,
>  }
> =20
>  OF_EARLYCON_DECLARE(sifive, "sifive,uart0", early_sifive_serial_setup);
> -OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart0",
> +OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart",
>  		    early_sifive_serial_setup);
>  #endif /* CONFIG_SERIAL_EARLYCON */
> =20
> @@ -1032,7 +1032,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops,=
 sifive_serial_suspend,
>  				sifive_serial_resume);
> =20
>  static const struct of_device_id sifive_serial_of_match[] =3D {
> -	{ .compatible =3D "sifive,fu540-c000-uart0" },
> +	{ .compatible =3D "sifive,fu540-c000-uart" },
>  	{ .compatible =3D "sifive,uart0" },
>  	{},
>  };
> --=20
> 2.43.0
>=20
> Sebastian

--CLdB+aCot+C/VZ9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZen7xQAKCRB4tDGHoIJi
0gR5AQCPmIRTe5TDrV3kat2e6/iKMKoN57R+OYfmtDHYDxi6+gEAl/ulgY53fzfU
qhAWnE7r6rcbR1Ko1p1bFENf2peI7AE=
=5vC3
-----END PGP SIGNATURE-----

--CLdB+aCot+C/VZ9x--
