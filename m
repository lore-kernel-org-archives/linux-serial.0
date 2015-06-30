From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 2/4] tty/serial: at91: fix some macro definitions to fit coding style
Date: Tue, 30 Jun 2015 22:28:42 +0200
Message-ID: <11308515.NsBzDiA1lH@wuerfel>
References: <cover.1435672649.git.cyrille.pitchen@atmel.com> <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tuesday 30 June 2015 16:05:15 Cyrille Pitchen wrote:
> +#define UART_PUT_CR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_CR)
> +#define UART_GET_MR(port)      __raw_readl((port)->membase + ATMEL_US_MR)
> +#define UART_PUT_MR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_MR)
> +#define UART_PUT_IER(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_IER)
> 

How about removing these macros entirely? I'm not aware of other drivers
doing it like this, and it does not seem to add any value?

At the same time, you could use readl_relaxed() to make the driver
endian-safe.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
