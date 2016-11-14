From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "tty: serial: 8250: add CON_CONSDEV to flags"
Date: Mon, 14 Nov 2016 12:49:50 +0100
Message-ID: <20161114114950.GA13920@kroah.com>
References: <1479092021-14885-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479092021-14885-1-git-send-email-chenhc@lemote.com>
Sender: stable-owner@vger.kernel.org
To: Huacai Chen <chenhc@lemote.com>
Cc: linux-serial@vger.kernel.org, Matthew Leach <matthew.leach@codethink.co.uk>, stable@vger.kernel.org, Ce Sun <sunc@lemote.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 14, 2016 at 10:53:41AM +0800, Huacai Chen wrote:
> This reverts commit d03516df837587368fc6e75591f6329c072b9eb5. From
> Documentation/serial-console.txt we can know that serial port becomes
> the system console only when it appears in the kernel parameters as the
> last console device. But commit d03516df837587 adds a CON_CONSDEV flag
> to univ8250_console and breaks this convention. After that either we
> use "console=tty console=ttyS0" or "console=ttyS0 console=tty", serial
> port will always be the system console.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ce Sun <sunc@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 240a361..e8819aa 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -675,7 +675,7 @@ static struct console univ8250_console = {
>  	.device		= uart_console_device,
>  	.setup		= univ8250_console_setup,
>  	.match		= univ8250_console_match,
> -	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_CONSDEV,
> +	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>  	.index		= -1,
>  	.data		= &serial8250_reg,
>  };

Odd.  Matthew, any thoughts here?  This seems to be the opposite of why
you submitted this change...

thanks,

greg k-h
