From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 06/14] serial: tegra: report error to upper tty layer
Date: Tue, 13 Aug 2019 11:52:19 +0200
Message-ID: <20190813095219.GK1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:15PM +0530, Krishna Yarlagadda wrote:
> Report overrun/parity/frame/break errors to top tty layer. Add support
> to ignore break character if IGNBRK is set.
>=20
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index f6a3f4e..7ab81bb 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -374,13 +374,21 @@ static char tegra_uart_decode_rx_error(struct tegra=
_uart_port *tup,
>  			tup->uport.icount.frame++;
>  			dev_err(tup->uport.dev, "Got frame errors\n");
>  		} else if (lsr & UART_LSR_BI) {
> -			dev_err(tup->uport.dev, "Got Break\n");
> -			tup->uport.icount.brk++;
> -			/* If FIFO read error without any data, reset Rx FIFO */
> +			/*
> +			 * Break error
> +			 * If FIFO read error without any data, reset Rx FIFO
> +			 */
>  			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
>  				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
> +			if (tup->uport.ignore_status_mask & UART_LSR_BI)
> +				return TTY_BREAK;
> +			flag =3D TTY_BREAK;
> +			tup->uport.icount.brk++;
> +			dev_err(tup->uport.dev, "Got Break\n");

I know this is preexisting, but why do we want to output an error
message in these cases. Isn't it perfectly legal for this to happen?

Thierry

>  		}
> +		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
>  	}
> +
>  	return flag;
>  }
> =20
> @@ -562,6 +570,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uar=
t_port *tup,
>  			break;
> =20
>  		flag =3D tegra_uart_decode_rx_error(tup, lsr);
> +		if (flag !=3D TTY_NORMAL)
> +			continue;
> +
>  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
>  		tup->uport.icount.rx++;
> =20
> @@ -1224,6 +1235,8 @@ static void tegra_uart_set_termios(struct uart_port=
 *u,
>  	/* Ignore all characters if CREAD is not set */
>  	if ((termios->c_cflag & CREAD) =3D=3D 0)
>  		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> +	if (termios->c_iflag & IGNBRK)
> +		tup->uport.ignore_status_mask |=3D UART_LSR_BI;
> =20
>  	spin_unlock_irqrestore(&u->lock, flags);
>  }
> --=20
> 2.7.4
>=20

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1SiFMACgkQ3SOs138+
s6GvUg//Z9O5WEPe9rTu+9sjypaZEmAIc3UQ0IqGTCFG5787p+iokxU/hFJceWHB
8dinTSHuRtj0h+Oohj0vrmuduDEV9PpeXJq/3DChXFkv/FXnp9TXmwUAIz/d4vll
73X3Q0YIhdad3rQKAbaN8sAoNZM6Sem7GiXxwgbBwdEWOfboXHJ6+B4DCaPWggAI
smLYQaTkLGhaP6nxCjFTDxlOa64ogcsQ8UBBAmtuunYuHlnZhSXZNw6+hx6DLq2A
96ySRNVMRzdR0SAqwv0zNm2CxgxJbd8li1r46jLo9od6oTB+mGgrGL6QIT+HY3Rx
VRVEsA9dXpzARh7jucVelOZt7Jne2vWPgnZachYCDuuOL1XdjuSy+I8f90YS2eaX
cjg+U1l9lVoBWy5s8BQWRRaQd8Fv6Prmurw6Y2EwfUHebNAuSIj8bBoDg7KImd+j
OBnp2i/eZweGMJs29SmHZJCkKrKq2f33mlRCfPrni9fMtFtuyv/3CHr4Dq0ktCHz
LtIYvyLo3PX7xdZxni5TilP9i0VGsRmXaRzSAhKAwl5+IZQeJl22tE1z2Fwbxvf7
2W8lxpJsP6ccwCvFry0r4Gx0FAEVRS7QNuf556xzDqO0dN0pY4kzYlGy2vUkcDkB
dQBCiMtdS8huuJMz3rGCDZLr/NUwbnjrDkpcvZK2nIu5gzsH5Hg=
=CqDS
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
