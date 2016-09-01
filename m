From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 5/7] serial: 8250_fintek: Add F81216 Support
Date: Thu, 1 Sep 2016 13:22:55 +0200
Message-ID: <CAPybu_19AgXA+Thc6sd-Zp-707P+u47xzJpcnFuJGTa9YvWYbA@mail.gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com> <1472701196-14795-6-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472701196-14795-6-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter

On Thu, Sep 1, 2016 at 5:39 AM, Ji-Ze Hong (Peter Hong)
<hpeter@gmail.com> wrote:

>  int fintek_8250_probe(struct uart_8250_port *uart)
>  {
>         struct fintek_8250 *pdata;
> @@ -248,8 +270,8 @@ int fintek_8250_probe(struct uart_8250_port *uart)
>                 return -ENOMEM;
>
>         memcpy(pdata, &probe_data, sizeof(probe_data));
> -       uart->port.rs485_config = fintek_8250_rs485_config;

Maybe just:


if (pdata->id != CHIP_ID_F81216)
   uart->port.rs485_config = fintek_8250_rs485_config;


Instead of the whole function

>         uart->port.private_data = pdata;
> +       fintek_8250_set_rs485_handler(uart);
>
>         return 0;
>  }
> --
> 1.9.1
>



-- 
Ricardo Ribalda
