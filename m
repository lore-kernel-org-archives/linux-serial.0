From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH 0967/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 16:19:55 +0300
Message-ID: <CAJs94EZmP3tcZAHa3MFypSHCdrv7pSJKY=ENibt9Tj3U33u+CA@mail.gmail.com>
References: <20160802120332.14527-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802120332.14527-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, Peter Hurley <peter@hurleysoftware.com>, yamada.masahiro@socionext.com, wan.ahmad.zainie.wan.mohamad@intel.com, mail@maciej.szmigiero.name, chuansheng.liu@intel.com
List-Id: linux-serial@vger.kernel.org

Hello,

I believe that 0644 is shorter and easier to read and understand than
the long list of macros like S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
where it is easier to miss something.

2016-08-02 15:03 GMT+03:00 Baole Ni <baolex.ni@intel.com>:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 0fbd7c0..9309ec1 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1188,17 +1188,17 @@ module_exit(serial8250_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
>
> -module_param(share_irqs, uint, 0644);
> +module_param(share_irqs, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
>
> -module_param(nr_uarts, uint, 0644);
> +module_param(nr_uarts, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
>
> -module_param(skip_txen_test, uint, 0644);
> +module_param(skip_txen_test, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
>
>  #ifdef CONFIG_SERIAL_8250_RSA
> -module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
> +module_param_array(probe_rsa, ulong, &probe_rsa_count, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
>  #endif
>  MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
> --
> 2.9.2
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
