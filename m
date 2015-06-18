From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH linux-next v2 3/4] tty/serial: at91: add support to FIFOs
Date: Thu, 18 Jun 2015 18:36:36 +0200
Message-ID: <20150618163636.GP27492@piout.net>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com>
 <e9b7445f103969a286d586054d79461a6efacd65.1434038494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e9b7445f103969a286d586054d79461a6efacd65.1434038494.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 11/06/2015 at 18:20:16 +0200, Cyrille Pitchen wrote :
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Seems good to me, a few comments:

> +	if (port->fifo_size < 8 || port->fifo_size > 32) {

I'm not sure why you limit the size to 32. At some point, a new SoC may
be release with a bigger FIFO then we'll have to change the code instead
of just putting the appropriate value in the device tree.

> +		port->fifo_size = 0;
> +		dev_err(&pdev->dev, "Invalid FIFO size\n");
> +		return;
> +	}
> +
> +	/*
> +	 * 0 <= rts_low <= rts_high <= fifo_size
> +	 * Once their CTS line asserted by the remote peer, some x86 UARTs tend
> +	 * to flush their internal TX FIFO, commonly up to 8 data, before
> +	 * actually stopping to send new data. So we try to set the RTS High
> +	 * Threshold to a raisonable high value respecting this 8 data empirical
              reasonably --^

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
