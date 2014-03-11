From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/2] serial_core: Unregister console in uart_remove_one_port()
Date: Mon, 10 Mar 2014 21:06:52 -0400
Message-ID: <531E61AC.6040706@hurleysoftware.com>
References: <1393593694-30262-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393593694-30262-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

[ +cc Alan ]

On 02/28/2014 08:21 AM, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> If the serial port being removed is used as a console, it must also be
> unregistered from the console subsystem using unregister_console().
>
> uart_ops.release_port() will release resources (e.g. iounmap() the serial
> port registers), causing a crash on subsequent kernel output if the console
> is still registered.

This brings up an interesting point:  where are the serial_core drivers
indicating to the tty core that the port is bound to a console?
IOW, I cannot find a single 'port->console = 1' anywhere in the serial tree.

It would be bad if the uart port disappears while a console is running
on it...

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>   drivers/tty/serial/serial_core.c |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ece2049bd270..8ece7f14d89d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2677,6 +2677,12 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>   		tty_vhangup(port->tty);
>
>   	/*
> +	 * If the port is used as a console, unregister it
> +	 */
> +	if (uart_console(uport))
> +		unregister_console(uport->cons);
> +
> +	/*
>   	 * Free the port IO and memory resources, if any.
>   	 */
>   	if (uport->type != PORT_UNKNOWN)
>
