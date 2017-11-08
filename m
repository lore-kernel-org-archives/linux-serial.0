From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [v2] Devicetree documentation: add rs485-rts-active-high property
Date: Wed, 8 Nov 2017 07:11:55 +0100
Message-ID: <20171108061155.GA4731@wunner.de>
References: <20171107075336.11236-1-m.oleszczyk@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171107075336.11236-1-m.oleszczyk-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 07, 2017 at 08:53:36AM +0100, Michal Oleszczyk wrote:
> From: Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add description of rs485-rts-active-high property into
> /serial/rs485.txt devicetree documentation file.

Most rs485 transceivers on the market have an active-high Transmit Enable
pin, e.g. MAX13451E, SN65HVD1781A:

https://datasheets.maximintegrated.com/en/ds/MAX13450E-MAX13451E.pdf
http://www.ti.com/lit/gpn/sn65hvd1781a-q1

In fact I'm not aware of a single transceiver that uses active-low,
do you know one?

I know that omap-serial defaults to active-low and supports an
(as yet undocumented) "rs485-rts-active-high" property.  I don't
know why it defaults to active-low.  Adding Mark Jackson to cc
who introduced that feature with commit 4a0ac0f55.

All other drivers (e.g. imx.c, fsl-lpuart.c) default to active-high.
(Which in a way contradicts with your patch as it suggests *everything*
defaults to active-low.)

I have a series in preparation that I was going to post shortly
which instead introduces an rs485-rts-active-low property for
those presumably rare cases when it's needed, but retains the
current behaviour of omap-serial for compatibility:

https://github.com/l1k/linux/commit/03ef500e98e5
https://github.com/l1k/linux/commit/8430ffdb5799
https://github.com/l1k/linux/commit/c3a86d3b862b

In my opinion that's a better approach but I'd be curious to
hear other opinions.

Thanks,

Lukas

> 
> Signed-off-by: Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Repair 'From' to match with 'Signed-off-by' section.
> 
>  Documentation/devicetree/bindings/serial/rs485.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> index b8415936dfdb..71c38ef7f6e2 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.txt
> +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> @@ -16,6 +16,8 @@ Optional properties:
>    feature at boot time. It can be disabled later with proper ioctl.
>  - rs485-rx-during-tx: empty property that enables the receiving of data even
>    whilst sending data.
> +- rs485-rts-active-high: empty property telling to set RTS line high when it is 
> +  active.
>  
>  RS485 example for Atmel USART:
>  	usart0: serial@fff8c000 {
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
