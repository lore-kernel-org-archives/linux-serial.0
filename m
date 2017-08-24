From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] tty: xilinx_uartps: move to arch_initcall for earlier
 console
Date: Thu, 24 Aug 2017 07:55:22 +0200
Message-ID: <d0343562-a2c6-aa6d-5b4f-6a18778546e8@xilinx.com>
References: <1503485752-12888-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503485752-12888-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com
List-Id: linux-serial@vger.kernel.org

On 23.8.2017 12:55, Shubhrajyoti Datta wrote:
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Empty commit message?
What's the reason for this change?

M

> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index ff1b115..a239343 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1647,7 +1647,7 @@ static void __exit cdns_uart_exit(void)
>  	uart_unregister_driver(&cdns_uart_uart_driver);
>  }
>  
> -module_init(cdns_uart_init);
> +arch_initcall(cdns_uart_init);
>  module_exit(cdns_uart_exit);
>  
>  MODULE_DESCRIPTION("Driver for Cadence UART");
> 
