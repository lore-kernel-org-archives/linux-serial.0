From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/5] tty/serial: at91: use correct type for
 dma_sync_*_for_cpu() and dma_sync_*_for_device()
Date: Fri, 9 Jan 2015 16:13:59 +0100
Message-ID: <54AFF037.1000004@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com>
 <830a2b33ab0226405dc310c8a6d43731bf4ca8f9.1418131298.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <830a2b33ab0226405dc310c8a6d43731bf4ca8f9.1418131298.git.cyrille.pitchen@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Le 09/12/2014 14:31, Cyrille Pitchen a =E9crit :
> dma_sync_*_for_cpu() and dma_sync_*_for_device() use 'enum dma_data_direc=
tion',
> not 'enum dma_transfer_direction'
> =

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Sure:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Here it's difficult to add a "stable" tag as the error was introduced by
several different patches.

Thanks.

> ---
>  drivers/tty/serial/atmel_serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel=
_serial.c
> index 4d848a2..756f567 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -794,7 +794,7 @@ static void atmel_tx_dma(struct uart_port *port)
>  			return;
>  		}
>  =

> -		dma_sync_sg_for_device(port->dev, sg, 1, DMA_MEM_TO_DEV);
> +		dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
>  =

>  		atmel_port->desc_tx =3D desc;
>  		desc->callback =3D atmel_complete_tx_dma;
> @@ -927,7 +927,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>  	dma_sync_sg_for_cpu(port->dev,
>  			    &atmel_port->sg_rx,
>  			    1,
> -			    DMA_DEV_TO_MEM);
> +			    DMA_FROM_DEVICE);
>  =

>  	/*
>  	 * ring->head points to the end of data already written by the DMA.
> @@ -974,7 +974,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>  	dma_sync_sg_for_device(port->dev,
>  			       &atmel_port->sg_rx,
>  			       1,
> -			       DMA_DEV_TO_MEM);
> +			       DMA_FROM_DEVICE);
>  =

>  	/*
>  	 * Drop the lock here since it might end up calling
> =



-- =

Nicolas Ferre
