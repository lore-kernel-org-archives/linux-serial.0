From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] use callbacks to access UART_DLL/UART_DLM
Date: Thu, 17 Dec 2015 16:02:52 +0000
Message-ID: <yw1xoadpcbbn.fsf@unicorn.mansr.com>
References: <5672D89A.4090307@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5672D89A.4090307@laposte.net> (Sebastian Frias's message of
	"Thu, 17 Dec 2015 16:45:30 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm@opensource.se>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
List-Id: linux-serial@vger.kernel.org

Sebastian Frias <sf84@laposte.net> writes:

> ---
> resending as plain-text
> ---
>   drivers/tty/serial/8250/8250_core.c |   17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_core.c=20
> b/drivers/tty/serial/8250/8250_core.c
> index 2c46a21..9ca863c 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -791,22 +791,19 @@ static int size_fifo(struct uart_8250_port *up)
>    */
>   static unsigned int autoconfig_read_divisor_id(struct uart_8250_por=
t *p)

What tree are you working against?  Current mainline has that function
in 8250_port.c.

>   {
> -    unsigned char old_dll, old_dlm, old_lcr;
> +    unsigned char old_lcr;
>       unsigned int id;
> +    unsigned int old_dl;

Your patch is messed up.  Consider using "git send-email" instead.

>       old_lcr =3D serial_in(p, UART_LCR);
> -    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
> -
> -    old_dll =3D serial_in(p, UART_DLL);
> -    old_dlm =3D serial_in(p, UART_DLM);
>
> -    serial_out(p, UART_DLL, 0);
> -    serial_out(p, UART_DLM, 0);
> +    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
>
> -    id =3D serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
> +    old_dl =3D serial_dl_read(p);
> +    serial_dl_write(p, 0);
> +    id =3D serial_dl_read(p);
> +    serial_dl_write(p, old_dl);
>
> -    serial_out(p, UART_DLL, old_dll);
> -    serial_out(p, UART_DLM, old_dlm);
>       serial_out(p, UART_LCR, old_lcr);
>
>       return id;
> --=20

If you left the blank lines alone, the patch would end up much easier t=
o
understand.  In this diff, some of the lines listed as added or removed
have actually not changed, and that's not immediately obvious.

--=20
M=E5ns Rullg=E5rd
