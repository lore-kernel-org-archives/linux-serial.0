From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 7/7] serial: 8250_fintek: Add F81865 Support
Date: Thu, 1 Sep 2016 13:29:29 +0200
Message-ID: <CAPybu_0bUDRaZKKnEAqEsiBhwuVOqAT_ncWEvJ49BJueKcjH9g@mail.gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com> <1472701196-14795-8-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472701196-14795-8-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter



On Thu, Sep 1, 2016 at 5:39 AM, Ji-Ze Hong (Peter Hong)
<hpeter@gmail.com> wrote:

>
>         switch (pdata->pid) {
> +       case CHIP_ID_F81865:
>         case CHIP_ID_F81866:
> -               sio_write_mask_reg(pdata, F81866_FIFO_CTRL, F81866_IRQ_MODE1,
> -                                  0);
> +               if (pdata->pid == CHIP_ID_F81866)
> +                       sio_write_mask_reg(pdata, F81866_FIFO_CTRL,
> +                                          F81866_IRQ_MODE1, 0);
> +
>                 sio_write_mask_reg(pdata, F81866_IRQ_MODE, F81866_IRQ_SHARE,
>                                    F81866_IRQ_SHARE);
>                 sio_write_mask_reg(pdata, F81866_IRQ_MODE,


What about:


         case CHIP_ID_F81866:
               sio_write_mask_reg(pdata, F81866_FIFO_CTRL, F81866_IRQ_MODE1, 0);
                /* fall through */
        case CHIP_ID_F81865:
              sio_write_mask_reg(pdata, F81
.....

> @@ -312,6 +318,7 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
>         default: /* No RS485 Auto direction functional */
>                 break;
>
> +       case CHIP_ID_F81865:
>         case CHIP_ID_F81866:
>         case CHIP_ID_F81216AD:
>         case CHIP_ID_F81216H:
> --
> 1.9.1
>



-- 
Ricardo Ribalda
