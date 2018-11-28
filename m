From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 3/3] serial: tegra: fix some spelling mistakes
Date: Wed, 28 Nov 2018 10:20:04 +0100
Message-ID: <20181128092004.GE17419@ulmo>
References: <20181101015230.27310-1-marcel@ziswiler.com>
 <20181101015230.27310-4-marcel@ziswiler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101015230.27310-4-marcel@ziswiler.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Jiri Slaby <jslaby@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-serial@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 02:52:30AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Fix a few spelling mistakes I stumbled upon while debugging a customers
> UART issues.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
>  drivers/tty/serial/serial-tegra.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index af2a29cfbbe9..d5269aaaf9b2 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -746,7 +746,7 @@ static void tegra_uart_stop_rx(struct uart_port *u)
>  	if (!tup->rx_in_progress)
>  		return;
> =20
> -	tegra_uart_wait_sym_time(tup, 1); /* wait a character interval */
> +	tegra_uart_wait_sym_time(tup, 1); /* wait one character interval */
> =20
>  	ier =3D tup->ier_shadow;
>  	ier &=3D ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE |
> @@ -887,7 +887,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port =
*tup)
>  	 *
>  	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
>  	 * the DATA is sitting in the FIFO and couldn't be transferred to the
> -	 * DMA as the DMA size alignment(4 bytes) is not met. EORD will be
> +	 * DMA as the DMA size alignment (4 bytes) is not met. EORD will be
>  	 * triggered when there is a pause of the incomming data stream for 4
>  	 * characters long.
>  	 *
> @@ -1079,7 +1079,7 @@ static void tegra_uart_set_termios(struct uart_port=
 *u,
>  	if (tup->rts_active)
>  		set_rts(tup, false);
> =20
> -	/* Clear all interrupts as configuration is going to be change */
> +	/* Clear all interrupts as configuration is going to be changed */
>  	tegra_uart_write(tup, tup->ier_shadow | UART_IER_RDI, UART_IER);
>  	tegra_uart_read(tup, UART_IER);
>  	tegra_uart_write(tup, 0, UART_IER);
> @@ -1165,10 +1165,10 @@ static void tegra_uart_set_termios(struct uart_po=
rt *u,
>  	/* update the port timeout based on new settings */
>  	uart_update_timeout(u, termios->c_cflag, baud);
> =20
> -	/* Make sure all write has completed */
> +	/* Make sure all writes have completed */
>  	tegra_uart_read(tup, UART_IER);
> =20
> -	/* Reenable interrupt */
> +	/* Re-enable interrupt */

I think both forms are valid. Either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XcQACgkQ3SOs138+
s6E7mg//UyZ1H1cQlmNMldSeHIIK4SeXON8qXOeM7HTcLh5uUv/c+R64nrbZ3rQz
wd8FPn3qsti83FKTIV1Ev1SO93mtrhB5MU1/zBisFXHVPiDLs75J7pMHg2MJ957e
75ebhBdqOS1JPvbmp1T+J96MtKMkXW6v/9Z9BhL0HVhBmflfsJHrA3FkLJL8/RAM
vVtJ9RPcXJUgCz+vTjmU4D6E15yKPpPm/eV0nGYbFbwyDMwPag22t8j6sDg2UZ5r
JKwD9ONmHLXUbjYz3+yw+/vZGcnGJFuJDeFC8gpx4hsK5ZNw1pVs2gxLMjwE1QZm
liED6qT1VakaIp6/5p3YJncYJxN/4ITyuzC2e7Z8gCxxo5mns/eGzEqlRh+nKcVe
2kccILiSROjPFa2yjCH6VtwfWsuJmJ55Jhqrfls5k8xS8O4l5Say0zrmgNEb/6X8
fBwVc3a0ppjkQijklfbvlTo4bajO9gS7Uo+YJ63rmi63kPYSLHi/OkFIGfXNi1Ys
mrLreQu0Wa3xF16Dadfxw7Jz7y5sa1lj5VSjJt5G4wWi3iw3fOicKjiwutyV7ytL
ylHU6TyR7Wyz14jPynrUCaGB4uIulPgc34W8KpDN6A4nJOWi4UbHlInhmyErUVCu
cVoY07JADA5egkRIjt34La6Dz9nC09gB5gzMuhQjHn0oSCcFDjo=
=bd89
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
