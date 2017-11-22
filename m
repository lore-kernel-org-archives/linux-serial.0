From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250_fintek: Disable delays for ports != 0
Date: Wed, 22 Nov 2017 23:31:02 +0100
Message-ID: <CAPybu_3BdPHRxZwtGrtgHBbrQ+ABTeTB02BaLnXT+LP_1HPc6A@mail.gmail.com>
References: <20171106104913.2553-1-ricardo.ribalda@gmail.com> <20171106104913.2553-2-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106104913.2553-2-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

ping?


On Mon, Nov 6, 2017 at 11:49 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> According to the datasheet, only the first port supports delay before
> send and delay after send.
>
> Reported-by: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index ca7e96f9f080..61745d4bea31 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -216,6 +216,12 @@ static int fintek_8250_rs485_config(struct uart_port *port,
>         rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
>                         SER_RS485_RTS_AFTER_SEND;
>
> +       /* Only the first port supports delays */
> +       if (pdata->index) {
> +               rs485->delay_rts_before_send = 0;
> +               rs485->delay_rts_after_send = 0;
> +       }
> +
>         if (rs485->delay_rts_before_send) {
>                 rs485->delay_rts_before_send = 1;
>                 config |= TXW4C_IRA;
> --
> 2.14.2
>



-- 
Ricardo Ribalda
