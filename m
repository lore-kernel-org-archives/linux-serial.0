From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: Fix potential NULL pointer dereference
Date: Thu, 18 Aug 2016 18:22:38 +0200
Message-ID: <CAPybu_0yBVLaCHNNGV-xxPq2Ku0e7Q1LqjP=T1PgpHfUdYSjAg@mail.gmail.com>
References: <1467078390-2406-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467078390-2406-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Cox <alan@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter

Somehow this patch entered my mail limbo. Sorry about that.

Could you remove the brackets on the if/else? I think that for one
liners they are not recommended.

Also, I think it might be a good a idea to remove the __func__ from
the dev_warn.

Best regards!



On Tue, Jun 28, 2016 at 3:46 AM, Ji-Ze Hong (Peter Hong)
<hpeter@gmail.com> wrote:
> Fix potential NULL pointer dereference on
> 'commit 4da22f1418cb ("serial: 8250_fintek: fix the mismatched IRQ mode")'
>
> We try to fix IRQ mode mismatch issue and add the following code to
> detect IRQ Level or Edge mode.
>
> struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
> bool level_mode = irqd_is_level_type(irq_data);
>
> But *irq_data had not any check and pass to irqd_is_level_type(),
> it may lead to potential NULL pointer dereference.
>
> Also modify detecting IRQ mode when fintek chip found.
>
> Suggested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 737b4b3..9119d0c 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -212,8 +212,8 @@ int fintek_8250_probe(struct uart_8250_port *uart)
>  {
>         struct fintek_8250 *pdata;
>         struct fintek_8250 probe_data;
> -       struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
> -       bool level_mode = irqd_is_level_type(irq_data);
> +       struct irq_data *irq_data;
> +       bool level_mode = false; /* Default to Edge/High */
>
>         if (find_base_port(&probe_data, uart->port.iobase))
>                 return -ENODEV;
> @@ -226,5 +226,14 @@ int fintek_8250_probe(struct uart_8250_port *uart)
>         uart->port.rs485_config = fintek_8250_rs485_config;
>         uart->port.private_data = pdata;
>
> +       irq_data = irq_get_irq_data(uart->port.irq);
> +       if (irq_data) {
> +               level_mode = irqd_is_level_type(irq_data);
> +       } else {
> +               dev_warn(uart->port.dev,
> +                        "%s: Can't get irq_data, set this port to Edge/High",
> +                        __func__);
> +       }
> +
>         return fintek_8250_set_irq_mode(pdata, level_mode);
>  }
> --
> 1.9.1
>



-- 
Ricardo Ribalda
