From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] tty: serial: meson: allow baud-rates lower than 9600
Date: Sun, 5 Nov 2017 15:12:06 +0100
Message-ID: <20171105141206.GA31306@kroah.com>
References: <bb0a70cc-6cc1-46d2-aa04-046a37c9f516@myway.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb0a70cc-6cc1-46d2-aa04-046a37c9f516@myway.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Rohloff <v10lator@myway.de>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Nov 05, 2017 at 05:29:30AM +0100, Thomas Rohloff wrote:
> Devices like DCF77 receivers need the baud-rate to be as low as 50.
> 
> I have tested this on a Meson GXL device with uart_A.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Rohloff <v10lator@myway.de>
> ---
> drivers/tty/serial/meson_uart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index 07c0f98be3ac..e281ce5d101d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -362,7 +362,7 @@ static void meson_uart_set_termios(struct uart_port
> *port,

This is line-wrapped and can not be applied :(

It's your email client, look at this setting:
	Content-Type: text/plain; charset=utf-8; format=flowed

format=flowed does not work for kernel patches, it corruptes and edits
them as it thinks this is just a conversation, not a machine-readable
format.

5th try?  :)

thanks,

greg k-h
