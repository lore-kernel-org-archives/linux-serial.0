From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial_core: support native endianness
Date: Tue, 22 Sep 2015 13:45:02 +0200
Message-ID: <56013F3E.7080600@suse.cz>
References: <1442921693-1389-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442921693-1389-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/22/2015, 01:34 PM, Max Filippov wrote:

NACK until you provide a useful commit log including description why
this is needed.

> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f368520..84b5695 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1826,8 +1826,8 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
>   *	@options: ptr for <options> field; NULL if not present (out)
>   *
>   *	Decodes earlycon kernel command line parameters of the form
> - *	   earlycon=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>
> - *	   console=<name>,io|mmio|mmio32|mmio32be,<addr>,<options>
> + *	   earlycon=<name>,io|mmio|mmio32|mmio32be|mmio32native,<addr>,<options>
> + *	   console=<name>,io|mmio|mmio32|mmio32be|mmio32native,<addr>,<options>
>   *
>   *	The optional form
>   *	   earlycon=<name>,0x<addr>,<options>
> @@ -1848,6 +1848,10 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
>  	} else if (strncmp(p, "mmio32be,", 9) == 0) {
>  		*iotype = UPIO_MEM32BE;
>  		p += 9;
> +	} else if (strncmp(p, "mmio32native,", 13) == 0) {
> +		*iotype = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ?
> +			UPIO_MEM32BE : UPIO_MEM32;
> +		p += 13;
>  	} else if (strncmp(p, "io,", 3) == 0) {
>  		*iotype = UPIO_PORT;
>  		p += 3;
> 

thanks,
-- 
js
suse labs
