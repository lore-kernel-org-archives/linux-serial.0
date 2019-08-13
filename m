From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Date: Tue, 13 Aug 2019 11:48:32 +0200
Message-ID: <20190813094832.GJ1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:14PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
>=20
> FIFO reset/flush code implemented now does not follow programming
> guidelines. RTS line has to be turned off while flushing fifos to
> avoid new transfers. Also check LSR bits UART_LSR_TEMT and UART_LSR_DR
> to confirm fifos are flushed.

You use inconsistent spelling for FIFO here.

> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index ae7225c..f6a3f4e 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct tegra_ua=
rt_port *tup,
>  static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bi=
ts)
>  {
>  	unsigned long fcr =3D tup->fcr_shadow;
> +	unsigned int lsr, tmout =3D 10000;
> +
> +	if (tup->rts_active)
> +		set_rts(tup, false);
> =20
>  	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
>  		fcr |=3D fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> @@ -289,6 +293,17 @@ static void tegra_uart_fifo_reset(struct tegra_uart_=
port *tup, u8 fcr_bits)
>  	 * to propagate, otherwise data could be lost.
>  	 */
>  	tegra_uart_wait_cycle_time(tup, 32);
> +
> +	do {
> +		lsr =3D tegra_uart_read(tup, UART_LSR);
> +		if (lsr | UART_LSR_TEMT)
> +			if (!(lsr & UART_LSR_DR))

Can't both of these go on the same line?

Thierry

> +				break;
> +		udelay(1);
> +	} while (--tmout);
> +
> +	if (tup->rts_active)
> +		set_rts(tup, true);
>  }
> =20
>  static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int =
baud)
> --=20
> 2.7.4
>=20

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1Sh28ACgkQ3SOs138+
s6EtEg//doVYuGtPItd+PnimbHPvK65iBFfPnNyDNeLkFEWRXc9Lr/YNMEZRvXXk
jSCB5dOOO6bawhT2cAqpph/9dza4Vvc+944teuITF9d42ymDjjMfcFjAFegqtFsb
zTlE8CzX2bs1y+0xks/8LGhHgaUPDU1NgVHnhwWjo2IIZvnOBjL8eWalCwfiNO6M
jo9UOV5xAZyXOk+RtheaE4VfGcgSBW3TbqWtl1TjhZ73E9d/S+r4eHo918GhD+n6
c4/Z9155gI0KEJyvQBGBSUaWAW6Ok9Yzq9rn2IjW9/uaU7Su3n+UBuv1bIB50Juj
ihpWn/k/07mM+T8AKeu0COxpmoLUvbYM9kU0gAz7xLFsFws68/+nJfUigmwCZgLA
BnOixrT6rgSmZcyR/50fep2hrqwBNZ51fZ2u5fKWBBUGDGwbsef4wLKmih5OC6Le
5+bDoP70Z8xhLZYEeXsSOTn4lPka+6NRXha8W+LE3OYeeBYOrNYfDUc/jPeif47J
guZLpd1CH3bJnvR0mQR0DIZGKhRMd3Czbcw+opvnepeVO7kmzSkUl1bbX/6J9h7I
ODfTut2Y6Q9OzqdwJObm3VpnchB/uEHkMrOVMYjYPzkhbH5sgX2mXr60+O8VAzHI
My0BQvCge2+Ybv3e8SV1YusY6pV4Fjp8svAC9LmuB0WnAxJszZw=
=dpAL
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
