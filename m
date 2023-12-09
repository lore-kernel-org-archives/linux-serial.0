Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="amQKNLV/"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A60121
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 06:43:37 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id ByYGrMIqNngscByYGrezjM; Sat, 09 Dec 2023 15:43:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702133015;
	bh=N1cprJAQOIkFohzPQFgXhK/wxzuO7UEkHWYrOIwo3x0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=amQKNLV/aS2qbDSaRAmzVSV3ceiWEdPoA/c0M6Sn3mnTNH+4l/D11qMqipduFZOfp
	 4xT3NtTeEYs1NYkyuLFy1hxGOlqdfxcqVoqsChCgajF58rxhkjl5dDMnTAXbaamVoz
	 3cDSJWJcnI3/BkC5DyG5MEOFGumnRcheT8JUR58fPtXGvDrOhQlPpQT1Xi5gqZAUeu
	 Xn/MqoNJ+40dMcj2B3Dy0d5YKsvmwFeULQHtz2SoBKBql3Y6JZ3yyhE8QqxaRBQ5iH
	 XVZ4Hy2bZYQvRO4kjmUZ/H8z19giVrL9A7OLvOlaRzz2bWWIJsrLxEobMtrKBmQfbT
	 vbpNVU3/XGa/Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Dec 2023 15:43:35 +0100
X-ME-IP: 92.140.202.140
Message-ID: <f400dc9b-36db-4829-a67b-6b05718f68fc@wanadoo.fr>
Date: Sat, 9 Dec 2023 15:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] tty: serial: amba-pl011: avoid quoted string split
 across lines
Content-Language: fr
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
 <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/11/2023 à 15:07, Théo Lebrun a écrit :
> Remove all instances of quoted strings split across lines. Fix four
> checkpatch warnings:
> 
>      $ ./scripts/checkpatch.pl --strict --file \
>          drivers/tty/serial/amba-pl011.c
>      WARNING: quoted string split across lines
>      [...]
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>   drivers/tty/serial/amba-pl011.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 743dee75c68b..be8888db1a37 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -973,8 +973,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
>   	/* Switch buffer & re-trigger DMA job */
>   	dmarx->use_buf_b = !dmarx->use_buf_b;
>   	if (pl011_dma_rx_trigger_dma(uap)) {
> -		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
> -			"fall back to interrupt mode\n");
> +		dev_dbg(uap->port.dev,
> +			"could not retrigger RX DMA job fall back to interrupt mode\n");
>   		uap->im |= UART011_RXIM;
>   		pl011_write(uap->im, uap, REG_IMSC);
>   	}
> @@ -1021,8 +1021,8 @@ static void pl011_dma_rx_callback(void *data)
>   	 * get some IRQ immediately from RX.
>   	 */
>   	if (ret) {
> -		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
> -			"fall back to interrupt mode\n");
> +		dev_dbg(uap->port.dev,
> +			"could not retrigger RX DMA job fall back to interrupt mode\n");
>   		uap->im |= UART011_RXIM;
>   		pl011_write(uap->im, uap, REG_IMSC);
>   	}
> @@ -1158,8 +1158,8 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
>   
>   	if (uap->using_rx_dma) {
>   		if (pl011_dma_rx_trigger_dma(uap))
> -			dev_dbg(uap->port.dev, "could not trigger initial "
> -				"RX DMA job, fall back to interrupt mode\n");
> +			dev_dbg(uap->port.dev,
> +				"could not trigger initial RX DMA job, fall back to interrupt mode\n");
>   		if (uap->dmarx.poll_rate) {

Hi,

I think that having a comma just before "fall back", as done here, would 
make the other 3 messages clearer.

CJ

>   			timer_setup(&uap->dmarx.timer, pl011_dma_rx_poll, 0);
>   			mod_timer(&uap->dmarx.timer,
> @@ -1391,8 +1391,8 @@ __acquires(&uap->port.lock)
>   	 */
>   	if (pl011_dma_rx_available(uap)) {
>   		if (pl011_dma_rx_trigger_dma(uap)) {
> -			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
> -				"fall back to interrupt mode again\n");
> +			dev_dbg(uap->port.dev,
> +				"could not trigger RX DMA job fall back to interrupt mode again\n");
>   			uap->im |= UART011_RXIM;
>   			pl011_write(uap->im, uap, REG_IMSC);
>   		} else {
> 

