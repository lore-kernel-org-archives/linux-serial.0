From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty/serial: at91: maxburst was missing for dma transfers
Date: Thu, 16 Apr 2015 17:07:56 +0200
Message-ID: <552FD04C.2030507@atmel.com>
References: <1429196292-8134-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1429196292-8134-1-git-send-email-ludovic.desroches@atmel.com>
Sender: stable-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

Le 16/04/2015 16:58, Ludovic Desroches a =E9crit :
> Maxburst was not set when doing the dma slave configuration. This val=
ue
> is checked by the recently introduced xdmac. It causes an error when
> doing the slave configuration and so prevents from using dma.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: <stable@vger.kernel.org> # 3.12 and later

Indeed, thanks!
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 4e959c4..6afce7e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -880,6 +880,7 @@ static int atmel_prepare_tx_dma(struct uart_port =
*port)
>  	config.direction =3D DMA_MEM_TO_DEV;
>  	config.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.dst_addr =3D port->mapbase + ATMEL_US_THR;
> +	config.dst_maxburst =3D 1;
> =20
>  	ret =3D dmaengine_slave_config(atmel_port->chan_tx,
>  				     &config);
> @@ -1059,6 +1060,7 @@ static int atmel_prepare_rx_dma(struct uart_por=
t *port)
>  	config.direction =3D DMA_DEV_TO_MEM;
>  	config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.src_addr =3D port->mapbase + ATMEL_US_RHR;
> +	config.src_maxburst =3D 1;
> =20
>  	ret =3D dmaengine_slave_config(atmel_port->chan_rx,
>  				     &config);
>=20


--=20
Nicolas Ferre
