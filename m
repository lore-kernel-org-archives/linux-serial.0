From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty: atmel_serial: fix a NULL pointer dereference
Date: Mon, 18 Mar 2019 08:28:26 +0100
Message-ID: <cb9a62d2-1d91-a9d6-22ed-1e19ca1d96c7@sorico.fr>
References: <d8978a94-23fc-3610-e3da-5e1da2d86914@sorico.fr>
 <20190315171606.6282-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315171606.6282-1-kjlu@umn.edu>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Le 15/03/2019 à 18:16, Kangjie Lu a écrit :
> In case dmaengine_prep_dma_cyclic fails, the fix returns a proper
> error code to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> 
> ---
> V2: simplified the patch as suggested by
> Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..41b728d223d1 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1288,6 +1288,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  					 sg_dma_len(&atmel_port->sg_rx)/2,
>  					 DMA_DEV_TO_MEM,
>  					 DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(port->dev, "Preparing DMA cyclic failed\n");
> +		goto chan_err;
> +	}
>  	desc->callback = atmel_complete_rx_dma;
>  	desc->callback_param = port;
>  	atmel_port->desc_rx = desc;
> 

Thanks !

Richard
