From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/9] tty/serial: at91: constify uart_ops structures
Date: Fri, 2 Sep 2016 09:55:51 +0200
Message-ID: <931065fc-5304-a0d5-1cde-b02bc5dc4b21@atmel.com>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472752298-981-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472752298-981-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Le 01/09/2016 à 19:51, Julia Lawall a écrit :
> Check for uart_ops structures that are only stored in the ops field of a
> uart_port structure.  This field is declared const, so uart_ops structures
> that have this property can be declared as const also.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct uart_ops i@p = { ... };
> 
> @ok@
> identifier r.i;
> struct uart_port e;
> position p;
> @@
> e.ops = &i@p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct uart_ops e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct uart_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Julia.
Bye,

> ---
>  drivers/tty/serial/atmel_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2eaa18d..963a72f 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2292,7 +2292,7 @@ static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
>  }
>  #endif
>  
> -static struct uart_ops atmel_pops = {
> +static const struct uart_ops atmel_pops = {
>  	.tx_empty	= atmel_tx_empty,
>  	.set_mctrl	= atmel_set_mctrl,
>  	.get_mctrl	= atmel_get_mctrl,
> 
> 


-- 
Nicolas Ferre
