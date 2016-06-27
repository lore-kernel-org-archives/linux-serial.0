From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: fix the mismatched IRQ mode
Date: Mon, 27 Jun 2016 12:25:46 +0200
Message-ID: <CAPybu_2BM-Nm02Y6xv-jg0MMaNGuEgmG6=5S3OO3KuwDUPmHMg@mail.gmail.com>
References: <1464314571-15429-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464314571-15429-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Alan Cox <alan@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,. Hi Greg

On Fri, May 27, 2016 at 4:02 AM, Ji-Ze Hong (Peter Hong)
<hpeter@gmail.com> wrote:
>  {
>         struct fintek_8250 *pdata;
>         struct fintek_8250 probe_data;
> +       struct irq_data *irq_data = irq_get_irq_data(uart->port.irq);
> +       bool level_mode = irqd_is_level_type(irq_data);

I see a potential problem with this patch:

If irq_get_irq_data fails, it will return NULL, resulting on a
segmentation fault on irqd_is_level_type:



#define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)


I believe that we need to add error checks here

>
>         if (find_base_port(&probe_data, uart->port.iobase))
>                 return -ENODEV;
> @@ -192,5 +226,5 @@ int fintek_8250_probe(struct uart_8250_port *uart)
>         uart->port.rs485_config = fintek_8250_rs485_config;
>         uart->port.private_data = pdata;
>
> -       return 0;
> +       return fintek_8250_set_irq_mode(pdata, level_mode);

Also why do not call irq_get_irq_data() and  irqd_is_level_type()
before return? There is no need to do that work if the probe
determines that it is not a fintek chip.


Greg, this is already queued for 4.7.... what shall we do here?


Regards!




-- 
Ricardo Ribalda
