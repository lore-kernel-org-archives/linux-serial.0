From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH V2 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
Date: Mon, 15 May 2017 10:06:41 -0700
Message-ID: <73a70b856adf28b34c793f03c4db43a9@agner.ch>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
 <1494834539-17523-7-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494834539-17523-7-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, dongas86@gmail.com, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On 2017-05-15 00:48, Dong Aisheng wrote:
> On new LPUART versions, the oversampling ratio for the receiver can be
> changed from 4x (00011) to 32x (11111) which could help us get a more
> accurate baud rate divider.
> 
> The idea is to use the best OSR (over-sampling rate) possible.
> Note, OSR is typically hard-set to 16 in other LPUART instantiations.
> Loop to find the best OSR value possible, one that generates minimum
> baud diff iterate through the rest of the supported values of OSR.
> 
> Currently only i.MX7ULP is using it.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 85 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 107d0911..bda4b0c 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -140,6 +140,8 @@
>  #define UARTBAUD_SBNS		0x00002000
>  #define UARTBAUD_SBR		0x00000000
>  #define UARTBAUD_SBR_MASK	0x1fff
> +#define UARTBAUD_OSR_MASK       0x1f
> +#define UARTBAUD_OSR_SHIFT      24
>  
>  #define UARTSTAT_LBKDIF		0x80000000
>  #define UARTSTAT_RXEDGIF	0x40000000
> @@ -1506,6 +1508,72 @@ lpuart_set_termios(struct uart_port *port,
> struct ktermios *termios,
>  }
>  
>  static void
> +lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
> +{
> +	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
> +	u32 clk = sport->port.uartclk;
> +
> +	/*
> +	 * The idea is to use the best OSR (over-sampling rate) possible.
> +	 * Note, OSR is typically hard-set to 16 in other LPUART instantiations.
> +	 * Loop to find the best OSR value possible, one that generates minimum
> +	 * baud_diff iterate through the rest of the supported values of OSR.
> +	 *
> +	 * Calculation Formula:
> +	 *  Baud Rate = baud clock / ((OSR+1) × SBR)
> +	 */
> +	baud_diff = baudrate;
> +	osr = 0;
> +	sbr = 0;
> +
> +	for (tmp_osr = 4; tmp_osr <= 32; tmp_osr++) {
> +		/* calculate the temporary sbr value  */
> +		tmp_sbr = (clk / (baudrate * tmp_osr));
> +		if (tmp_sbr == 0)
> +			tmp_sbr = 1;
> +
> +		/*
> +		 * calculate the baud rate difference based on the temporary
> +		 * osr and sbr values
> +		 */
> +		tmp_diff = clk / (tmp_osr * tmp_sbr) - baudrate;
> +
> +		/* select best values between sbr and sbr+1 */
> +		tmp = clk / (tmp_osr * (tmp_sbr + 1));
> +		if (tmp_diff > (baudrate - tmp)) {
> +			tmp_diff = baudrate - tmp;
> +			tmp_sbr++;
> +		}
> +
> +		if (tmp_diff <= baud_diff) {
> +			baud_diff = tmp_diff;
> +			osr = tmp_osr;
> +			sbr = tmp_sbr;
> +		}
> +	}
> +
> +	/* handle buadrate outside acceptable rate */
> +	if (baud_diff > ((baudrate / 100) * 3))
> +		dev_warn(sport->port.dev,
> +			 "unacceptable baud rate difference of more than 3%%\n");
> +
> +	tmp = lpuart32_read(sport->port.membase + UARTBAUD);
> +
> +	if ((osr > 3) && (osr < 8))
> +		tmp |= UARTBAUD_BOTHEDGE;
> +
> +	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
> +	tmp |= (((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT);
> +
> +	tmp &= ~UARTBAUD_SBR_MASK;
> +	tmp |= sbr & UARTBAUD_SBR_MASK;
> +
> +	tmp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
> +
> +	lpuart32_write(tmp, sport->port.membase + UARTBAUD);
> +}
> +
> +static void
>  lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
>  		   struct ktermios *old)
>  {
> @@ -1611,12 +1679,17 @@ lpuart32_set_termios(struct uart_port *port,
> struct ktermios *termios,
>  	lpuart32_write(old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
>  			sport->port.membase + UARTCTRL);
>  
> -	sbr = sport->port.uartclk / (16 * baud);
> -	bd &= ~UARTBAUD_SBR_MASK;
> -	bd |= sbr & UARTBAUD_SBR_MASK;
> -	bd |= UARTBAUD_BOTHEDGE;
> -	bd &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
> -	lpuart32_write(bd, sport->port.membase + UARTBAUD);
> +	if (of_device_is_compatible(port->dev->of_node, "fsl,imx7ulp-lpuart")) {

Shouldn't we be consequent here and also use a flag in the soc data
instead of of_device_is_compatible...?

Btw, instead of using 3 bools, I would prefer using a single flags like
your patchset is proposing for the GPIO driver, what do you think?

--
Stefan


> +		lpuart32_serial_setbrg(sport, baud);
> +	} else {
> +		sbr = sport->port.uartclk / (16 * baud);
> +		bd &= ~UARTBAUD_SBR_MASK;
> +		bd |= sbr & UARTBAUD_SBR_MASK;
> +		bd |= UARTBAUD_BOTHEDGE;
> +		bd &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
> +		lpuart32_write(bd, sport->port.membase + UARTBAUD);
> +	}
> +
>  	lpuart32_write(modem, sport->port.membase + UARTMODIR);
>  	lpuart32_write(ctrl, sport->port.membase + UARTCTRL);
>  	/* restore control register */
