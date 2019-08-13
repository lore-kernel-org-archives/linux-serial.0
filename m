From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 02/14] serial: tegra: add support to ignore read
Date: Tue, 13 Aug 2019 11:42:08 +0200
Message-ID: <20190813094208.GG1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:11PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
>=20
> Add support to ignore read characters if CREAD flag is not set.
>=20
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index 19f4c24..93d299e 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -542,6 +542,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uar=
t_port *tup,
>  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
>  		tup->uport.icount.rx++;
> =20
> +		if (tup->uport.ignore_status_mask & UART_LSR_DR)
> +			continue;
> +
>  		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
>  			tty_insert_flip_char(tty, ch, flag);

Is it a good idea to ignore even sysrq characters if CREAD is not set?
According to termios, CREAD enables the receiver, so technically if it
isn't set you can't even receive sysrq characters. But I don't know if
there are any rules regarding this.

Is this the same way that other drivers work?

Thierry

>  	} while (1);
> @@ -562,6 +565,10 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_u=
art_port *tup,
>  		dev_err(tup->uport.dev, "No tty port\n");
>  		return;
>  	}
> +
> +	if (tup->uport.ignore_status_mask & UART_LSR_DR)
> +		return;
> +
>  	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
>  				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
>  	copied =3D tty_insert_flip_string(tty,
> @@ -1190,6 +1197,11 @@ static void tegra_uart_set_termios(struct uart_por=
t *u,
>  	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
>  	tegra_uart_read(tup, UART_IER);
> =20
> +	tup->uport.ignore_status_mask =3D 0;
> +	/* Ignore all characters if CREAD is not set */
> +	if ((termios->c_cflag & CREAD) =3D=3D 0)
> +		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> +
>  	spin_unlock_irqrestore(&u->lock, flags);
>  }
> =20
> --=20
> 2.7.4
>=20

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShfAACgkQ3SOs138+
s6FVpg/9GPeTbw/45dZ/HWvsmLm2iaqKG106inOD5HVGDZXJKkwDQOSrqGMMriL4
4P5s43rU58YErMzCly57ETyrADsZQbyI0N+/Bsk2kuN138RzhplzSFwad8K/J/V3
QMtXJQ5jHoaSi97NjGBVmSApgg2i3BT9Ro8vVEG1aje4KAswACcR+WZS9tTQ4u69
8TR1A5skZ5BSWrXz0gbxEKcrmlfHtLiqTtAtvRNNyqoSaspUETEv4LV1WywlkX/1
7xqwYm0RkuPuMoQnuGv2zH40ZPZPrnRj3OeEoAXYN42XauihHjcVfvVguvjSdObd
EmFyZQiseCVm07vLImYFXkh4kbSUAIYtO2RVBF9mbSiYsfJKjdGDgfCCvNpnUzbA
BKbgWBQAM1vsvdMenhZvISdtPNTO9bLpffHPydEwLFMLAecAfJyAzmUw6XNxW0k4
QVYlH49a5+V6C2cgoqzttMKyx9AbCxiGIAxYTOeqRJxLRAYy/eNFpvGdRml0S9tf
ZyUCysOxM413iZ+tRlbGWy3DI+lmDyqJEw/VE6I7CVfa44aRrdkzKTvHCgISRAEt
5BzVQw0yWrcXaDBdG7QnR8Wl0Gk/apezX3KL723FV0vUdYcX3ejIyWaBo4ijukG8
InudQyl4SNS25B8RknOJ9uJkrYfG7x0eC+0lFoV7xx6ojPif8oc=
=eDP7
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
