From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "tty: serial: 8250: add CON_CONSDEV to flags"
Date: Sun, 11 Dec 2016 08:12:34 +0100
Message-ID: <20161211071234.GC32092@kroah.com>
References: <20161211020549.GA1321@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161211020549.GA1321@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Leach <matthew.leach@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 11, 2016 at 10:05:49AM +0800, Herbert Xu wrote:
> This commit needs to be reverted because it prevents people from
> using the serial console as a secondary console with input being
> directed to tty0.
> 
> IOW, if you boot with console=ttyS0 console=tty0 then all kernels
> prior to this commit will produce output on both ttyS0 and tty0
> but input will only be taken from tty0.  With this patch the serial
> console will always be the primary console instead of tty0,
> potentially preventing people from getting into their machines in
> emergency situations.
> 
> Fixes: d03516df8375 ("tty: serial: 8250: add CON_CONSDEV to flags")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 240a361..e8819aa 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -675,7 +675,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>  	.device		= uart_console_device,
>  	.setup		= univ8250_console_setup,
>  	.match		= univ8250_console_match,
> -	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_CONSDEV,
> +	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>  	.index		= -1,
>  	.data		= &serial8250_reg,
>  };

Ok, this is the second time this has been reported.  Matthew seems to be
ignoring my email about this, so I guess I'll just revert the patch, as
it's obviously causing problems...

thanks,

greg k-h
