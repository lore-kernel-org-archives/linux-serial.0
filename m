From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] serial: earlycon: Initialize uart_port spinlock
Date: Thu, 10 Dec 2015 20:35:28 -0600
Message-ID: <CAL_Jsq+Tam+vo46LvPUqJ_o6EueBsYJ4RQx=3MbhD+AZTNHNWg@mail.gmail.com>
References: <1449796126-14906-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449796126-14906-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 10, 2015 at 7:08 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Initialize the uart_port spinlock of earlycon to avoid the BUG() when
> booting with spinlock debug enabled.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Same patch[1] should already be in Greg's queue.

Rob

[1] https://lkml.org/lkml/2015/11/27/165

> ---
>  drivers/tty/serial/earlycon.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index f09636083426..6c18891ad8d0 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -111,6 +111,8 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>         int err;
>         struct uart_port *port = &early_console_dev.port;
>
> +       spin_lock_init(&port->lock);
> +
>         /* On parsing error, pass the options buf to the setup function */
>         if (buf && !parse_options(&early_console_dev, buf))
>                 buf = NULL;
> @@ -202,6 +204,7 @@ int __init of_setup_earlycon(unsigned long addr,
>         int err;
>         struct uart_port *port = &early_console_dev.port;
>
> +       spin_lock_init(&port->lock);
>         port->iotype = UPIO_MEM;
>         port->mapbase = addr;
>         port->uartclk = BASE_BAUD * 16;
> --
> 2.4.2
>
