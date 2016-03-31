From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v2] tty/serial/8250: fix RS485 half-duplex RX
Date: Thu, 31 Mar 2016 11:10:12 +0300
Message-ID: <CAJs94EYkZkgxvJd=i36DC5tuEmSE4fHKwdCE4HLWwKBvoisE-g@mail.gmail.com>
References: <1458806625-29300-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458806625-29300-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, bigeasy@linutronix.de, linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

2016-03-24 11:03 GMT+03:00  <yegorslists@googlemail.com>:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> When in half-duplex mode RX will be disabled before TX, but not
> enabled after deactivating transmitter. This patch enables
> UART_IER_RLSI and UART_IER_RDI interrupts after TX is over.
>
> Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")

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



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
