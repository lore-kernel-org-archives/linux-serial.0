From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2] tty/serial/8250: fix RS485 half-duplex RX
Date: Thu, 31 Mar 2016 07:22:54 +0200
Message-ID: <CAGm1_kvj3BaOZNTYDhGCaQK+hy-+wAYN=zNSnBz7f1PS6mHJAQ@mail.gmail.com>
References: <1458806625-29300-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458806625-29300-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kernel list <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>, "Matwey V. Kornilov" <matwey@sai.msu.ru>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 24, 2016 at 9:03 AM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> When in half-duplex mode RX will be disabled before TX, but not
> enabled after deactivating transmitter. This patch enables
> UART_IER_RLSI and UART_IER_RDI interrupts after TX is over.
>
> Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")

Transferring from Acked-by from v1:

Acked-by: Matwey V. Kornilov <matwey@sai.msu.ru>

> ---
> Changes:
>         v2: change subject and add 'Fixes' tag
>
>  drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e213da0..00ad263 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1403,9 +1403,18 @@ static void __do_stop_tx_rs485(struct uart_8250_port *p)
>         /*
>          * Empty the RX FIFO, we are not interested in anything
>          * received during the half-duplex transmission.
> +        * Enable previously disabled RX interrupts.
>          */
> -       if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +       if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
>                 serial8250_clear_fifos(p);
> +
> +               serial8250_rpm_get(p);
> +
> +               p->ier |= UART_IER_RLSI | UART_IER_RDI;
> +               serial_port_out(&p->port, UART_IER, p->ier);
> +
> +               serial8250_rpm_put(p);
> +       }
>  }
>
>  static void serial8250_em485_handle_stop_tx(unsigned long arg)
> --
> 2.1.4
>
