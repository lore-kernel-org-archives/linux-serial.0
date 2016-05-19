From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] serial: 8250_early: Add earlycon support for Synopsys
 DesignWare ABP UART
Date: Thu, 19 May 2016 09:45:33 +0800
Message-ID: <573D1ABD.5020908@huawei.com>
References: <1462946761-11982-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462946761-11982-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, Wei Xu <xuwei5@hisilicon.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jon Mason <jon.mason@broadcom.com>
List-Id: linux-serial@vger.kernel.org

+Cc Jon and arm-kernel mailist

Any comments, thanks.

Kefeng

On 2016/5/11 14:06, Kefeng Wang wrote:
> Some board like Hisilicon D02 uses Synopsys DesignWare ABP UART, declare an
> OF early console for it, so early console device can be enabled with comand
> line "earlycon"(without option) via the "stdout-path" property in device-tree.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index 8d08ff5..85a12f0 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -150,6 +150,7 @@ EARLYCON_DECLARE(uart, early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
> +OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
>  
>  #ifdef CONFIG_SERIAL_8250_OMAP
>  
> 
