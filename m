From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCHv2] tty: xilinx_uartps: move to arch_initcall for earlier
 console
Date: Wed, 20 Sep 2017 10:22:19 +0200
Message-ID: <61959fe3-48d0-f5b7-b508-c638b248e7f0@xilinx.com>
References: <1505890211-4851-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505890211-4851-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.com, gregkh@linuxfoundation.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com
List-Id: linux-serial@vger.kernel.org

On 20.9.2017 08:50, Shubhrajyoti Datta wrote:
> move to arch_initcall to get the console up really early, it is
> quite helpful for spotting early boot problems.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index fde55dc..96fda91 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1673,7 +1673,7 @@ static void __exit cdns_uart_exit(void)
>  	uart_unregister_driver(&cdns_uart_uart_driver);
>  }
>  
> -module_init(cdns_uart_init);
> +arch_initcall(cdns_uart_init);
>  module_exit(cdns_uart_exit);
>  
>  MODULE_DESCRIPTION("Driver for Cadence UART");
> 

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
